<template>
  <section ref="el" class="section-divider px-10 py-20">
    <div class="grid grid-cols-2 md:grid-cols-4 border-l border-ml-border">
      <div
        v-for="(stat, i) in stats"
        :key="stat.label"
        class="reveal border-r border-b border-ml-border px-8 py-10"
        :class="`reveal-delay-${i + 1}`"
      >
        <p class="text-[clamp(36px,5vw,68px)] font-semibold tracking-[-0.04em] leading-none text-white mb-3">
          {{ stat.num }}
        </p>
        <p class="text-[11px] tracking-[0.12em] uppercase text-white/30 leading-[1.6]">
          {{ stat.label }}
        </p>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
const { el } = useReveal()

const stats = [
  { num: '3',    label: 'Spezialärzte\nvor Ort' },
  { num: '20+',  label: 'Jahre\nErfahrung' },
  { num: '06:30', label: 'Öffnung\nMo – Fr' },
  { num: '100%', label: 'Medizinisch\nbegleitet' },
]
</script>
