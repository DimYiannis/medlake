const FALLBACK = [
  { id: 1, name: 'Krafttraining',                       description: 'Gesundheitsorientiertes Krafttraining führt zu einem besseren Allgemeinzustand. Mitverantwortlich für akute und chronische Schmerzen des Bewegungsapparates sind schwache Muskeln. Wir trainieren präzise, medizinisch begleitet — mit messbaren Ergebnissen.', icon: '/images/service-icon-6.png', link: '/leistungen/krafttraining',       sort_order: 1 },
  { id: 2, name: 'Herz & Kreislauf',                    description: 'Cardio-Training führt zur Ökonomisierung des Herzkreislaufsystems mit verbesserter Muskeldurchblutung. Trainierte Herzen schlagen ruhiger, kraftvoller, ausdauernder.',                                                                                                      icon: '/images/service-icon-7.png', link: '/leistungen/herz-kreislauf',      sort_order: 2 },
  { id: 3, name: 'Hilfe bei Schmerzen',                 description: 'Schmerzen im Nacken, Rücken und Gelenken werden von drei Spezialärzten mit computerisierten Kräftigungsgeräten behandelt — unterstützt von Physiotherapeutinnen.',                                                                                                               icon: '/images/service-icon-2.png', link: '/leistungen/hilfe-bei-schmerzen', sort_order: 3 },
  { id: 4, name: 'Firmenfitness',                       description: 'Ihr Beitrag zur Gesundheit Ihrer Mitarbeitenden. Profitieren Sie von unserer Firmen-Kooperation und investieren Sie in die Leistungsfähigkeit Ihres Teams.',                                                                                                                       icon: '/images/service-icon-5.png', link: '/leistungen/firmenfitness',       sort_order: 4 },
  { id: 5, name: 'Ärztliche Trainingstherapie (MED-X)', description: 'Computerisierte MedX-Geräte fördern den Muskelaufbau im Nacken- und Lendenbereich. Jede Therapieeinheit erfolgt in Einzelbehandlung mit dem Arzt.',                                                                                                                              icon: '/images/service-icon-8.png', link: '/leistungen/med-x',               sort_order: 5 },
  { id: 6, name: 'Physiotherapie & MTT',                description: 'Medizinische Trainingstherapie zur Steigerung der Belastbarkeit des Bewegungsapparates — individuell abgestimmt und von Krankenkassen anerkannt.',                                                                                                                                icon: '/images/service-icon-7.png', link: '/leistungen/physiotherapie',      sort_order: 6 },
  { id: 7, name: 'Galileo Vibrationsplatte',            description: 'Seitenalternierende Vibrationsbewegungen bringen Muskeln über Dehnreflexe zu vermehrten Kontraktionen — für Sport, Rehabilitation und Schmerztherapie.',                                                                                                                          icon: '/images/service-icon-3.png', link: '/leistungen/galileo',             sort_order: 7 },
  { id: 8, name: 'KINESIS Training',                    description: 'Einzigartiges Ganzkörpertraining durch Seilrollen-Widerstand. Kraft, Flexibilität, Koordination und Haltungskontrolle — alles in einem System.',                                                                                                                                  icon: '/images/service-icon-4.png', link: '/leistungen/kinesis',             sort_order: 8 },
]

export async function useServices() {
  const supabase = useSupabaseClient()
  const { data } = await useAsyncData('services', async () => {
    const { data, error } = await supabase
      .from('services')
      .select('*')
      .order('sort_order', { ascending: true })
    if (error || !data?.length) return FALLBACK
    return data
  })
  return data
}
