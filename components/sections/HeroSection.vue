<template>
  <section class="relative h-screen min-h-[680px] flex flex-col justify-end overflow-hidden">

    <!-- Three.js canvas (client-only to avoid SSR issues) -->
    <ClientOnly>
      <ThreeHeroCanvas />
    </ClientOnly>

    <!-- Dark gradient overlay — left side for legibility -->
    <div class="absolute inset-0 bg-gradient-to-r from-ml-black via-ml-black/70 to-transparent pointer-events-none" />
    <div class="absolute inset-0 bg-gradient-to-t from-ml-black via-transparent to-transparent pointer-events-none" />

    <!-- Oversized bleed text -->
    <p class="absolute bottom-0 left-0 right-0 text-[clamp(70px,13vw,200px)] font-bold leading-none tracking-[-0.04em] text-white/[0.04] uppercase pointer-events-none select-none px-8 overflow-hidden">
      Gesundheit
    </p>

    <!-- Hero content -->
    <div class="relative z-10 px-10 pb-20 max-w-2xl">
      <p class="text-[10px] tracking-[0.3em] uppercase text-white/30 mb-5">
        Küsnacht, Schweiz — seit 2001
      </p>
      <h1 class="text-[clamp(36px,5.5vw,78px)] font-semibold leading-[1.06] tracking-[-0.025em] mb-6">
        Die Kraft<br>
        <span class="text-white/30">zu heilen.</span><br>
        Die Kraft<br>
        <span class="text-white/30">zu bewegen.</span>
      </h1>
      <p class="text-[15px] text-white/45 leading-[1.8] max-w-md mb-10">
        Medizinisches Kompetenzzentrum für gesundheitsorientiertes Kraft- und Ausdauertraining — begleitet von Fachärzten und Physiotherapeutinnen.
      </p>
      <div class="flex items-center gap-7">
        <a
          href="https://connect.shore.com/bookings/medlake-training/services"
          target="_blank"
          rel="noopener"
          class="text-[11px] tracking-[0.18em] uppercase bg-white text-ml-black px-7 py-3.5 font-medium hover:bg-white/85 transition-colors"
        >
          Termin buchen
        </a>
        <NuxtLink
          to="/leistungen"
          class="text-[11px] tracking-[0.15em] uppercase text-white/40 hover:text-white transition-colors flex items-center gap-2"
        >
          Leistungen <span class="text-lg leading-none">→</span>
        </NuxtLink>
      </div>
    </div>

    <!-- Scroll hint -->
    <div class="absolute bottom-8 right-10 flex flex-col items-center gap-2 z-10">
      <span class="text-[9px] tracking-[0.3em] uppercase text-white/20 [writing-mode:vertical-rl]">Scroll</span>
      <div class="w-px h-12 bg-gradient-to-b from-white/20 to-transparent" />
    </div>
  </section>
</template>

<script setup lang="ts">
// Lazy import to keep hero fast
const ThreeHeroCanvas = defineAsyncComponent(() =>
  import('~/components/three/HeroCanvas.vue')
)
</script>
