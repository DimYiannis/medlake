import { createClient } from '@supabase/supabase-js'
import { translateContent } from '../utils/translate'

const TARGET_LANGS = ['en', 'fr', 'it']

export default defineEventHandler(async (event) => {
  const config = useRuntimeConfig()
  const { id, content }: { id: number; content: Record<string, any> } = await readBody(event)

  const apiKey = config.deeplApiKey as string
  const svcKey = config.supabaseServiceKey as string
  const supabaseUrl = config.public.supabaseUrl as string

  if (!apiKey || !svcKey || !supabaseUrl) return { ok: false, reason: 'missing config' }

  const admin = createClient(supabaseUrl, svcKey)

  const langResults = await Promise.all(
    TARGET_LANGS.map(async (lang) => {
      try {
        const translated = await translateContent(content, lang, apiKey)
        return { lang, translated }
      } catch (e) {
        console.error(`[translate-page] ${lang} failed:`, e)
        return null
      }
    }),
  )

  const translations: Record<string, any> = {}
  for (const r of langResults) {
    if (r) translations[r.lang] = r.translated
  }

  const { error } = await admin.from('page_content').update({ translations }).eq('id', id)
  if (error) return { ok: false, reason: error.message }
  return { ok: true, langs: Object.keys(translations) }
})
