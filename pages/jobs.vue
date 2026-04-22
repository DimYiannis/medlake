<template>
  <div class="min-h-screen pt-36 pb-24" style="background:var(--bg)">

    <div class="px-10 mb-16 border-b pb-12" style="border-color:var(--border)">
      <p class="text-[12px] tracking-[0.3em] uppercase mb-4" style="color:var(--text-3)">{{ $t('pages.jobs.eyebrow') }}</p>
      <h1 class="font-semibold tracking-[-0.025em] leading-none" style="font-size:clamp(40px,6vw,80px);color:var(--text)">
        {{ $t('pages.jobs.title') }}
      </h1>
      <p class="text-[17px] mt-5 leading-[1.8] max-w-xl" style="color:var(--text-2)">
        {{ $t('pages.jobs.desc') }}
      </p>
    </div>

    <div v-if="jobs && jobs.length" class="space-y-24">
      <div v-for="job in jobs" :key="job.id" class="px-10 max-w-3xl">
        <div class="border-b pb-4 mb-10" style="border-color:var(--border)">
          <p class="text-[12px] tracking-[0.2em] uppercase mb-1" style="color:var(--text-3)">{{ $t('pages.jobs.openPosition') }}</p>
          <h2 class="text-[24px] font-medium" style="color:var(--text)">{{ job.title }}</h2>
          <p v-if="job.subtitle" class="text-[15px] mt-1" style="color:var(--text-3)">{{ job.subtitle }}</p>
        </div>

        <p v-if="job.intro" class="text-[17px] leading-[1.85] mb-12" style="color:var(--text-2)">{{ job.intro }}</p>

        <div class="space-y-12">
          <div v-for="section in job.sections" :key="section.title">
            <p class="text-[12px] tracking-[0.25em] uppercase mb-5" style="color:var(--text-3)">{{ section.title }}</p>
            <div class="space-y-px" style="border-top:1px solid var(--border)">
              <div v-for="item in section.items" :key="item"
                class="flex gap-4 py-4 border-b" style="border-color:var(--border)">
                <span class="mt-1.5 w-1.5 h-1.5 rounded-full flex-shrink-0" style="background:var(--text-3)" />
                <p class="text-[16px] leading-[1.7]" style="color:var(--text-2)">{{ item }}</p>
              </div>
            </div>
          </div>
        </div>

        <div class="mt-16 pt-12 border-t" style="border-color:var(--border)">
          <p class="text-[12px] tracking-[0.25em] uppercase mb-4" style="color:var(--text-3)">{{ $t('pages.jobs.application') }}</p>
          <p class="text-[17px] leading-[1.8] mb-8" style="color:var(--text-2)">
            {{ $t('pages.jobs.applicationText') }}
          </p>
          <a href="mailto:info@medlake.ch?subject=Bewerbung"
            class="inline-flex items-center gap-3 text-[13px] tracking-[0.2em] uppercase px-7 py-4 font-medium transition-opacity hover:opacity-80"
            style="background:var(--btn-bg);color:var(--btn-text)">
            {{ $t('pages.jobs.apply') }}
            <svg width="12" height="12" viewBox="0 0 12 12" fill="none"><path d="M1 6h10M6 1l5 5-5 5" stroke="currentColor" stroke-width="1" stroke-linecap="round" stroke-linejoin="round"/></svg>
          </a>
        </div>
      </div>
    </div>

    <div v-else class="px-10">
      <p class="text-[16px]" style="color:var(--text-3)">{{ $t('pages.jobs.none') }}</p>
    </div>
  </div>
</template>

<script setup lang="ts">
const { t } = useI18n()
useHead({ title: t('pages.jobs.meta') })
const jobs = await useJobs()
</script>
