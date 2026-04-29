<template>
  <ServiceLayout>
    <template #title>{{ page?.title || '' }}</template>
    <template #intro>{{ page?.intro || '' }}</template>
    <template #body>
      <div class="space-y-10">
        <div>
          <p class="text-[12px] tracking-[0.25em] uppercase mb-6" style="color:var(--text-3)">{{ page?.benefitsLabel || '' }}</p>
          <div class="space-y-px" style="border-top:1px solid var(--border)">
            <div v-for="b in benefits" :key="b" class="flex items-start gap-4 py-4 border-b" style="border-color:var(--border)">
              <span class="mt-1 w-1.5 h-1.5 rounded-full flex-shrink-0" style="background:var(--text-3)" />
              <p class="text-[16px] leading-[1.7]" style="color:var(--text-2)">{{ b }}</p>
            </div>
          </div>
        </div>
        <p class="text-[17px] leading-[1.85]" style="color:var(--text-2)">{{ page?.para || '' }}</p>
      </div>
    </template>
  </ServiceLayout>
</template>

<script setup lang="ts">
const { t } = useI18n()
const page = await usePageContent('leistungen/firmenfitness')
useHead({ title: computed(() => page.value?.title ? `${page.value.title} – Medlake` : t('pages.leistungen.firmenfitness.meta')) })

const benefits = computed(() => (page.value?.benefits as string[]) || [])
</script>
