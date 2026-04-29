export const DEEPL_ENDPOINT = 'https://api-free.deepl.com/v2/translate'

type Fields = Record<string, string | string[]>

export async function translateFields(
  fields: Fields,
  htmlFields: string[],
  targetLang: string,
  apiKey: string,
): Promise<Fields> {
  type Entry = { key: string; isArray: boolean; len?: number; html: boolean }
  const entries: Entry[] = []
  const texts: string[] = []

  for (const [key, val] of Object.entries(fields)) {
    if (Array.isArray(val)) {
      val.forEach(v => texts.push(v ?? ''))
      entries.push({ key, isArray: true, len: val.length, html: false })
    } else {
      texts.push(val ?? '')
      entries.push({ key, isArray: false, html: htmlFields.includes(key) })
    }
  }

  const plainTexts: string[] = []
  const htmlTexts: string[] = []
  const textKind: boolean[] = []

  let flat = 0
  for (const e of entries) {
    const count = e.isArray ? (e.len ?? 0) : 1
    for (let j = 0; j < count; j++) {
      if (e.html) { htmlTexts.push(texts[flat]); textKind.push(true) }
      else { plainTexts.push(texts[flat]); textKind.push(false) }
      flat++
    }
  }

  const request = async (textArr: string[], tagHandling?: string) => {
    if (!textArr.length) return [] as string[]
    const body: Record<string, any> = { text: textArr, target_lang: targetLang.toUpperCase(), source_lang: 'DE' }
    if (tagHandling) body.tag_handling = tagHandling
    const res = await $fetch<{ translations: Array<{ text: string }> }>(DEEPL_ENDPOINT, {
      method: 'POST',
      headers: { Authorization: `DeepL-Auth-Key ${apiKey}`, 'Content-Type': 'application/json' },
      body: JSON.stringify(body),
    })
    return res.translations.map(t => t.text)
  }

  const [plainResults, htmlResults] = await Promise.all([request(plainTexts), request(htmlTexts, 'html')])

  const translated: Fields = {}
  let pi = 0, hi = 0, pos = 0
  for (const e of entries) {
    const count = e.isArray ? (e.len ?? 0) : 1
    const results: string[] = []
    for (let j = 0; j < count; j++) {
      results.push(textKind[pos++] ? htmlResults[hi++] : plainResults[pi++])
    }
    translated[e.key] = e.isArray ? results : results[0]
  }

  return translated
}

export async function translateSections(
  sections: Array<{ title: string; items: string[] }>,
  targetLang: string,
  apiKey: string,
): Promise<Array<{ title: string; items: string[] }>> {
  if (!sections.length) return []

  const texts: string[] = []
  const structure: Array<{ titleIdx: number; start: number; end: number }> = []

  for (const s of sections) {
    const titleIdx = texts.length
    texts.push(s.title ?? '')
    const start = texts.length
    ;(s.items ?? []).forEach(item => texts.push(item))
    structure.push({ titleIdx, start, end: texts.length })
  }

  const res = await $fetch<{ translations: Array<{ text: string }> }>(DEEPL_ENDPOINT, {
    method: 'POST',
    headers: { Authorization: `DeepL-Auth-Key ${apiKey}`, 'Content-Type': 'application/json' },
    body: JSON.stringify({ text: texts, target_lang: targetLang.toUpperCase(), source_lang: 'DE' }),
  })
  const out = res.translations.map(t => t.text)

  return structure.map(({ titleIdx, start, end }) => ({
    title: out[titleIdx],
    items: out.slice(start, end),
  }))
}

export async function translateContent(
  content: Record<string, any>,
  targetLang: string,
  apiKey: string,
): Promise<Record<string, any>> {
  const texts: string[] = []
  const paths: (string | number)[][] = []

  function collect(val: any, path: (string | number)[]) {
    if (typeof val === 'string' && val.trim()) {
      paths.push(path)
      texts.push(val)
    } else if (Array.isArray(val)) {
      val.forEach((v, i) => collect(v, [...path, i]))
    } else if (val && typeof val === 'object') {
      for (const [k, v] of Object.entries(val)) collect(v, [...path, k])
    }
  }

  collect(content, [])
  if (!texts.length) return content

  const res = await $fetch<{ translations: Array<{ text: string }> }>(DEEPL_ENDPOINT, {
    method: 'POST',
    headers: { Authorization: `DeepL-Auth-Key ${apiKey}`, 'Content-Type': 'application/json' },
    body: JSON.stringify({ text: texts, target_lang: targetLang.toUpperCase(), source_lang: 'DE' }),
  })
  const translated = res.translations.map(t => t.text)

  function assign(obj: any, path: (string | number)[], value: string): any {
    if (!path.length) return value
    const [key, ...rest] = path
    if (Array.isArray(obj)) {
      const arr = [...obj]
      arr[key as number] = assign(arr[key as number], rest, value)
      return arr
    }
    return { ...obj, [key as string]: assign((obj as Record<string, any>)[key as string], rest, value) }
  }

  let result: Record<string, any> = JSON.parse(JSON.stringify(content))
  paths.forEach((path, i) => { result = assign(result, path, translated[i]) as Record<string, any> })
  return result
}
