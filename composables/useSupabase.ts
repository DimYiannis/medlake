import { createClient } from '@supabase/supabase-js'

let _client: ReturnType<typeof createClient> | null = null

export function useSupabase() {
  const config = useRuntimeConfig()

  if (!_client) {
    _client = createClient(
      config.public.supabaseUrl,
      config.public.supabaseAnonKey
    )
  }

  return _client
}
