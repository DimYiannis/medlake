<template>
  <ServiceLayout>
    <template #title>{{ $t('pages.leistungen.herzKreislauf.title') }}</template>
    <template #intro>{{ $t('pages.leistungen.herzKreislauf.intro') }}</template>
    <template #body>
      <div class="space-y-10">
        <div>
          <p class="text-[12px] tracking-[0.25em] uppercase mb-6" style="color:var(--text-3)">{{ $t('pages.leistungen.herzKreislauf.benefitsLabel') }}</p>
          <div class="space-y-px" style="border-top:1px solid var(--border)">
            <div v-for="b in benefits" :key="b" class="flex items-start gap-4 py-4 border-b" style="border-color:var(--border)">
              <span class="mt-1 w-1.5 h-1.5 rounded-full flex-shrink-0" style="background:var(--text-3)" />
              <p class="text-[16px] leading-[1.7]" style="color:var(--text-2)">{{ b }}</p>
            </div>
          </div>
        </div>
        <p class="text-[17px] leading-[1.85]" style="color:var(--text-2)">{{ $t('pages.leistungen.herzKreislauf.para') }}</p>
        <div class="px-7 py-6 border-l-2" style="border-color:var(--text-3);background:var(--bg-card)">
          <p class="text-[15px] tracking-[0.1em] uppercase mb-2" style="color:var(--text-3)">{{ $t('pages.leistungen.herzKreislauf.recommendationLabel') }}</p>
          <p class="text-[17px] leading-[1.7]" style="color:var(--text-2)">{{ $t('pages.leistungen.herzKreislauf.recommendationText') }}</p>
        </div>
      </div>
    </template>
  </ServiceLayout>
</template>

<script setup lang="ts">
const { t, tm, rt } = useI18n()
useHead({ title: t('pages.leistungen.herzKreislauf.meta') })
const arr = (key: string) => (tm(key) as any[]).map((v: any) => rt(v))
const benefits = arr('pages.leistungen.herzKreislauf.benefits')
</script>
