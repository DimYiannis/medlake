<template>
  <ServiceLayout>
    <template #title>{{ $t('pages.leistungen.hilfeSchmerzen.title') }}</template>
    <template #intro>{{ $t('pages.leistungen.hilfeSchmerzen.intro') }}</template>
    <template #body>
      <div class="space-y-10">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-px" style="background:var(--border)">
          <div v-for="(s, i) in stats" :key="i" class="px-7 py-8 text-center" style="background:var(--bg-card)">
            <p class="font-semibold tracking-[-0.03em] leading-none mb-2" style="font-size:clamp(28px,4vw,48px);color:var(--text)">{{ s.num }}</p>
            <p class="text-[13px] tracking-[0.15em] uppercase" style="color:var(--text-3)">{{ s.label }}</p>
          </div>
        </div>
        <div class="space-y-5">
          <p class="text-[17px] leading-[1.85]" style="color:var(--text-2)">{{ $t('pages.leistungen.hilfeSchmerzen.para1') }}</p>
          <p class="text-[17px] leading-[1.85]" style="color:var(--text-2)">{{ $t('pages.leistungen.hilfeSchmerzen.para2') }}</p>
        </div>
        <div class="px-7 py-6 border-l-2" style="border-color:var(--text-3);background:var(--bg-card)">
          <p class="text-[15px] tracking-[0.1em] uppercase mb-2" style="color:var(--text-3)">{{ $t('pages.leistungen.hilfeSchmerzen.insuranceLabel') }}</p>
          <p class="text-[17px] leading-[1.7]" style="color:var(--text-2)">{{ $t('pages.leistungen.hilfeSchmerzen.insuranceText') }}</p>
        </div>
      </div>
    </template>
  </ServiceLayout>
</template>

<script setup lang="ts">
const { t, tm, rt } = useI18n()
useHead({ title: t('pages.leistungen.hilfeSchmerzen.meta') })
const arr = (key: string) => (tm(key) as any[]).map((v: any) => rt(v))
const statNums = ['3', '540m²', '100%']
const statLabels = arr('pages.leistungen.hilfeSchmerzen.statLabels')
const stats = statNums.map((num, i) => ({ num, label: statLabels[i] }))
</script>
