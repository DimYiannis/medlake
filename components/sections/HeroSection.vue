<template>
  <section ref="sectionEl" class="relative w-full h-screen overflow-hidden">

    <!-- Ken Burns background -->
    <div
      class="absolute inset-0 z-0 bg-center bg-cover ken-burns"
      :style="{ backgroundImage: `url('/images/facilities.jpg')` }"
    />

    <!-- Dark overlay -->
    <div
      class="absolute inset-0 z-[1] transition-all duration-1000"
      :style="phase === 'far' ? 'background:rgba(0,0,0,0.1)' : 'background:rgba(0,0,0,0)'"
    />

    <!-- Three.js -->
    <ClientOnly>
      <ThreeHeroCanvas
        ref="canvasRef"
        class="absolute inset-0 z-[2]"
        @slide="onSlide"
        @phase="onPhase"
      />
    </ClientOnly>

    <!-- Gradients -->
    <div class="absolute inset-0 z-[3] pointer-events-none" :style="{ background: bottomGradient }" />
    <div class="absolute inset-0 z-[3] pointer-events-none" :style="{ background: leftGradient }" />

    <!-- Bleed text -->
    <p class="absolute bottom-0 left-0 right-0 z-[3] font-bold leading-none tracking-[-0.04em] uppercase pointer-events-none select-none px-8 overflow-hidden"
      style="font-size:clamp(70px,13vw,200px);color:rgba(255,255,255,0.03)">
      Gesundheit
    </p>

    <!-- FAR phase: centred prompt -->
    <Transition name="fade-up">
      <div v-if="phase === 'far'"
        class="absolute inset-0 z-[4] flex flex-col items-center justify-center pointer-events-none">
        <p class="text-[12px] tracking-[0.35em] uppercase text-white/30 mb-5">{{ $t('hero.eyebrow') }}</p>
        <h2 class="text-[clamp(26px,3.8vw,52px)] font-semibold tracking-[-0.02em] text-white/80 text-center leading-tight">
          {{ $t('hero.title') }}<br>
          <span class="text-white/35">{{ $t('hero.titleAccent') }}</span>
        </h2>
        <div class="mt-10 flex flex-col items-center gap-2">
          <p class="text-[11px] tracking-[0.3em] uppercase text-white/25">{{ $t('hero.scrollHint') }}</p>
          <div class="bounce-arrow">
            <svg width="14" height="14" viewBox="0 0 14 14" fill="none">
              <path d="M7 1v12M1 8l6 6 6-6" stroke="rgba(255,255,255,0.25)" stroke-width="1.2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
          </div>
        </div>
      </div>
    </Transition>

    <!-- CLOSE phase: left hero content -->
    <Transition name="fade-up">
      <div v-if="phase === 'close'" class="absolute z-[4] bottom-44 left-6 max-w-[240px] sm:bottom-52 sm:left-10 sm:max-w-xl">
        <p class="text-[11px] sm:text-[12px] tracking-[0.3em] uppercase text-white/30 mb-3 sm:mb-4">{{ $t('hero.location') }}</p>
        <h1 class="font-semibold leading-[1.06] tracking-[-0.025em] text-white mb-4 sm:mb-5"
          style="font-size:clamp(22px,4.5vw,66px)">
          {{ $t('hero.headline1') }}<br>
          <span class="text-white/28">{{ $t('hero.headlineAccent1') }}</span><br>
          {{ $t('hero.headline2') }}<br>
          <span class="text-white/28">{{ $t('hero.headlineAccent2') }}</span>
        </h1>
        <p class="hidden sm:block text-[16px] leading-[1.8] max-w-sm text-white/42 mb-8">
          {{ $t('hero.description') }}
        </p>
        <div class="flex items-center gap-3 sm:gap-6">
          <a href="https://connect.shore.com/bookings/medlake-training/services"
            target="_blank" rel="noopener"
            class="text-[11px] sm:text-[13px] tracking-[0.15em] uppercase px-3 py-1.5 sm:px-6 sm:py-3 font-medium bg-white text-black hover:bg-white/85 transition-opacity">
            {{ $t('nav.bookAppointment') }}
          </a>
          <NuxtLink :to="localePath('/leistungen')"
            class="text-[11px] sm:text-[13px] tracking-[0.12em] uppercase flex items-center gap-1.5 text-white/32 hover:text-white/60 transition-colors">
            {{ $t('nav.services') }} <span>→</span>
          </NuxtLink>
        </div>
      </div>
    </Transition>

    <!-- CLOSE phase: centred card caption overlay -->
    <Transition name="fade">
      <div v-if="phase === 'close'"
        class="absolute z-[5] inset-x-0 hidden sm:flex justify-center pointer-events-none"
        style="bottom: 90px">
        <Transition name="caption" mode="out-in">
          <NuxtLink
            :key="currentSlide"
            :to="slides[currentSlide].link"
            class="caption-card-link group pointer-events-auto text-center block px-8 py-5"
          >
            <p class="text-[12px] tracking-[0.3em] uppercase text-white/35 mb-2">
              {{ slides[currentSlide].label }}
            </p>
            <p class="text-[18px] font-semibold leading-[1.3] text-white/80 group-hover:text-white transition-colors duration-300">
              {{ slides[currentSlide].caption }}
            </p>
            <span class="inline-flex items-center gap-1.5 mt-3 text-[12px] tracking-[0.18em] uppercase text-white/30 group-hover:text-white/65 transition-colors duration-300">
              {{ $t('hero.learnMore') }}
              <svg width="10" height="10" viewBox="0 0 10 10" fill="none"
                class="transition-transform duration-300 group-hover:translate-x-0.5">
                <path d="M1 5h8M5 1l4 4-4 4" stroke="currentColor" stroke-width="1" stroke-linecap="round" stroke-linejoin="round"/>
              </svg>
            </span>
          </NuxtLink>
        </Transition>
      </div>
    </Transition>

    <!-- CLOSE phase: bottom-right controls -->
    <Transition name="fade">
      <div v-if="phase === 'close'" class="absolute z-[5] bottom-10 right-10 flex flex-col items-end gap-3">

        <!-- Mobile caption (replaces arrows on phones) -->
        <Transition name="caption" mode="out-in">
          <NuxtLink
            :key="currentSlide"
            :to="slides[currentSlide].link"
            class="sm:hidden text-right group"
          >
            <p class="text-[11px] tracking-[0.25em] uppercase text-white/30 mb-1">{{ slides[currentSlide].label }}</p>
            <p class="text-[15px] font-medium leading-[1.3] text-white/75 group-hover:text-white transition-colors mb-1">{{ slides[currentSlide].caption }}</p>
            <span class="inline-flex items-center gap-1 text-[11px] tracking-[0.18em] uppercase text-white/30 group-hover:text-white/65 transition-colors">
              {{ $t('hero.learnMore') }}
              <svg width="8" height="8" viewBox="0 0 10 10" fill="none" class="transition-transform duration-300 group-hover:translate-x-0.5">
                <path d="M1 5h8M5 1l4 4-4 4" stroke="currentColor" stroke-width="1" stroke-linecap="round" stroke-linejoin="round"/>
              </svg>
            </span>
          </NuxtLink>
        </Transition>

        <div class="flex items-center gap-3">
          <button
            class="carousel-arrow hidden sm:flex"
            :disabled="currentSlide === 0"
            :class="currentSlide === 0 ? 'opacity-20' : 'hover:opacity-70'"
            @click="prev"
            :aria-label="$t('hero.prevImage')"
          >
            <svg width="18" height="18" viewBox="0 0 14 14" fill="none">
              <path d="M9 2L4 7l5 5" stroke="white" stroke-width="1.2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
          </button>

          <div class="flex items-center gap-2">
            <button
              v-for="(_, i) in slides" :key="i"
              class="rounded-full transition-all duration-400 cursor-pointer"
              :style="i === currentSlide
                ? 'width:22px;height:3px;background:rgba(255,255,255,0.6)'
                : 'width:6px;height:3px;background:rgba(255,255,255,0.2)'"
              @click="goTo(i)"
            />
          </div>

          <button
            class="carousel-arrow hidden sm:flex"
            :disabled="currentSlide === slides.length - 1"
            :class="currentSlide === slides.length - 1 ? 'opacity-20' : 'hover:opacity-70'"
            @click="next"
            :aria-label="$t('hero.nextImage')"
          >
            <svg width="18" height="18" viewBox="0 0 14 14" fill="none">
              <path d="M5 2l5 5-5 5" stroke="white" stroke-width="1.2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
          </button>
        </div>
      </div>
    </Transition>

    <!-- Progress bar -->
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
const { theme } = useTheme()
const localePath = useLocalePath()
const isLight = computed(() => theme.value === 'light')
const bottomGradient = computed(() => isLight.value
  ? 'linear-gradient(to top,rgba(0,0,0,0.45) 0%,rgba(0,0,0,0.1) 40%,transparent 70%)'
  : 'linear-gradient(to top,rgba(0,0,0,0.65) 0%,rgba(0,0,0,0.18) 40%,transparent 70%)'
)
const leftGradient = computed(() => isLight.value
  ? 'linear-gradient(to right,rgba(0,0,0,0.2) 0%,transparent 55%)'
  : 'linear-gradient(to right,rgba(0,0,0,0.3) 0%,transparent 55%)'
)

