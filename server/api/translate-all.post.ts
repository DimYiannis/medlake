import { createClient } from '@supabase/supabase-js'
import { translateFields, translateSections } from '../utils/translate'

const TARGET_LANGS = ['en', 'fr', 'it']

interface Body {
  table: string
  id: number
  fields: Record<string, string | string[]>
  htmlFields?: string[]
  sections?: Array<{ title: string; items: string[] }>
}

export default defineEventHandler(async (event) => {
  const config = useRuntimeConfig()
  const { table, id, fields, htmlFields = [], sections }: Body = await readBody(event)

  const apiKey = config.deeplApiKey as string
  const svcKey = config.supabaseServiceKey as string
  const supabaseUrl = config.public.supabaseUrl as string

  if (!apiKey || !svcKey || !supabaseUrl) return { ok: false, reason: 'missing config' }

  const admin = createClient(supabaseUrl, svcKey)

  const langResults = await Promise.all(
    TARGET_LANGS.map(async (lang) => {
      try {
        const [translated, translatedSections] = await Promise.all([
          translateFields(fields, htmlFields, lang, apiKey),
          sections?.length ? translateSections(sections, lang, apiKey) : Promise.resolve(null),
        ])
        return { lang, translated: { ...translated, ...(translatedSections ? { sections: translatedSections } : {}) } }
      } catch (e) {
        console.error(`[translate-all] ${lang} failed:`, e)
        return null
      }
    }),
  )

  const translations: Record<string, any> = {}
  for (const r of langResults) {
    if (r) translations[r.lang] = r.translated
  }

  const { error } = await admin.from(table).update({ translations }).eq('id', id)
  if (error) {
    console.error('[translate-all] DB save failed:', error.message)
    return { ok: false, reason: error.message }
  }

  return { ok: true, langs: Object.keys(translations) }
})
