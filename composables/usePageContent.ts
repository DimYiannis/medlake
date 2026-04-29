export async function usePageContent(slug: string) {
  const supabase = useSupabaseClient()
  const { locale } = useI18n()

  const { data } = await useAsyncData(`page-${slug}-${locale.value}`, async () => {
    const { data } = await supabase.from('page_content').select('*').eq('slug', slug).single()
    if (!data) return null as Record<string, any> | null
    if (locale.value === 'de') return data.content as Record<string, any>
    const cached = (data.translations as Record<string, any>)?.[locale.value]
    return (cached ?? data.content) as Record<string, any>
  })
  return data
}
