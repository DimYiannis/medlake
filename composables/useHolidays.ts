export async function useHolidays() {
  const supabase = useSupabaseClient()
  const { data } = await useAsyncData('holidays', async () => {
    const { data, error } = await supabase
      .from('holidays')
      .select('*')
      .order('sort_order', { ascending: true })
    if (error || !data?.length) return []
    // group by year
    const grouped: Record<string, { year: string; entries: typeof data }> = {}
    for (const row of data) {
      if (!grouped[row.year]) grouped[row.year] = { year: row.year, entries: [] }
      grouped[row.year].entries.push(row)
    }
    return Object.values(grouped)
  })
  return data
}
