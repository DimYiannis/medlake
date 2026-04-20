<template>
  <section class="relative w-full h-screen overflow-hidden">

    <!-- Background: slow Ken Burns on fitness photo -->
    <div
      class="absolute inset-0 z-0 bg-center bg-cover ken-burns"
      :style="{ backgroundImage: `url('/images/interior.jpg')` }"
    />

    <!-- Dark overlay -->
    <div
      class="absolute inset-0 z-[1] transition-all duration-1000"
      :style="phase === 'far' ? 'background:rgba(0,0,0,0.58)' : 'background:rgba(0,0,0,0.70)'"
    />

    <!-- Three.js canvas -->
    <ClientOnly>
      <ThreeHeroCanvas
        class="absolute inset-0 z-[2]"
        @slide="onSlide"
        @unlocked="onUnlocked"
        @phase="onPhase"
      />
    </ClientOnly>

    <!-- Gradients for legibility -->
    <div class="absolute inset-0 z-[3] pointer-events-none"
      style="background:linear-gradient(to top,rgba(0,0,0,0.9) 0%,rgba(0,0,0,0.25) 40%,transparent 70%)" />
    <div class="absolute inset-0 z-[3] pointer-events-none"
      style="background:linear-gradient(to right,rgba(0,0,0,0.45) 0%,transparent 55%)" />

    <!-- Bleed text -->
    <p class="absolute bottom-0 left-0 right-0 z-[3] font-bold leading-none tracking-[-0.04em] uppercase pointer-events-none select-none px-8 overflow-hidden"
      style="font-size:clamp(70px,13vw,200px);color:rgba(255,255,255,0.03)">
      Gesundheit
    </p>

    <!-- FAR phase: centred prompt -->
    <Transition name="fade-up">
      <div v-if="phase === 'far'"
        class="absolute inset-0 z-[4] flex flex-col items-center justify-center pointer-events-none">
        <p class="text-[10px] tracking-[0.35em] uppercase text-white/30 mb-5">Medlake Training — Küsnacht</p>
        <h2 class="text-[clamp(26px,3.8vw,52px)] font-semibold tracking-[-0.02em] text-white/80 text-center leading-tight">
          Kompetenzzentrum für<br>
          <span class="text-white/35">Gesundheit & Bewegung</span>
        </h2>
        <div class="mt-10 flex flex-col items-center gap-2">
          <p class="text-[9px] tracking-[0.3em] uppercase text-white/25">Scroll to enter</p>
          <div class="scroll-arrow">
            <svg width="14" height="14" viewBox="0 0 14 14" fill="none">
              <path d="M7 1v12M1 8l6 6 6-6" stroke="rgba(255,255,255,0.25)" stroke-width="1.2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
          </div>
        </div>
      </div>
    </Transition>

    <!-- CLOSE phase: left hero content -->
    <Transition name="fade-up">
      <div v-if="phase === 'close'"
        class="absolute z-[4] bottom-20 left-10 max-w-xl">
        <p class="text-[10px] tracking-[0.3em] uppercase text-white/30 mb-4">Küsnacht, Schweiz — seit 2001</p>
        <h1 class="font-semibold leading-[1.06] tracking-[-0.025em] text-white mb-5"
          style="font-size:clamp(32px,4.5vw,66px)">
          Die Kraft<br>
          <span class="text-white/28">zu heilen.</span><br>
          Die Kraft<br>
          <span class="text-white/28">zu bewegen.</span>
        </h1>
        <p class="text-[14px] leading-[1.8] max-w-sm text-white/42 mb-8">
          Medizinisches Kompetenzzentrum für gesundheitsorientiertes Kraft- und Ausdauertraining.
        </p>
        <div class="flex items-center gap-6">
          <a
            href="https://connect.shore.com/bookings/medlake-training/services"
            target="_blank" rel="noopener"
            class="text-[11px] tracking-[0.18em] uppercase px-6 py-3 font-medium bg-white text-black hover:bg-white/85 transition-opacity"
          >Termin buchen</a>
          <NuxtLink to="/leistungen"
            class="text-[11px] tracking-[0.15em] uppercase flex items-center gap-2 text-white/32 hover:text-white/60 transition-colors">
            Leistungen <span>→</span>
          </NuxtLink>
        </div>
      </div>
    </Transition>

    <!-- CLOSE phase: bottom-right caption + dots -->
    <Transition name="fade">
      <div v-if="phase === 'close'"
        class="absolute z-[5] bottom-10 right-10 flex flex-col items-end gap-3">

        <Transition name="caption" mode="out-in">
          <div :key="currentSlide" class="text-right">
            <p class="text-[10px] tracking-[0.25em] uppercase text-white/20 mb-1">
              {{ slides[currentSlide].label }}
            </p>
            <p class="text-[13px] leading-[1.5] max-w-[200px] text-white/38">
              {{ slides[currentSlide].caption }}
            </p>
          </div>
        </Transition>

        <div class="flex items-center gap-2">
          <div
            v-for="(_, i) in slides" :key="i"
            class="rounded-full transition-all duration-400"
            :style="i === currentSlide
              ? 'width:22px;height:3px;background:rgba(255,255,255,0.55)'
              : 'width:6px;height:3px;background:rgba(255,255,255,0.16)'"
          />
        </div>

        <p class="text-[9px] tracking-[0.28em] uppercase text-white/20">Scroll to explore</p>
      </div>
    </Transition>

    <!-- Progress bar (close phase) -->
    <Transition name="fade">
      <div v-if="phase === 'close'"
        class="absolute top-0 left-0 right-0 h-px z-[6]"
        style="background:rgba(255,255,255,0.07)">
        <div
          class="h-full transition-all duration-500 ease-out"
          style="background:rgba(255,255,255,0.38)"
          :style="{ width: progressWidth }"
        />
      </div>
    </Transition>

  </section>