const slides = [
  { label: 'Fitness',        caption: 'Modernste Geräte für Kraft & Ausdauer',     link: '/leistungen/krafttraining' },
  { label: 'Ärzte',          caption: 'Fach- und Spezialärzte unterstützen Sie auf Ihrem Weg.',           link: '/aerzte' },
  { label: 'Physiotherapie', caption: 'Individuelle Therapie & Rehabilitation',     link: '/leistungen' },
]

const currentSlide = ref(0)
const phase = ref<'far' | 'close'>('far')
const canvasRef = ref<any>(null)
const sectionEl = ref<HTMLElement | null>(null)

const progressWidth = computed(() =>
  `${((currentSlide.value + 1) / slides.length) * 100}%`
)

function onSlide(i: number) { currentSlide.value = i }
function onPhase(p: 'far' | 'close') { phase.value = p }

function goTo(i: number) {
  if (phase.value !== 'close') return
  currentSlide.value = i
  canvasRef.value?.goTo(i)
}
function prev() { goTo(currentSlide.value - 1) }
function next() { goTo(currentSlide.value + 1) }

useSwipe(sectionEl, {
  onSwipeEnd(_, direction) {
    if (phase.value !== 'close') return
    if (direction === 'left')  next()
    if (direction === 'right') prev()
  },
  threshold: 40,
})
</script>

