import { createClient } from '@supabase/supabase-js'

// Pinged daily by Vercel cron (see vercel.json) to keep the free-tier
// Supabase project active and prevent auto-pausing.
export default defineEventHandler(async () => {
  const config = useRuntimeConfig()
  const supabaseUrl = config.public.supabaseUrl as string
  const anonKey = config.public.supabaseAnonKey as string

  if (!supabaseUrl || !anonKey) {
    throw createError({ statusCode: 500, statusMessage: 'Supabase config missing' })
  }

  const supabase = createClient(supabaseUrl, anonKey)
  const { error } = await supabase.from('site_settings').select('key').limit(1)

  if (error) {
    throw createError({ statusCode: 502, statusMessage: `Supabase ping failed: ${error.message}` })
  }

  return { ok: true, pingedAt: new Date().toISOString() }
})
