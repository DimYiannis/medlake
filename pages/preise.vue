<template>
  <div class="min-h-screen pt-36 pb-24" style="background:var(--bg)">

    <!-- Header -->
    <div class="px-10 mb-16 border-b pb-12" style="border-color:var(--border)">
      <p class="text-[12px] tracking-[0.3em] uppercase mb-4" style="color:var(--text-3)">Medlake</p>
      <h1 class="font-semibold tracking-[-0.025em] leading-none" style="font-size:clamp(40px,6vw,80px);color:var(--text)">
        {{ page?.title || '' }}
      </h1>
      <p class="text-[17px] mt-5 leading-[1.8] max-w-xl" style="color:var(--text-2)">{{ page?.desc || '' }}</p>
    </div>

    <!-- Main plans -->
    <div class="px-10 mb-16">
      <p class="text-[12px] tracking-[0.25em] uppercase mb-8" style="color:var(--text-3)">{{ page?.adults || '' }}</p>
      <div class="grid grid-cols-1 md:grid-cols-3 gap-px" style="background:var(--border)">
        <div v-for="plan in mainPlans" :key="plan.name"
          class="px-8 py-10"
          :style="plan.featured
            ? `background:var(--bg-card);border-top:2px solid var(--text-2)`
            : `background:var(--bg)`">
          <p v-if="plan.featured" class="text-[11px] tracking-[0.25em] uppercase mb-4" style="color:var(--text-3)">{{ page?.recommended || '' }}</p>
          <h2 class="text-[18px] font-medium mb-2" style="color:var(--text)">{{ plan.name }}</h2>
          <p class="text-[15px] mb-6 leading-[1.6]" style="color:var(--text-3)">{{ plan.desc }}</p>
          <div class="mb-6">
            <span class="text-[clamp(32px,4vw,48px)] font-semibold tracking-[-0.03em]" style="color:var(--text)">CHF {{ plan.price }}</span>
            <span class="text-[15px] ml-1" style="color:var(--text-3)">/ {{ plan.duration }}</span>
          </div>
          <div class="space-y-2 border-t pt-6" style="border-color:var(--border)">
            <div v-for="f in plan.features" :key="f" class="flex gap-3 items-start">
              <span class="mt-1.5 w-1.5 h-1.5 rounded-full flex-shrink-0" style="background:var(--text-3)" />
              <p class="text-[15px] leading-[1.6]" style="color:var(--text-2)">{{ f }}</p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Other categories -->
    <div class="px-10 mb-16 grid grid-cols-1 md:grid-cols-2 gap-px" style="background:var(--border)">
      <div v-for="cat in otherCategories" :key="cat.title" class="px-8 py-10" style="background:var(--bg)">
        <p class="text-[12px] tracking-[0.2em] uppercase mb-6" style="color:var(--text-3)">{{ cat.title }}</p>
        <div class="space-y-3">
          <div v-for="item in cat.items" :key="item.label"
            class="flex justify-between items-baseline py-3 border-b"
            style="border-color:var(--border)">
            <div>
              <p class="text-[16px]" style="color:var(--text)">{{ item.label }}</p>
              <p v-if="item.sub" class="text-[12px] mt-0.5" style="color:var(--text-3)">{{ item.sub }}</p>
            </div>
            <p class="text-[17px] font-medium ml-4 flex-shrink-0" style="color:var(--text)">{{ item.price }}</p>
          </div>
        </div>
      </div>
    </div>

    <!-- Included services -->
    <div class="px-10 mb-16">
      <p class="text-[12px] tracking-[0.25em] uppercase mb-8" style="color:var(--text-3)">{{ page?.includedLabel || '' }}</p>
      <div class="grid grid-cols-1 md:grid-cols-2 gap-px border" style="background:var(--border);border-color:var(--border)">
        <div v-for="item in included" :key="item" class="flex gap-4 px-8 py-5" style="background:var(--bg)">
          <span class="mt-1.5 w-1.5 h-1.5 rounded-full flex-shrink-0" style="background:var(--text-3)" />
          <p class="text-[15px] leading-[1.7]" style="color:var(--text-2)">{{ item }}</p>
        </div>
      </div>
    </div>

    <!-- Not included -->
    <div class="px-10 mb-16">
      <p class="text-[12px] tracking-[0.25em] uppercase mb-6" style="color:var(--text-3)">{{ page?.notIncludedLabel || '' }}</p>
      <div class="flex flex-wrap gap-3">
        <span v-for="item in notIncluded" :key="item"
          class="text-[12px] px-4 py-2 tracking-wide border"
          style="border-color:var(--border);color:var(--text-3)">
          {{ item }}
        </span>
      </div>
      <p class="text-[15px] mt-6" style="color:var(--text-3)">{{ page?.insuranceNote || '' }}</p>
    </div>

    <!-- CTA -->
    <div class="px-10 pt-12 border-t" style="border-color:var(--border)">
      <a href="https://connect.shore.com/bookings/medlake-training/services" target="_blank" rel="noopener"
        class="inline-flex items-center gap-3 text-[13px] tracking-[0.2em] uppercase px-7 py-4 font-medium transition-opacity hover:opacity-80"
        style="background:var(--btn-bg);color:var(--btn-text)">
        {{ page?.book || '' }}
        <svg width="12" height="12" viewBox="0 0 12 12" fill="none"><path d="M1 6h10M6 1l5 5-5 5" stroke="currentColor" stroke-width="1" stroke-linecap="round" stroke-linejoin="round"/></svg>
      </a>
    </div>

  </div>
</template>

<script setup lang="ts">
const { t } = useI18n()
const page = await usePageContent('preise')
useHead({ title: computed(() => page.value?.title ? `${page.value.title} – Medlake` : t('pages.preise.meta')) })

const mainPlans     = computed(() => (page.value?.mainPlans as any[]) || [])
const otherCategories = computed(() => (page.value?.otherCategories as any[]) || [])
const included      = computed(() => (page.value?.included as string[]) || [])
const notIncluded   = computed(() => (page.value?.notIncluded as string[]) || [])
</script>
