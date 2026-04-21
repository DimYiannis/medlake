const DEFAULTS = {
  hero_title_1:  'Die Kraft',
  hero_title_2:  'zu heilen. Die Kraft zu bewegen.',
  hero_subtitle: 'Medizinisches Kompetenzzentrum für gesundheitsorientiertes Kraft- und Ausdauertraining.',
  hero_eyebrow:  'Küsnacht, Schweiz — seit 2001',
  opening_hours: [
    { day: 'Montag – Freitag',  time: '06:30 – 21:00', link: null },
    { day: 'Samstag – Sonntag', time: '08:00 – 18:00', link: null },
    { day: 'Feiertage',         time: 'Variabel →',    link: '/feiertage' },
  ],
  contact: {
    address: 'Seestrasse 39, 8700 Küsnacht',
    phone:   '+41 44 991 22 02',
    fax:     '+41 44 991 22 03',
    email:   'info@medlake.ch',
  },
  services: [] as { name: string; desc: string }[],
}

export type SiteSettings = typeof DEFAULTS

export async function useSiteSettings() {
  const supabase = useSupabaseClient()
  const { data } = await useAsyncData('site-settings', async () => {
    const { data, error } = await supabase
      .from('site_settings')
      .select('value')
      .eq('key', 'main')
      .single()
    if (error || !data) return DEFAULTS
    return { ...DEFAULTS, ...data.value } as SiteSettings
  })
  return data
}
