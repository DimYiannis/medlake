<template>
  <div class="min-h-screen pt-36 pb-24" style="background:var(--bg)">

    <!-- Header -->
    <div class="px-10 mb-16 border-b pb-12" style="border-color:var(--border)">
      <p class="text-[12px] tracking-[0.3em] uppercase mb-4" style="color:var(--text-3)">Medlake</p>
      <h1 class="font-semibold tracking-[-0.025em] leading-none mb-5" style="font-size:clamp(40px,6vw,80px);color:var(--text)">
        {{ $t('pages.leistungen.title') }}
      </h1>
      <p class="text-[17px] leading-[1.8] max-w-xl" style="color:var(--text-2)">
        {{ $t('pages.leistungen.desc') }}
      </p>
    </div>

    <!-- Service grid -->
    <div class="px-10">
      <div class="grid grid-cols-1 md:grid-cols-2 gap-px" style="background:var(--border)">
        <NuxtLink
          v-for="service in services"
          :key="service.id"
          :to="localePath(service.link)"
          class="group flex flex-col px-8 py-10 transition-colors"
          style="background:var(--bg)"
          @mouseenter="($el as HTMLElement).style.background='var(--bg-card)'"
          @mouseleave="($el as HTMLElement).style.background='var(--bg)'"
        >
          <div class="flex items-start justify-between gap-4 mb-5">
            <img
              v-if="service.icon"
              :src="service.icon"
              :alt="service.name"
              class="service-icon w-8 h-8 object-contain"
            />
            <svg
              class="flex-shrink-0 mt-1 transition-transform group-hover:translate-x-1"
              width="16" height="16" viewBox="0 0 16 16" fill="none"
              style="color:var(--text-3)"
            >
              <path d="M2 8h12M9 3l5 5-5 5" stroke="currentColor" stroke-width="1.2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
          </div>

          <h2 class="text-[18px] font-medium mb-3 leading-snug" style="color:var(--text)">
            {{ service.name }}
          </h2>
          <p class="text-[15px] leading-[1.7] flex-1" style="color:var(--text-3)">
            {{ service.description }}
          </p>
        </NuxtLink>
      </div>
    </div>

    <!-- CTA -->
    <div class="px-10 mt-16 pt-12 border-t" style="border-color:var(--border)">
      <p class="text-[12px] tracking-[0.25em] uppercase mb-6" style="color:var(--text-3)">{{ $t('pages.leistungen.interested') }}</p>
      <a
        href="https://connect.shore.com/bookings/medlake-training/services"
        target="_blank" rel="noopener"
        class="inline-flex items-center gap-3 text-[13px] tracking-[0.2em] uppercase px-7 py-4 font-medium transition-opacity hover:opacity-80"
        style="background:var(--btn-bg);color:var(--btn-text)"
      >
        {{ $t('pages.leistungen.book') }}
        <svg width="12" height="12" viewBox="0 0 12 12" fill="none">
          <path d="M1 6h10M6 1l5 5-5 5" stroke="currentColor" stroke-width="1" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
      </a>
    </div>

  </div>
</template>

<script setup lang="ts">
const { t } = useI18n()
const localePath = useLocalePath()
useHead({ title: t('pages.leistungen.meta') })
const services = await useServices()
</script>
