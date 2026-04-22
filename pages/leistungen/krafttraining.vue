<template>
  <ServiceLayout>
    <template #title>Krafttraining</template>
    <template #intro>
      Ein gesundheitsorientiertes Krafttraining führt zu einem besseren Allgemeinzustand — und ist die wirksamste Prävention gegen chronische Schmerzen des Bewegungsapparates.
    </template>
    <template #body>
      <div class="space-y-10">

        <div class="grid grid-cols-2 gap-px" style="background:var(--border)">
          <div v-for="b in benefits" :key="b.title" class="px-7 py-6" style="background:var(--bg-card)">
            <p class="text-[13px] tracking-[0.18em] uppercase mb-2" style="color:var(--text-3)">{{ b.title }}</p>
            <p class="text-[16px] leading-[1.7]" style="color:var(--text-2)">{{ b.text }}</p>
          </div>
        </div>

        <div class="space-y-5">
          <p class="text-[17px] leading-[1.85]" style="color:var(--text-2)">
            Mitverantwortlich für akute und chronische Schmerzen des Bewegungsapparates sind immer schwache Muskeln, die bei zusätzlicher Fehlbelastung sowie Abnützungen an Gelenken, Sehnen oder Bandscheiben zu Verspannungen, Entzündung und letztlich Schmerzen führen.
          </p>
          <p class="text-[17px] leading-[1.85]" style="color:var(--text-2)">
            Ein Kraftzuwachs kompensiert den natürlichen Muskelabbau und bewirkt Stabilität an Gelenken und Wirbelsäule. Dadurch werden die schmerzenden Weichteile wie Bänder, Sehnen und Bandscheiben entlastet.
          </p>
          <p class="text-[17px] leading-[1.85]" style="color:var(--text-2)">
            Der Hauptnutzen des Trainings an Geräten liegt im dosierbaren Widerstand, der nach und nach vergrössert wird, bis die altersentsprechende Kraft erreicht wird. Krafttraining mit Geräten ist gelenkschonend, weil die Bewegung geführt wird. Eine kräftige Muskulatur hält den Menschen auch im Alter mobil und selbständig.
          </p>
        </div>

      </div>
    </template>
  </ServiceLayout>
</template>

<script setup lang="ts">
useHead({ title: 'Krafttraining – Medlake' })
const benefits = [
  { title: 'Kraftreserven',     text: 'Aufbau von Kraftreserven für Alltagsbelastungen und Sport.' },
  { title: 'Prävention',        text: 'Verhindert Nackenverspannungen, Rücken- und Gelenkbeschwerden.' },
  { title: 'Stoffwechsel',      text: 'Optimiert den Stoffwechsel und die Fettverbrennung.' },
  { title: 'Knochengesundheit', text: 'Stärkt den Knochen durch Stimulation der Knochendichte.' },
]
</script>
