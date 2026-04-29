export async function useJobs() {
  const supabase = useSupabaseClient()
  const { locale } = useI18n()

  const { data } = await useAsyncData(`jobs-${locale.value}`, async () => {
    const { data, error } = await supabase
      .from('jobs')
      .select('*')
      .eq('active', true)
      .order('created_at', { ascending: false })
    if (error) return []
    const jobs = data ?? []
    if (locale.value === 'de') return jobs

    return jobs.map((j: any) => {
      const cached = j.translations?.[locale.value]
      return cached ? { ...j, ...cached } : j
    })
  })
  return data
}
