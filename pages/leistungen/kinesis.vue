<template>
  <ServiceLayout>
    <template #title>KINESIS Training</template>
    <template #intro>
      KINESIS — griechisch für Bewegung. Einzigartiges Ganzkörpertraining durch Seilrollen-Widerstand gegen die Schwerkraft über einen sehr weiten Bewegungsradius.
    </template>
    <template #body>
      <div class="space-y-10">

        <div class="space-y-5">
          <p class="text-[17px] leading-[1.85]" style="color:var(--text-2)">
            Das auf Technogym KINESIS basierende Konzept heißt entsprechend „Full Gravity". Natürlich fliessende Übungsausführungen werden dadurch gezielt gefördert. KINESIS ist kein Ersatz für das konventionelle Training — vielmehr eine hocheffektive Ergänzung.
          </p>
          <p class="text-[17px] leading-[1.85]" style="color:var(--text-2)">
            Eine Vielzahl von Übungen auf engstem Raum ist an der Technogym KINESIS-Station möglich. So lässt sich mit minimalem Zeitbedarf eine grosse Bandbreite an sportlichen Zielen abdecken.
          </p>
        </div>

        <div class="grid grid-cols-2 gap-px" style="background:var(--border)">
          <div v-for="f in focus" :key="f.label" class="px-7 py-6" style="background:var(--bg-card)">
            <p class="text-[13px] tracking-[0.18em] uppercase mb-2" style="color:var(--text-3)">{{ f.label }}</p>
            <p class="text-[16px] leading-[1.6]" style="color:var(--text-2)">{{ f.text }}</p>
          </div>
        </div>

        <div class="px-7 py-6 border-l-2" style="border-color:var(--text-3);background:var(--bg-card)">
          <p class="text-[15px] tracking-[0.1em] uppercase mb-2" style="color:var(--text-3)">Für wen geeignet?</p>
          <p class="text-[17px] leading-[1.7]" style="color:var(--text-2)">
            Fortgeschrittene und ambitionierte Sportler können ein komplettes Trainingsprogramm durch spezielle Bewegungsformen durchführen. Im Rahmen der Physiotherapie wird die KINESIS-Station für gezieltes Training in der Rehabilitation eingesetzt.
          </p>
        </div>

      </div>
    </template>
  </ServiceLayout>
</template>

<script setup lang="ts">
useHead({ title: 'KINESIS Training – Medlake' })
const focus = [
  { label: 'Kraft',            text: 'Effizienter Muskelaufbau durch funktionelle Widerstände.' },
  { label: 'Flexibilität',     text: 'Gezielte Dehnübungen für alle Körperregionen.' },
  { label: 'Koordination',     text: 'Koordinierte Bewegungen mit Widerständen verbinden.' },
  { label: 'Haltungskontrolle', text: 'Training von Gleichgewicht und stabilisierender Muskulatur.' },
]
</script>
