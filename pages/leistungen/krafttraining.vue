<template>
  <ServiceLayout>
    <template #title>{{ $t('pages.leistungen.krafttraining.title') }}</template>
    <template #intro>{{ $t('pages.leistungen.krafttraining.intro') }}</template>
    <template #body>
      <div class="space-y-10">

        <div class="grid grid-cols-2 gap-px" style="background:var(--border)">
          <div v-for="(b, i) in benefits" :key="b.title" class="px-7 py-6" style="background:var(--bg-card)">
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
const { t, tm, rt } = useI18n()
useHead({ title: t('pages.leistungen.krafttraining.meta') })
const arr = (key: string) => (tm(key) as any[]).map((v: any) => rt(v))
const titles = arr('pages.leistungen.krafttraining.benefitTitles')
const texts  = arr('pages.leistungen.krafttraining.benefitTexts')
const benefits = titles.map((title, i) => ({ title, text: texts[i] }))
const paras = arr('pages.leistungen.krafttraining.paras')
</script>
