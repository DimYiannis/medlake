<template>
  <ServiceLayout>
    <template #title>{{ page?.title || '' }}</template>
    <template #intro>{{ page?.intro || '' }}</template>
    <template #body>
      <div class="space-y-10">
        <p class="text-[17px] leading-[1.85]" style="color:var(--text-2)">{{ page?.para || '' }}</p>
        <div>
          <p class="text-[12px] tracking-[0.25em] uppercase mb-6" style="color:var(--text-3)">{{ page?.usesLabel || '' }}</p>
          <div class="space-y-px" style="border-top:1px solid var(--border)">
            <div v-for="u in uses" :key="u" class="flex items-start gap-4 py-4 border-b" style="border-color:var(--border)">
              <span class="mt-1 w-1.5 h-1.5 rounded-full flex-shrink-0" style="background:var(--text-3)" />
              <p class="text-[16px] leading-[1.7]" style="color:var(--text-2)">{{ u }}</p>
            </div>
          </div>
        </div>
        <div class="border rounded-sm px-7 py-6" style="border-color:var(--border)">
          <p class="text-[12px] tracking-[0.25em] uppercase mb-5" style="color:var(--text-3)">{{ page?.contraLabel || '' }}</p>
          <div class="grid grid-cols-2 gap-3">
            <div v-for="c in contra" :key="c" class="flex items-start gap-3">
              <span class="mt-1 w-1.5 h-1.5 rounded-full flex-shrink-0" style="background:var(--text-4)" />
              <p class="text-[15px] leading-[1.6]" style="color:var(--text-3)">{{ c }}</p>
            </div>
          </div>
        </div>
      </div>
    </template>
  </ServiceLayout>
</template>

<script setup lang="ts">
const { t } = useI18n()
const page = await usePageContent('leistungen/galileo')
useHead({ title: computed(() => page.value?.title ? `${page.value.title} – Medlake` : t('pages.leistungen.galileo.meta')) })

const uses   = computed(() => (page.value?.uses as string[]) || [])
const contra = computed(() => (page.value?.contra as string[]) || [])
</script>
