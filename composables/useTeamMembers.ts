const FALLBACK = [
  { id: 1, name: 'Andrea Badstuber',      role: 'Geschäftsführerin / Mitinhaberin', photo_url: '/images/andrea.jpg',   sort_order: 1 },
  { id: 2, name: 'Leonardo Tomazini',     role: 'Stv. Geschäftsführer',             photo_url: '/images/tomazini.jpg',  sort_order: 2 },
  { id: 3, name: 'Tiffany Ismann',        role: 'Fitnessinstruktorin',              photo_url: '/images/tiffany.png',   sort_order: 3 },
  { id: 4, name: 'Natalie Oriet Rota',    role: 'Spezialistin Bewegungs- und Gesundheitsförderung',  photo_url: '/images/natalie.jpg',   sort_order: 4 },
  { id: 5, name: 'Alexandros Dimopoulos', role: 'Bachelor-Abschluss in Sportwissenschaft',    photo_url: '/images/alex.jpg',      sort_order: 5 },
  { id: 6, name: 'Florence Winkler',      role: 'Spezialistin Bewegung– und Gesundheitsförderung mit eidg. Fachausweisess',   sort_order: 6 },
  { id: 7, name: 'Junioh Kamara',         role: 'Fachmann Bewegungs- und Gesundheitsförderung',  photo_url: null,                    sort_order: 7 },
]

export async function useTeamMembers() {
  const supabase = useSupabaseClient()
  const { data } = await useAsyncData('team-members', async () => {
    const { data, error } = await supabase
      .from('team_members')
      .select('*')
      .order('sort_order', { ascending: true })
    if (error || !data?.length) return FALLBACK
    return data
  })
  return data
}
