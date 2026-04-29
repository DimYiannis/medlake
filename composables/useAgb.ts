export async function useAgb() {
  const supabase = useSupabaseClient()
  const { locale } = useI18n()

  const { data } = await useAsyncData(`agb-${locale.value}`, async () => {
    const { data } = await supabase.from('agb').select('*').single()
    if (!data) return [] as string[]
    if (locale.value === 'de') return data.articles as string[]
    const cached = (data.translations as Record<string, any>)?.[locale.value]
    return ((cached?.articles ?? data.articles) as string[])
  })
  return data
}
