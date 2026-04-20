<template>
  <ServiceLayout>
    <template #title>Hilfe bei Schmerzen</template>
    <template #intro>
      Schmerzen im Nacken, Rücken und Gelenken werden im Medlake Center von drei Spezialärzten mit modernsten und computerisierten Kräftigungsgeräten behandelt — unterstützt von Physiotherapeutinnen.
    </template>
    <template #body>
      <div class="space-y-10">

        <div class="grid grid-cols-1 md:grid-cols-3 gap-px" style="background:var(--border)">
          <div v-for="s in stats" :key="s.num" class="px-7 py-8 text-center" style="background:var(--bg-card)">
            <p class="font-semibold tracking-[-0.03em] leading-none mb-2" style="font-size:clamp(28px,4vw,48px);color:var(--text)">{{ s.num }}</p>
            <p class="text-[11px] tracking-[0.15em] uppercase" style="color:var(--text-3)">{{ s.label }}</p>
          </div>
        </div>

        <div class="space-y-5">
          <p class="text-[15px] leading-[1.85]" style="color:var(--text-2)">
            Es steht eine integrierte Arzt- und Physiotherapiepraxis zur Behandlung und für Notfälle zur Verfügung.
          </p>
          <p class="text-[15px] leading-[1.85]" style="color:var(--text-2)">
            Sie finden auf 540 m² einen grossen MedX-Gerätepark mit hochwertigen Rückengeräten sowie in einem separaten Raum hochwertige LIFEFITNESS Liegevelos, Bikes und Crosstrainer.
          </p>
        </div>

        <div class="px-7 py-6 border-l-2" style="border-color:var(--text-3);background:var(--bg-card)">
          <p class="text-[13px] tracking-[0.1em] uppercase mb-2" style="color:var(--text-3)">Krankenkasse</p>
          <p class="text-[15px] leading-[1.7]" style="color:var(--text-2)">
            Die Therapiekosten werden von allen Krankenkassen bezahlt. Für ein Jahresabonnement wird ein Kostenanteil übernommen.
          </p>
        </div>

      </div>
    </template>
  </ServiceLayout>
</template>

<script setup lang="ts">
useHead({ title: 'Hilfe bei Schmerzen – Medlake' })
const stats = [
  { num: '3',    label: 'Spezialärzte vor Ort' },
  { num: '540m²', label: 'Trainingsfläche' },
  { num: '100%', label: 'Krankenkassendeckung' },
]
</script>
