<template>
  <div class="min-h-screen pt-36 pb-24" style="background:var(--bg)">

    <div class="px-10 mb-16 border-b pb-12" style="border-color:var(--border)">
      <p class="text-[12px] tracking-[0.3em] uppercase mb-4" style="color:var(--text-3)">{{ $t('pages.medizinisches.eyebrow') }}</p>
      <h1 class="font-semibold tracking-[-0.025em] leading-none" style="font-size:clamp(40px,6vw,80px);color:var(--text)">
        {{ $t('pages.medizinisches.title') }}
      </h1>
      <p class="text-[17px] mt-5 leading-[1.8] max-w-xl" style="color:var(--text-2)">
        {{ $t('pages.medizinisches.desc') }}
      </p>
    </div>

    <!-- Chapter navigation -->
    <div class="px-10 mb-12 flex flex-wrap gap-3">
      <button
        v-for="(ch, i) in chapters" :key="i"
        class="text-[12px] tracking-[0.18em] uppercase px-4 py-2 border transition-all"
        :style="activeChapterIdx === i
          ? `background:var(--text);color:var(--bg);border-color:var(--text)`
          : `background:transparent;color:var(--text-3);border-color:var(--border)`"
        @click="activeChapterIdx = i"
      >
        {{ ch.label }}
      </button>
    </div>

    <!-- Content -->
    <div class="px-10 max-w-3xl">

      <!-- Geschichte -->
      <div v-if="activeChapterIdx === 0" class="space-y-6">
        <p class="text-[12px] tracking-[0.25em] uppercase mb-6" style="color:var(--text-3)">{{ chapters[0]?.heading || '' }}</p>
        <div v-for="item in geschichte" :key="item.year" class="flex gap-8 pb-8 border-b" style="border-color:var(--border)">
          <span class="text-[15px] font-medium flex-shrink-0 w-12" style="color:var(--text-3)">{{ item.year }}</span>
          <p class="text-[16px] leading-[1.8]" style="color:var(--text-2)">{{ item.text }}</p>
        </div>
      </div>

      <!-- Kraftzuwachs -->
      <div v-if="activeChapterIdx === 1" class="space-y-6">
        <p class="text-[12px] tracking-[0.25em] uppercase mb-6" style="color:var(--text-3)">{{ chapters[1]?.heading || '' }}</p>
        <p class="text-[17px] leading-[1.85]" style="color:var(--text-2)">{{ kraft?.para1 || '' }}</p>
        <p class="text-[17px] leading-[1.85]" style="color:var(--text-2)">{{ kraft?.para2 || '' }}</p>
        <div class="mt-8">
          <p class="text-[12px] tracking-[0.2em] uppercase mb-5" style="color:var(--text-3)">{{ kraft?.principlesLabel || '' }}</p>
          <div class="space-y-px" style="border-top:1px solid var(--border)">
            <div v-for="p in trainingsprinzipien" :key="p" class="flex gap-4 py-4 border-b" style="border-color:var(--border)">
              <span class="mt-1.5 w-1.5 h-1.5 rounded-full flex-shrink-0" style="background:var(--text-3)" />
              <p class="text-[16px] leading-[1.7]" style="color:var(--text-2)">{{ p }}</p>
            </div>
          </div>
        </div>
      </div>

      <!-- Alter -->
      <div v-if="activeChapterIdx === 2" class="space-y-6">
        <p class="text-[12px] tracking-[0.25em] uppercase mb-6" style="color:var(--text-3)">{{ chapters[2]?.heading || '' }}</p>
        <p class="text-[17px] leading-[1.85]" style="color:var(--text-2)">{{ alter?.para1 || '' }}</p>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-px mt-6" style="background:var(--border)">
          <div v-for="stat in alterStats" :key="stat.age" class="px-6 py-8" style="background:var(--bg-card)">
            <p class="text-[13px] tracking-[0.15em] uppercase mb-2" style="color:var(--text-3)">{{ stat.age }}</p>
            <p class="text-[clamp(24px,3vw,36px)] font-semibold tracking-[-0.02em]" style="color:var(--text)">{{ stat.loss }}</p>
            <p class="text-[15px] mt-1" style="color:var(--text-3)">{{ stat.desc }}</p>
          </div>
        </div>
        <p class="text-[17px] leading-[1.85] mt-6" style="color:var(--text-2)">{{ alter?.para2 || '' }}</p>
      </div>

      <!-- Rücken -->
      <div v-if="activeChapterIdx === 3" class="space-y-8">
        <p class="text-[12px] tracking-[0.25em] uppercase mb-6" style="color:var(--text-3)">{{ chapters[3]?.heading || '' }}</p>
        <div v-for="section in rueckenSections" :key="section.title">
          <p class="text-[13px] tracking-[0.18em] uppercase mb-4" style="color:var(--text-3)">{{ section.title }}</p>
          <div class="space-y-px" style="border-top:1px solid var(--border)">
            <div v-for="item in section.items" :key="item" class="flex gap-4 py-3.5 border-b" style="border-color:var(--border)">
              <span class="mt-1.5 w-1.5 h-1.5 rounded-full flex-shrink-0" style="background:var(--text-4)" />
              <p class="text-[16px] leading-[1.7]" style="color:var(--text-2)">{{ item }}</p>
            </div>
          </div>
        </div>
      </div>

      <!-- Ausdauer -->
      <div v-if="activeChapterIdx === 4" class="space-y-6">
        <p class="text-[12px] tracking-[0.25em] uppercase mb-6" style="color:var(--text-3)">{{ chapters[4]?.heading || '' }}</p>
        <p class="text-[17px] leading-[1.85]" style="color:var(--text-2)">{{ ausdauer?.para1 || '' }}</p>
        <div class="px-7 py-6 border-l-2 mt-6" style="border-color:var(--text-3);background:var(--bg-card)">
          <p class="text-[12px] tracking-[0.15em] uppercase mb-3" style="color:var(--text-3)">{{ ausdauer?.trainingLabel || '' }}</p>
          <p class="text-[17px] leading-[1.7]" style="color:var(--text-2)">{{ ausdauer?.trainingText || '' }}</p>
        </div>
        <div class="mt-6">
          <p class="text-[13px] tracking-[0.18em] uppercase mb-4" style="color:var(--text-3)">{{ ausdauer?.effekteLabel || '' }}</p>
          <div class="grid grid-cols-2 gap-px" style="background:var(--border)">
            <div v-for="e in ausdauerEffekte" :key="e" class="px-6 py-4" style="background:var(--bg)">
              <p class="text-[15px] leading-[1.6]" style="color:var(--text-2)">{{ e }}</p>
            </div>
          </div>
        </div>
      </div>

    </div>
  </div>
</template>

<script setup lang="ts">
const { t } = useI18n()
useHead({ title: t('pages.medizinisches.meta') })

const page = await usePageContent('medizinisches')

const chapters          = computed(() => (page.value?.chapters as any[]) || [])
const activeChapterIdx  = ref(0)
const geschichte        = computed(() => (page.value?.geschichte as any[]) || [])
const kraft             = computed(() => (page.value?.kraft as any) || {})
const trainingsprinzipien = computed(() => (kraft.value?.trainingsprinzipien as string[]) || [])
const alter             = computed(() => (page.value?.alter as any) || {})
const alterStats        = computed(() => (alter.value?.stats as any[]) || [])
const rueckenSections   = computed(() => ((page.value?.ruecken as any)?.sections as any[]) || [])
const ausdauer          = computed(() => (page.value?.ausdauer as any) || {})
const ausdauerEffekte   = computed(() => (ausdauer.value?.effekte as string[]) || [])
</script>
