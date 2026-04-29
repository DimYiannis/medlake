<template>
  <ServiceLayout>
    <template #title>{{ page?.title || '' }}</template>
    <template #intro>{{ page?.intro || '' }}</template>
    <template #body>
      <div class="space-y-10">
        <div class="space-y-5">
          <p class="text-[17px] leading-[1.85]" style="color:var(--text-2)">{{ page?.para1 || '' }}</p>
          <p class="text-[17px] leading-[1.85]" style="color:var(--text-2)">{{ page?.para2 || '' }}</p>
        </div>
        <div class="grid grid-cols-2 gap-px" style="background:var(--border)">
          <div v-for="f in focus" :key="f.label" class="px-7 py-6" style="background:var(--bg-card)">
            <p class="text-[13px] tracking-[0.18em] uppercase mb-2" style="color:var(--text-3)">{{ f.label }}</p>
            <p class="text-[16px] leading-[1.6]" style="color:var(--text-2)">{{ f.text }}</p>
          </div>
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
const page = await usePageContent('leistungen/physiotherapie')
useHead({ title: computed(() => page.value?.title ? `${page.value.title} – Medlake` : t('pages.leistungen.physiotherapie.meta')) })

const focus = computed(() => {
  const titles = (page.value?.focusTitles as string[]) || []
  const texts  = (page.value?.focusTexts as string[]) || []
  return titles.map((label, i) => ({ label, text: texts[i] || '' }))
})
</script>
