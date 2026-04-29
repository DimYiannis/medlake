<template>
  <ServiceLayout>
    <template #title>{{ page?.title || '' }}</template>
    <template #intro>{{ page?.intro || '' }}</template>
    <template #body>
      <div class="space-y-10">

        <div class="grid grid-cols-2 gap-px" style="background:var(--border)">
          <div v-for="(b, i) in benefits" :key="i" class="px-7 py-6" style="background:var(--bg-card)">
            <p class="text-[13px] tracking-[0.18em] uppercase mb-2" style="color:var(--text-3)">{{ b.title }}</p>
            <p class="text-[16px] leading-[1.7]" style="color:var(--text-2)">{{ b.text }}</p>
          </div>
        </div>

        <div class="space-y-5">
          <p v-for="p in paras" :key="p" class="text-[17px] leading-[1.85]" style="color:var(--text-2)">{{ p }}</p>
        </div>

      </div>
    </template>
  </ServiceLayout>
</template>

<script setup lang="ts">
const { t } = useI18n()
const page = await usePageContent('leistungen/krafttraining')
useHead({ title: computed(() => page.value?.title ? `${page.value.title} – Medlake` : t('pages.leistungen.krafttraining.meta')) })

const benefits = computed(() => {
  const titles = (page.value?.benefitTitles as string[]) || []
  const texts  = (page.value?.benefitTexts as string[]) || []
  return titles.map((title, i) => ({ title, text: texts[i] || '' }))
})
const paras = computed(() => (page.value?.paras as string[]) || [])
</script>
