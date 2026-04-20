<template>
  <div class="min-h-screen pt-36 pb-24" style="background:var(--bg)">

    <div class="px-10 mb-16 border-b pb-12" style="border-color:var(--border)">
      <p class="text-[10px] tracking-[0.3em] uppercase mb-4" style="color:var(--text-3)">Medlake — Karriere</p>
      <h1 class="font-semibold tracking-[-0.025em] leading-none" style="font-size:clamp(40px,6vw,80px);color:var(--text)">
        Jobs
      </h1>
      <p class="text-[15px] mt-5 leading-[1.8] max-w-xl" style="color:var(--text-2)">
        Werde Teil unseres Teams im Kompetenzzentrum für Gesundheitsorientiertes Kraft- und Ausdauertraining in Küsnacht.
      </p>
    </div>

    <!-- Current job -->
    <div class="px-10 max-w-3xl">

      <div class="border-b pb-4 mb-10 flex items-center justify-between" style="border-color:var(--border)">
        <div>
          <p class="text-[10px] tracking-[0.2em] uppercase mb-1" style="color:var(--text-3)">Offene Stelle</p>
          <h2 class="text-[24px] font-medium" style="color:var(--text)">
            Praktikum — Spezialist Bewegungs- und Gesundheitsförderung
          </h2>
          <p class="text-[13px] mt-1" style="color:var(--text-3)">mit eidg. Fachausweis · ab 30.01.2026 oder nach Vereinbarung</p>
        </div>
      </div>

      <p class="text-[15px] leading-[1.85] mb-12" style="color:var(--text-2)">
        Du willst deine Leidenschaft für Fitness und Gesundheit zum Beruf und zu deiner Karriere machen? Dann bewirb dich jetzt für unser Praktikum in Küsnacht ZH.
      </p>

      <!-- Sections -->
      <div class="space-y-12">
        <div v-for="section in sections" :key="section.title">
          <p class="text-[10px] tracking-[0.25em] uppercase mb-5" style="color:var(--text-3)">{{ section.title }}</p>
          <div class="space-y-px" style="border-top:1px solid var(--border)">
            <div v-for="item in section.items" :key="item"
              class="flex gap-4 py-4 border-b" style="border-color:var(--border)">
              <span class="mt-1.5 w-1.5 h-1.5 rounded-full flex-shrink-0" style="background:var(--text-3)" />
              <p class="text-[14px] leading-[1.7]" style="color:var(--text-2)">{{ item }}</p>
            </div>
          </div>
        </div>
      </div>

      <!-- Apply -->
      <div class="mt-16 pt-12 border-t" style="border-color:var(--border)">
        <p class="text-[10px] tracking-[0.25em] uppercase mb-4" style="color:var(--text-3)">Bewerbung</p>
        <p class="text-[15px] leading-[1.8] mb-8" style="color:var(--text-2)">
          Sende deine vollständigen Bewerbungsunterlagen per E-Mail an uns. Wir freuen uns auf dich!
        </p>
        <a href="mailto:info@medlake.ch?subject=Bewerbung Praktikum"
          class="inline-flex items-center gap-3 text-[11px] tracking-[0.2em] uppercase px-7 py-4 font-medium transition-opacity hover:opacity-80"
          style="background:var(--btn-bg);color:var(--btn-text)">
          Jetzt bewerben
          <svg width="12" height="12" viewBox="0 0 12 12" fill="none"><path d="M1 6h10M6 1l5 5-5 5" stroke="currentColor" stroke-width="1" stroke-linecap="round" stroke-linejoin="round"/></svg>
        </a>
      </div>

    </div>
  </div>
</template>

<script setup lang="ts">
useHead({ title: 'Jobs – Medlake' })

const sections = [
  {
    title: 'Hauptaufgaben',
    items: [
      'Kundenbetreuung',
      'Beratung und Verkauf von Mitgliedschaften',
      'Erstellen von Trainingsplänen',
      'Durchführen von Probe- und Kontrolltraining',
      'Administrative Arbeiten am Empfang',
      'Verantwortung für Ordnung und Sauberkeit im Betrieb',
    ],
  },
  {
    title: 'Anforderungen',
    items: [
      'Alter 20–35 Jahre',
      'EFZ Abschluss oder Matura',
      'Sportlich mit persönlicher Erfahrung im Fitness / Sport',
      'Flexibel bezüglich Arbeitseinsätzen (Abend, Wochenende, Feiertage)',
      'Gute Deutschkenntnisse in Wort und Schrift, Englisch von Vorteil',
      'Pünktlichkeit, Zuverlässigkeit und Teamfähigkeit',
      'Dienstleistungsorientiert — gepflegtes Erscheinungsbild',
      'Talent, Menschen zu begeistern und zu motivieren',
    ],
  },
  {
    title: 'Was wir bieten',
    items: [
      'Ein freundliches, aufgestelltes und dynamisches Team',
      'Attraktive Anstellungsbedingungen',
      'Klare Strukturen und definierte Abläufe',
      'Abwechslungsreiche Tätigkeit in unserem Kompetenzzentrum',
      'Aus- und Weiterbildungsmöglichkeiten SAFS',
    ],
  },
]
</script>
