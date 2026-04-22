<template>
  <div class="min-h-screen pt-36 pb-24" style="background:var(--bg)">

    <!-- Header -->
    <div class="px-10 mb-16 border-b pb-12" style="border-color:var(--border)">
      <p class="text-[12px] tracking-[0.3em] uppercase mb-4" style="color:var(--text-3)">Medlake</p>
      <h1 class="font-semibold tracking-[-0.025em] leading-none" style="font-size:clamp(40px,6vw,80px);color:var(--text)">
        {{ $t('pages.preise.title') }}
      </h1>
      <p class="text-[17px] mt-5 leading-[1.8] max-w-xl" style="color:var(--text-2)">
        {{ $t('pages.preise.desc') }}
      </p>
    </div>

    <!-- Main plans -->
    <div class="px-10 mb-16">
      <p class="text-[12px] tracking-[0.25em] uppercase mb-8" style="color:var(--text-3)">{{ $t('pages.preise.adults') }}</p>
      <div class="grid grid-cols-1 md:grid-cols-3 gap-px" style="background:var(--border)">
        <div v-for="plan in mainPlans" :key="plan.name"
          class="px-8 py-10"
          :style="plan.featured
            ? `background:var(--bg-card);border-top:2px solid var(--text-2)`
            : `background:var(--bg)`">
          <p v-if="plan.featured" class="text-[11px] tracking-[0.25em] uppercase mb-4" style="color:var(--text-3)">{{ $t('pages.preise.recommended') }}</p>
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
      <p class="text-[12px] tracking-[0.25em] uppercase mb-8" style="color:var(--text-3)">{{ $t('pages.preise.includedLabel') }}</p>
      <div class="grid grid-cols-1 md:grid-cols-2 gap-px border" style="background:var(--border);border-color:var(--border)">
        <div v-for="item in included" :key="item" class="flex gap-4 px-8 py-5" style="background:var(--bg)">
          <span class="mt-1.5 w-1.5 h-1.5 rounded-full flex-shrink-0" style="background:var(--text-3)" />
          <p class="text-[15px] leading-[1.7]" style="color:var(--text-2)">{{ item }}</p>
        </div>
      </div>
    </div>

    <!-- Not included -->
    <div class="px-10 mb-16">
      <p class="text-[12px] tracking-[0.25em] uppercase mb-6" style="color:var(--text-3)">{{ $t('pages.preise.notIncludedLabel') }}</p>
      <div class="flex flex-wrap gap-3">
        <span v-for="item in notIncluded" :key="item"
          class="text-[12px] px-4 py-2 tracking-wide border"
          style="border-color:var(--border);color:var(--text-3)">
          {{ item }}
        </span>
      </div>
      <p class="text-[15px] mt-6" style="color:var(--text-3)">
        {{ $t('pages.preise.insuranceNote') }}
      </p>
    </div>

    <!-- CTA -->
    <div class="px-10 pt-12 border-t" style="border-color:var(--border)">
      <a href="https://connect.shore.com/bookings/medlake-training/services" target="_blank" rel="noopener"
        class="inline-flex items-center gap-3 text-[13px] tracking-[0.2em] uppercase px-7 py-4 font-medium transition-opacity hover:opacity-80"
        style="background:var(--btn-bg);color:var(--btn-text)">
        {{ $t('pages.preise.book') }}
        <svg width="12" height="12" viewBox="0 0 12 12" fill="none"><path d="M1 6h10M6 1l5 5-5 5" stroke="currentColor" stroke-width="1" stroke-linecap="round" stroke-linejoin="round"/></svg>
      </a>
    </div>

  </div>
</template>

<script setup lang="ts">
const { t, tm, rt } = useI18n()
useHead({ title: t('pages.preise.meta') })

const p = (key: string) => t(`pages.preise.${key}`)
const i = (key: string) => t(`pages.preise.items.${key}`)
const c = (key: string) => t(`pages.preise.categories.${key}`)
const arr = (key: string) => (tm(key) as any[]).map((f: any) => rt(f))

const mainPlans = computed(() => [
  { name: p('plans.premium.name'), desc: p('plans.premium.desc'), price: '1300', duration: p('plans.premium.duration'), featured: true,  features: arr('pages.preise.plans.premium.features') },
  { name: p('plans.plus.name'),    desc: p('plans.plus.desc'),    price: '1100', duration: p('plans.plus.duration'),    featured: false, features: arr('pages.preise.plans.plus.features') },
  { name: p('plans.basis.name'),   desc: p('plans.basis.desc'),   price: '1000', duration: p('plans.basis.duration'),   featured: false, features: arr('pages.preise.plans.basis.features') },
])

const otherCategories = computed(() => [
  { title: c('students'),  items: [{ label: i('annual'), sub: i('12months'), price: 'CHF 900.–' }, { label: i('halfYear'), sub: i('6months'), price: 'CHF 700.–' }] },
  { title: c('youth'),     items: [{ label: i('annual'), sub: i('12months'), price: 'CHF 700.–' }, { label: i('halfYear'), sub: i('6months'), price: 'CHF 500.–' }] },
  { title: c('family'),    items: [{ label: i('annual'), sub: i('familySub'), price: 'CHF 500.–' }] },
  { title: c('single'),    items: [{ label: i('singleEntry'), sub: null, price: 'CHF 30.–' }, { label: i('sensopro'), sub: null, price: 'CHF 15.–' }, { label: i('pt'), sub: null, price: i('onRequest') }, { label: i('towel'), sub: null, price: 'CHF 1.–' }, { label: i('shower'), sub: null, price: 'CHF 2.–' }] },
  { title: c('sensoproM'), items: [{ label: i('singleEntry'), sub: null, price: 'CHF 15.–' }, { label: i('10pack'), sub: null, price: 'CHF 125.–' }] },
  { title: c('sensoproE'), items: [{ label: i('singleEntry'), sub: null, price: 'CHF 30.–' }, { label: i('10pack'), sub: null, price: 'CHF 250.–' }] },
])

const included = computed(() => arr('pages.preise.included'))
const notIncluded = computed(() => arr('pages.preise.notIncluded'))
</script>
