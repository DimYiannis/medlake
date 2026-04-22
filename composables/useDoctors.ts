const FALLBACK = [
  {
    id: 1, name: 'Dr. med. Beat-Sven Maurer', role: 'Mitinhaber',
    specialty: 'Facharzt Allgemeine Medizin, Manuelle Medizin SAMM',
    phone: '044 910 35 10', photo_url: '/images/v5czwsk7.bmp',
    bio: ['Staatsexamen 1990 in Zürich','Ausbildung zum Facharzt für Allgemeine Medizin','Ausbildung in medizinischer Kräftigungstherapie GMKT an der Universität San Diego','Praxistätigkeit in Gemeinschaftspraxis in Küsnacht'],
    sort_order: 1,
  },
  {
    id: 2, name: 'Dr. med. Jiri Mach', role: 'Mitinhaber',
    specialty: 'Spezialarzt FMH Rheumatologie, Rücken und Gelenke. Manuelle Medizin SAMM, Ultraschall SGUM',
    phone: '044 991 24 34', photo_url: '/images/e3e88p6i.bmp',
    bio: ['Staatsexamen 1991 in Zürich und Tschechien','Ausbildung zum Facharzt für Rheumatologie FMH','1998 Ausbildung an der Universität Gainesville / Florida in medizinischer Kräftigungstherapie','2003 Beitritt in rheumatologische Gemeinschaftspraxis in Winterthur und Küsnacht, Seestrasse 39','Fähigkeitsausweis für manuelle Medizin SAMM sowie Ultraschall SGUM Gelenkdiagnostik'],
    sort_order: 2,
  },
]

export async function useDoctors() {
  const supabase = useSupabaseClient()
  const { locale } = useI18n()
  const apiFetch = useRequestFetch()

  const { data } = await useAsyncData(`doctors-${locale.value}`, async () => {
    const { data, error } = await supabase
      .from('doctors')
      .select('*')
      .order('sort_order', { ascending: true })
    const doctors = (error || !data?.length) ? FALLBACK : data
    if (locale.value === 'de') return doctors

    return Promise.all(doctors.map(async (d: any) => {
      const cached = d.translations?.[locale.value]
      if (cached) return { ...d, ...cached }
      try {
        const tr = await apiFetch<any>('/api/translate-record', {
          method: 'POST',
          body: {
            table: 'doctors', id: d.id, targetLang: locale.value,
            fields: { specialty: d.specialty, bio: d.bio ?? [] },
          },
        })
        return tr ? { ...d, ...tr } : d
      } catch { return d }
    }))
  })
  return data
}
