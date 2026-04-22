import { createClient } from '@supabase/supabase-js'

interface Body {
  table: string
  id: number
  targetLang: string
  fields: Record<string, string | string[]>
  htmlFields?: string[]
}

export default defineEventHandler(async (event) => {
  const config = useRuntimeConfig()
  const { table, id, targetLang, fields, htmlFields = [] }: Body = await readBody(event)

  const apiKey = config.deeplApiKey as string
  if (!apiKey) return null

  // Flatten all texts for one DeepL call
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

  const nonHtmlTexts = texts.filter((_, i) => {
    let idx = 0
    for (const e of entries) {
      if (e.isArray) {
        for (let j = 0; j < (e.len ?? 0); j++) {
          if (idx === i) return !e.html
          idx++
        }
      } else {
        if (idx === i) return !e.html
        idx++
      }
    }
    return true
  })

  // DeepL: translate all in one request (plain text)
  const deeplEndpoint = 'https://api-free.deepl.com/v2/translate'
  const translated: Record<string, string | string[]> = {}

  const makeRequest = async (textArr: string[], tagHandling?: string) => {
    if (!textArr.length) return [] as string[]
    const body: Record<string, any> = {
      text: textArr,
      target_lang: targetLang.toUpperCase(),
      source_lang: 'DE',
    }
    if (tagHandling) body.tag_handling = tagHandling
    const res = await $fetch<{ translations: Array<{ text: string }> }>(deeplEndpoint, {
      method: 'POST',
      headers: { Authorization: `DeepL-Auth-Key ${apiKey}`, 'Content-Type': 'application/json' },
      body: JSON.stringify(body),
    })
    return res.translations.map(t => t.text)
  }

  // Separate HTML and plain fields
  const plainTexts: string[] = []
  const htmlTexts: string[] = []
  const textKind: boolean[] = [] // true = html

  let flat = 0
  for (const e of entries) {
    const count = e.isArray ? (e.len ?? 0) : 1
    for (let j = 0; j < count; j++) {
      if (e.html) {
        htmlTexts.push(texts[flat])
        textKind.push(true)
      } else {
        plainTexts.push(texts[flat])
        textKind.push(false)
      }
      flat++
    }
  }

  const [plainResults, htmlResults] = await Promise.all([
    makeRequest(plainTexts),
    makeRequest(htmlTexts, 'html'),
  ])

  let plainIdx = 0
  let htmlIdx = 0
  let textPos = 0
  for (const e of entries) {
    const count = e.isArray ? (e.len ?? 0) : 1
    const results: string[] = []
    for (let j = 0; j < count; j++) {
      if (textKind[textPos]) {
        results.push(htmlResults[htmlIdx++])
      } else {
        results.push(plainResults[plainIdx++])
      }
      textPos++
    }
    translated[e.key] = e.isArray ? results : results[0]
  }

  // Cache in Supabase via service key
  const svcKey = config.supabaseServiceKey as string
  const supabaseUrl = config.public.supabaseUrl as string
  if (svcKey && supabaseUrl) {
    try {
      const admin = createClient(supabaseUrl, svcKey)
      const { data: row } = await admin.from(table).select('translations').eq('id', id).single()
      const existing = (row?.translations as Record<string, any>) ?? {}
      await admin.from(table).update({
        translations: { ...existing, [targetLang]: translated },
      }).eq('id', id)
    } catch (_) { /* non-fatal */ }
  }

  return translated
})