<style scoped>
@keyframes kenBurns {
  0%   { transform: scale(1.00) translate(  0%,    0%); }
  33%  { transform: scale(1.06) translate( -1%, -0.5%); }
  66%  { transform: scale(1.04) translate(0.5%,   1%);  }
  100% { transform: scale(1.00) translate(  0%,    0%); }
}
.ken-burns { animation: kenBurns 22s ease-in-out infinite; will-change: transform; }

@media (max-width: 640px) {
  .ken-burns {
    background-size: 85% auto;
    background-position: center 30%;
  }
}

@keyframes arrowBounce {
  0%, 100% { transform: translateY(0); }
  50%       { transform: translateY(5px); }
}
.bounce-arrow { animation: arrowBounce 1.8s ease-in-out infinite; }

/* Caption: no box, just text */
.caption-link {
  text-decoration: none;
  cursor: pointer;
}

/* Underline slides in from right on hover */
.underline-slide {
  width: 0;
  background: rgba(255,255,255,0.3);
  transition: width 0.4s ease;
}
.caption-link:hover .underline-slide {
  width: 100%;
}

.carousel-arrow {
  width: 32px;
  height: 22px;
  border: 1px solid rgba(255,255,255,0.2);
  border-radius: 2px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: transparent;
  cursor: pointer;
  transition: opacity 0.2s, border-color 0.2s;
}
@media (min-width: 640px) {
  .carousel-arrow {
    width: 48px;
    height: 48px;
  }
}
.carousel-arrow:hover:not(:disabled) {
  border-color: rgba(255,255,255,0.4);
}
.carousel-arrow:disabled { cursor: not-allowed; }

.fade-up-enter-active { transition: opacity 0.7s ease, transform 0.7s ease; }
.fade-up-leave-active { transition: opacity 0.35s ease, transform 0.35s ease; }
.fade-up-enter-from   { opacity: 0; transform: translateY(20px); }
.fade-up-leave-to     { opacity: 0; transform: translateY(-12px); }

.fade-enter-active, .fade-leave-active { transition: opacity 0.5s ease; }
.fade-enter-from, .fade-leave-to       { opacity: 0; }

.caption-enter-active { transition: opacity 0.4s ease, transform 0.4s ease; }
.caption-leave-active { transition: opacity 0.2s ease; }
.caption-enter-from   { opacity: 0; transform: translateY(10px); }
.caption-leave-to     { opacity: 0; }
</style>