export async function useJobs() {
  const supabase = useSupabaseClient()
  const { data } = await useAsyncData('jobs', async () => {
    const { data, error } = await supabase
      .from('jobs')
      .select('*')
      .eq('active', true)
      .order('created_at', { ascending: false })
    if (error) return []
    return data ?? []
  })
  return data
}