</template>

<script setup lang="ts">
const ThreeHeroCanvas = defineAsyncComponent(() => import('~/components/three/HeroCanvas.vue'))

const slides = [
  { label: 'Fitness',        caption: 'Modernste Geräte für Kraft & Ausdauer' },
  { label: 'Ärzte',          caption: 'Begleitet von Fachärzten vor Ort' },
  { label: 'Physiotherapie', caption: 'Individuelle Therapie & Rehabilitation' },
]

const currentSlide = ref(0)
const phase = ref<'far' | 'zooming' | 'close'>('far')

const progressWidth = computed(() =>
  `${((currentSlide.value + 1) / slides.length) * 100}%`
)

function onSlide(i: number)                          { currentSlide.value = i }
function onUnlocked()                                { /* page scroll free */ }
function onPhase(p: 'far' | 'zooming' | 'close')    { phase.value = p }
</script>

<style scoped>
@keyframes kenBurns {
  0%   { transform: scale(1.00) translate(  0%,    0%); }
  33%  { transform: scale(1.06) translate( -1%, -0.5%); }
  66%  { transform: scale(1.04) translate(0.5%,   1%);  }
  100% { transform: scale(1.00) translate(  0%,    0%); }
}
.ken-burns {
  animation: kenBurns 22s ease-in-out infinite;
  will-change: transform;
}

@keyframes arrowBounce {
  0%, 100% { transform: translateY(0); }
  50%       { transform: translateY(5px); }
}
.scroll-arrow { animation: arrowBounce 1.8s ease-in-out infinite; }

.fade-up-enter-active { transition: opacity 0.7s ease, transform 0.7s ease; }
.fade-up-leave-active { transition: opacity 0.35s ease, transform 0.35s ease; }
.fade-up-enter-from   { opacity: 0; transform: translateY(20px); }
.fade-up-leave-to     { opacity: 0; transform: translateY(-12px); }

.fade-enter-active, .fade-leave-active { transition: opacity 0.5s ease; }
.fade-enter-from, .fade-leave-to       { opacity: 0; }

.caption-enter-active { transition: opacity 0.45s ease, transform 0.45s ease; }
.caption-leave-active { transition: opacity 0.22s ease; }
.caption-enter-from   { opacity: 0; transform: translateY(8px); }
.caption-leave-to     { opacity: 0; }
</style>