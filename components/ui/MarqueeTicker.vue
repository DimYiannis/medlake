<template>
  <div class="overflow-hidden border-y border-ml-border py-4 bg-[#080808] select-none">
    <div class="marquee-track">
      <span
        v-for="(item, i) in [...items, ...items]"
        :key="i"
        class="inline-flex items-center gap-6 mx-8"
      >
        <span class="text-[10px] tracking-[0.25em] uppercase text-white/25 whitespace-nowrap">
          {{ item }}
        </span>
        <span class="inline-block w-1 h-1 rounded-full bg-white/10" />
      </span>
    </div>
  </div>
</template>

<script setup lang="ts">
const items = [
  'Krafttraining',
  'Physiotherapie',
  'MedX Therapie',
  'Galileo Vibration',
  'Herz & Kreislauf',
  'Firmenfitness',
  'Spezialärzte',
  'Kinesis Training',
  'Sensopro',
  'Rückentherapie',
]
</script>

<style scoped>
.marquee-track {
  display: inline-flex;
  white-space: nowrap;
  animation: marquee 30s linear infinite;
  will-change: transform;
}
@keyframes marquee {
  from { transform: translateX(0); }
  to   { transform: translateX(-50%); }
}
</style>
