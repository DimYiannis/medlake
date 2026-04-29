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
        <div class="px-7 py-6 border-l-2" style="border-color:var(--text-3);background:var(--bg-card)">
          <p class="text-[15px] tracking-[0.1em] uppercase mb-2" style="color:var(--text-3)">{{ page?.analysisLabel || '' }}</p>
          <p class="text-[17px] leading-[1.7]" style="color:var(--text-2)">{{ page?.analysisText || '' }}</p>
        </div>
        <div>
          <p class="text-[12px] tracking-[0.25em] uppercase mb-4" style="color:var(--text-3)">{{ page?.indicationsLabel || '' }}</p>
          <div class="space-y-px" style="border-top:1px solid var(--border)">
            <div v-for="ind in indications" :key="ind" class="flex items-start gap-4 py-4 border-b" style="border-color:var(--border)">
              <span class="mt-1 w-1.5 h-1.5 rounded-full flex-shrink-0" style="background:var(--text-3)" />
              <p class="text-[16px] leading-[1.7]" style="color:var(--text-2)">{{ ind }}</p>
            </div>
          </div>
        </div>
      </div>
    </template>
  </ServiceLayout>
</template>

<script setup lang="ts">
const { t } = useI18n()
const page = await usePageContent('leistungen/med-x')
useHead({ title: computed(() => page.value?.title ? `${page.value.title} – Medlake` : t('pages.leistungen.medX.meta')) })

const indications = computed(() => (page.value?.indications as string[]) || [])
</script>
