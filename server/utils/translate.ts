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
