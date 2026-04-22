<template>
  <ServiceLayout>
    <template #title>Herz & Kreislauf</template>
    <template #intro>
      Cardio-Training führt zur Ökonomisierung des Herzkreislaufsystems mit verbesserter Muskeldurchblutung — und kann in jedem Alter durchgeführt werden.
    </template>
    <template #body>
      <div class="space-y-10">

        <div>
          <p class="text-[12px] tracking-[0.25em] uppercase mb-6" style="color:var(--text-3)">Was ein trainiertes Herz-Kreislauf-System bewirkt</p>
          <div class="space-y-px" style="border-top:1px solid var(--border)">
            <div v-for="b in benefits" :key="b"
              class="flex items-start gap-4 py-4 border-b"
              style="border-color:var(--border)">
              <span class="mt-1 w-1.5 h-1.5 rounded-full flex-shrink-0" style="background:var(--text-3)" />
              <p class="text-[16px] leading-[1.7]" style="color:var(--text-2)">{{ b }}</p>
            </div>
          </div>
        </div>

        <p class="text-[17px] leading-[1.85]" style="color:var(--text-2)">
          Um im Alltag und Sport gute Leistungen vollbringen zu können, braucht es körperliche Ausdauer — einerseits um nicht vorzeitig zu ermüden, anderseits aber auch, um sich möglichst bald von den Strapazen erholen zu können.
        </p>

        <div class="px-7 py-6 border-l-2" style="border-color:var(--text-3);background:var(--bg-card)">
          <p class="text-[15px] tracking-[0.1em] uppercase mb-2" style="color:var(--text-3)">Empfehlung</p>
          <p class="text-[17px] leading-[1.7]" style="color:var(--text-2)">
            Ein gesundheitsorientiertes Kreislauftraining wird 1–2 Mal pro Woche während ca. 20 Minuten durchgeführt.
          </p>
        </div>

      </div>
    </template>
  </ServiceLayout>
</template>

<script setup lang="ts">
useHead({ title: 'Herz & Kreislauf – Medlake' })
const benefits = [
  'Tieferer Ruhepuls',
  'Grösseres Blutauswurfvolumen pro Herzschlag',
  'Gefässneubildungen in kräftigeren Muskeln',
  'Verbesserte Sauerstoffversorgung und Energiebereitstellung',
  'Schnellerer Abtransport von Abbaustoffen wie Milchsäure',
  'Mehr Ausdauer auch bei körperlicher Belastung',
  'Erhöhte Stresstoleranz',
  'Optimales Körpergewicht',
  'Bessere allgemeine Gesundheit',
]
</script>
