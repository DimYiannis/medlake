<template>
  <section ref="el" class="section-divider px-10 py-20">
    <div class="grid grid-cols-2 md:grid-cols-4 border-l" style="border-color:var(--border)">
      <div
        v-for="(stat, i) in stats"
        :key="stat.label"
        class="reveal border-r border-b px-8 py-10"
        :class="`reveal-delay-${i + 1}`"
        style="border-color:var(--border)"
      >
        <p class="font-semibold tracking-[-0.04em] leading-none mb-3" style="font-size:clamp(36px,5vw,68px);color:var(--text)">
          {{ stat.num }}
        </p>
        <p class="text-[13px] tracking-[0.12em] uppercase leading-[1.6] whitespace-pre-line" style="color:var(--text-3)">
          {{ stat.label }}
        </p>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
const { el } = useReveal()
const { t } = useI18n()
const stats = computed(() => [
  { num: '3',     label: t('stats.doctors') },
  { num: '20+',   label: t('stats.years') },
  { num: '06:30', label: t('stats.opening') },
  { num: '100%',  label: t('stats.medical') },
])
</script>
