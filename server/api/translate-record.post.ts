import { createClient } from '@supabase/supabase-js'
import { translateFields } from '../utils/translate'

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
  const svcKey = config.supabaseServiceKey as string
  const supabaseUrl = config.public.supabaseUrl as string

  // Return cached translation from DB without calling DeepL
  if (svcKey && supabaseUrl) {
    const admin = createClient(supabaseUrl, svcKey)
    const { data: row } = await admin.from(table).select('translations').eq('id', id).single()
    const cached = (row?.translations as Record<string, any>)?.[targetLang]
    if (cached) return cached
  }

  if (!apiKey) return null

  const translated = await translateFields(fields, htmlFields, targetLang, apiKey)

  // Save to Supabase translations cache
  if (svcKey && supabaseUrl) {
    try {
      const admin = createClient(supabaseUrl, svcKey)
      const { data: row } = await admin.from(table).select('translations').eq('id', id).single()
      const existing = (row?.translations as Record<string, any>) ?? {}
      const { error } = await admin.from(table).update({
        translations: { ...existing, [targetLang]: translated },
      }).eq('id', id)
      if (error) console.error('[translate-record] save failed:', error.message)
    } catch (e) { console.error('[translate-record] save error:', e) }
  }

  return translated
})
