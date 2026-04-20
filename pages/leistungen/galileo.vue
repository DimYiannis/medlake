<template>
  <ServiceLayout>
    <template #title>Galileo Vibrationsplatte</template>
    <template #intro>
      Seitenalternierende Vibrationsbewegungen bringen Muskeln über Dehnreflexe zu vermehrten Kontraktionen — präzise dosierbar für Sport, Rehabilitation und Schmerztherapie.
    </template>
    <template #body>
      <div class="space-y-10">

        <p class="text-[15px] leading-[1.85]" style="color:var(--text-2)">
          Die Stimulation lässt sich über die Zeitdauer, die Frequenzeinstellung sowie über die Fussposition und Körperhaltung individuell steigern und anpassen.
        </p>

        <div>
          <p class="text-[10px] tracking-[0.25em] uppercase mb-6" style="color:var(--text-3)">Einsatzgebiete</p>
          <div class="space-y-px" style="border-top:1px solid var(--border)">
            <div v-for="u in uses" :key="u" class="flex items-start gap-4 py-4 border-b" style="border-color:var(--border)">
              <span class="mt-1 w-1.5 h-1.5 rounded-full flex-shrink-0" style="background:var(--text-3)" />
              <p class="text-[14px] leading-[1.7]" style="color:var(--text-2)">{{ u }}</p>
            </div>
          </div>
        </div>

        <div class="border rounded-sm px-7 py-6" style="border-color:var(--border)">
          <p class="text-[10px] tracking-[0.25em] uppercase mb-5" style="color:var(--text-3)">Kontraindikationen</p>
          <div class="grid grid-cols-2 gap-3">
            <div v-for="c in contra" :key="c" class="flex items-start gap-3">
              <span class="mt-1 w-1.5 h-1.5 rounded-full flex-shrink-0" style="background:var(--text-4)" />
              <p class="text-[13px] leading-[1.6]" style="color:var(--text-3)">{{ c }}</p>
            </div>
          </div>
        </div>

      </div>
    </template>
  </ServiceLayout>
</template>

<script setup lang="ts">
useHead({ title: 'Galileo Vibrationsplatte – Medlake' })
const uses = [
  'Zusätzliches Hilfsmittel beim Leistungssport',
  'Intensivierung der Kräftigung im Training',
  'Rehabilitation nach Verletzung und schmerzhaften Zuständen',
  'Kniescheiben- oder Achillessehnenschmerzen',
  'Bewegungsschmerzhafte Arthrosen',
  'Chronifizierte Schmerzen',
  'Neurologische Erkrankungen wie MS, Parkinson, inkomplette Lähmungen',
]
const contra = [
  'Schwangerschaft',
  'Neue Implantate im Beinbereich',
  'Akute Thrombosen',
  'Epilepsie',
]
</script>
