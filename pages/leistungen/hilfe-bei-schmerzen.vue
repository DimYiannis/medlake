<template>
  <ServiceLayout>
    <template #title>{{ page?.title || '' }}</template>
    <template #intro>{{ page?.intro || '' }}</template>
    <template #body>
      <div class="space-y-10">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-px" style="background:var(--border)">
          <div v-for="(s, i) in stats" :key="i" class="px-7 py-8 text-center" style="background:var(--bg-card)">
            <p class="font-semibold tracking-[-0.03em] leading-none mb-2" style="font-size:clamp(28px,4vw,48px);color:var(--text)">{{ s.num }}</p>
            <p class="text-[13px] tracking-[0.15em] uppercase" style="color:var(--text-3)">{{ s.label }}</p>
          </div>
        </div>
        <div class="space-y-5">
          <p class="text-[17px] leading-[1.85]" style="color:var(--text-2)">{{ page?.para1 || '' }}</p>
          <p class="text-[17px] leading-[1.85]" style="color:var(--text-2)">{{ page?.para2 || '' }}</p>
        </div>
        <div class="px-7 py-6 border-l-2" style="border-color:var(--text-3);background:var(--bg-card)">
          <p class="text-[15px] tracking-[0.1em] uppercase mb-2" style="color:var(--text-3)">{{ page?.insuranceLabel || '' }}</p>
          <p class="text-[17px] leading-[1.7]" style="color:var(--text-2)">{{ page?.insuranceText || '' }}</p>
        </div>
      </div>
    </template>
  </ServiceLayout>
</template>

<script setup lang="ts">
const { t } = useI18n()
const page = await usePageContent('leistungen/hilfe-bei-schmerzen')
useHead({ title: computed(() => page.value?.title ? `${page.value.title} – Medlake` : t('pages.leistungen.hilfeSchmerzen.meta')) })

const statNums = ['3', '540m²', '100%']
const stats = computed(() => {
  const labels = (page.value?.statLabels as string[]) || []
  return statNums.map((num, i) => ({ num, label: labels[i] || '' }))
})
</script>
