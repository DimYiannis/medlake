<template>
  <ServiceLayout>
    <template #title>Physiotherapie & MTT</template>
    <template #intro>
      Medizinische Trainingstherapie zur Steigerung der Belastbarkeit des Bewegungsapparates — individuell abgestimmt, therapeutisch begleitet, krankenkassenanerkannt.
    </template>
    <template #body>
      <div class="space-y-10">

        <div class="space-y-5">
          <p class="text-[17px] leading-[1.85]" style="color:var(--text-2)">
            MTT wird zur Steigerung der Belastbarkeit des Bewegungsapparates eingesetzt. Mittels Kraft, Ausdauer, Mobilisation, Beweglichkeit und Koordination werden der Bewegungsapparat und der Herzkreislauf trainiert. Dieses Training wird zur Unterstützung von Rehabilitationsprozessen eingesetzt.
          </p>
          <p class="text-[17px] leading-[1.85]" style="color:var(--text-2)">
            Das Trainingsprogramm wird von einem Physiotherapeuten erstellt und individuell auf den Patienten abgestimmt — unter Berücksichtigung medizinischer Diagnosen, der aktuellen Rehabilitationsphase und der körperlichen Voraussetzungen.
          </p>
        </div>

        <div class="grid grid-cols-2 gap-px" style="background:var(--border)">
          <div v-for="f in focus" :key="f.label" class="px-7 py-6" style="background:var(--bg-card)">
            <p class="text-[13px] tracking-[0.18em] uppercase mb-2" style="color:var(--text-3)">{{ f.label }}</p>
            <p class="text-[16px] leading-[1.6]" style="color:var(--text-2)">{{ f.text }}</p>
          </div>
        </div>

        <div class="px-7 py-6 border-l-2" style="border-color:var(--text-3);background:var(--bg-card)">
          <p class="text-[15px] tracking-[0.1em] uppercase mb-2" style="color:var(--text-3)">Krankenkasse & Verordnung</p>
          <p class="text-[17px] leading-[1.7]" style="color:var(--text-2)">
            Eine MTT-Verordnung wird von Ihrem Arzt ausgestellt und dauert 3 Monate. Die Kosten werden in der Regel von der Grundversicherung oder der Unfallversicherung übernommen. Wir empfehlen nach Ablauf der Verordnung, das Training bei uns fortzuführen.
          </p>
        </div>

      </div>
    </template>
  </ServiceLayout>
</template>

<script setup lang="ts">
useHead({ title: 'Physiotherapie & MTT – Medlake' })
const focus = [
  { label: 'Kraft',         text: 'Gezielter Aufbau der Muskulatur im betroffenen Bereich.' },
  { label: 'Ausdauer',      text: 'Verbesserung der kardiovaskulären Belastbarkeit.' },
  { label: 'Mobilisation',  text: 'Wiederherstellung des vollen Bewegungsumfangs.' },
  { label: 'Koordination',  text: 'Training neuromuskulärer Steuerung und Stabilität.' },
]
</script>
