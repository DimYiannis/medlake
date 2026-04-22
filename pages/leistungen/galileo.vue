<template>
  <ServiceLayout>
    <template #title>{{ $t('pages.leistungen.galileo.title') }}</template>
    <template #intro>{{ $t('pages.leistungen.galileo.intro') }}</template>
    <template #body>
      <div class="space-y-10">
        <p class="text-[17px] leading-[1.85]" style="color:var(--text-2)">{{ $t('pages.leistungen.galileo.para') }}</p>
        <div>
          <p class="text-[12px] tracking-[0.25em] uppercase mb-6" style="color:var(--text-3)">{{ $t('pages.leistungen.galileo.usesLabel') }}</p>
          <div class="space-y-px" style="border-top:1px solid var(--border)">
            <div v-for="u in uses" :key="u" class="flex items-start gap-4 py-4 border-b" style="border-color:var(--border)">
              <span class="mt-1 w-1.5 h-1.5 rounded-full flex-shrink-0" style="background:var(--text-3)" />
              <p class="text-[16px] leading-[1.7]" style="color:var(--text-2)">{{ u }}</p>
            </div>
          </div>
        </div>
        <div class="border rounded-sm px-7 py-6" style="border-color:var(--border)">
          <p class="text-[12px] tracking-[0.25em] uppercase mb-5" style="color:var(--text-3)">{{ $t('pages.leistungen.galileo.contraLabel') }}</p>
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
const { t, tm, rt } = useI18n()
useHead({ title: t('pages.leistungen.galileo.meta') })
const arr = (key: string) => (tm(key) as any[]).map((v: any) => rt(v))
const uses   = arr('pages.leistungen.galileo.uses')
const contra = arr('pages.leistungen.galileo.contra')
</script>
