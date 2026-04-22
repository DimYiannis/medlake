<template>
  <div class="min-h-screen pt-32 pb-24" style="background:var(--bg)">

    <div class="px-10 mb-12">
      <NuxtLink
        :to="localePath('/leistungen')"
        class="inline-flex items-center gap-2 text-[12px] tracking-[0.22em] uppercase transition-opacity hover:opacity-60"
        style="color:var(--text-3)"
      >
        <svg width="14" height="14" viewBox="0 0 14 14" fill="none">
          <path d="M11 7H3M7 3L3 7l4 4" stroke="currentColor" stroke-width="1" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
        {{ $t('common.back') }}
      </NuxtLink>
    </div>

    <div class="px-10 mb-16 border-b pb-12" style="border-color:var(--border)">
      <p class="text-[12px] tracking-[0.3em] uppercase mb-4" style="color:var(--text-3)">
        {{ $t('pages.leistungen.eyebrow') }}
      </p>
      <h1
        class="font-semibold tracking-[-0.025em] leading-none mb-6"
        style="font-size:clamp(36px,6vw,80px);color:var(--text)"
      >
        <slot name="title" />
      </h1>
      <p class="text-[17px] leading-[1.8] max-w-2xl" style="color:var(--text-2)">
        <slot name="intro" />
      </p>
    </div>

    <div class="px-10 max-w-3xl">
      <slot name="body" />
    </div>

    <div class="px-10 mt-16 pt-12 border-t" style="border-color:var(--border)">
      <p class="text-[12px] tracking-[0.25em] uppercase mb-6" style="color:var(--text-3)">
        {{ $t('pages.leistungen.interested') }}
      </p>
      <a
        href="https://connect.shore.com/bookings/medlake-training/services"
        target="_blank"
        rel="noopener"
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
const localePath = useLocalePath()
</script>
