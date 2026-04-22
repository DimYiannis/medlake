<template>
  <section ref="el" class="section-divider py-20 overflow-hidden" style="background:var(--team-bg)">

    <div class="px-10 mb-12 flex items-end justify-between">
      <p class="reveal text-[12px] tracking-[0.28em] uppercase" style="color:var(--text-3)">Das Team</p>
      <NuxtLink
        to="/team"
        class="reveal reveal-delay-1 text-[12px] tracking-[0.2em] uppercase transition-opacity hover:opacity-50 flex items-center gap-2"
        style="color:var(--text-3)"
      >
        Alle ansehen
        <svg width="10" height="10" viewBox="0 0 12 12" fill="none">
          <path d="M1 6h10M6 1l5 5-5 5" stroke="currentColor" stroke-width="1" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
      </NuxtLink>
    </div>

    <div class="marquee-track" @mouseenter="paused = true" @mouseleave="paused = false">
      <div class="marquee-inner" :class="{ paused }">
        <div
          v-for="(member, i) in marqueeItems"
          :key="`${member.id}-${i}`"
          class="marquee-card group flex-shrink-0 cursor-pointer"
          style="background:var(--team-bg)"
          @click="hovered = member"
        >
          <div class="overflow-hidden aspect-square relative" style="background:var(--bg-2)">
            <img
              v-if="member.photo_url"
              :src="member.photo_url"
              :alt="member.name"
              class="w-full h-full object-cover transition-transform duration-700 ease-out group-hover:scale-105"
            />
            <div
              v-else
              class="w-full h-full flex items-center justify-center text-[22px] font-medium"
              style="color:var(--text-3)"
            >
              {{ initials(member.name) }}
            </div>
            <div
              class="absolute inset-0 opacity-0 group-hover:opacity-100 transition-opacity duration-500"
              style="background:linear-gradient(to top, rgba(0,0,0,0.5) 0%, transparent 60%)"
            />
          </div>
          <div class="px-4 py-4" style="border-top:1px solid var(--border)">
            <p class="text-[15px] font-medium mb-1 tracking-[-0.01em]" style="color:var(--text)">{{ member.name }}</p>
            <p class="text-[12px] tracking-[0.12em] uppercase" style="color:var(--text-3)">{{ member.role }}</p>
          </div>
        </div>
      </div>
    </div>

    <!-- Lightbox -->
    <Transition name="fade">
      <div
        v-if="hovered"
        class="fixed inset-0 z-50 flex items-center justify-center bg-black/80 backdrop-blur-sm"
        @click="hovered = null"
      >
        <div class="relative max-w-sm w-full mx-6" @click.stop>
          <div class="aspect-[3/4] overflow-hidden" style="background:var(--bg-2)">
            <img
              v-if="hovered.photo_url"
              :src="hovered.photo_url"
              :alt="hovered.name"
              class="w-full h-full object-cover"
            />
            <div
              v-else
              class="w-full h-full flex items-center justify-center text-[48px] font-medium"
              style="color:var(--text-3)"
            >
              {{ initials(hovered.name) }}
            </div>
          </div>
          <div class="px-6 py-5" style="background:var(--bg);border-top:1px solid var(--border)">
            <p class="text-[16px] font-medium mb-1" style="color:var(--text)">{{ hovered.name }}</p>
            <p class="text-[12px] tracking-[0.15em] uppercase" style="color:var(--text-3)">{{ hovered.role }}</p>
          </div>
          <button
            class="absolute top-3 right-3 w-8 h-8 flex items-center justify-center text-white/60 hover:text-white transition-colors bg-black/40"
            @click="hovered = null"
          >✕</button>
        </div>
      </div>
    </Transition>

  </section>
</template>

<script setup lang="ts">
const { el } = useReveal()
const paused = ref(false)
const hovered = ref<any>(null)

const fallbackTeam = [
  { id: 1, name: 'Andrea Badstuber',      role: 'Geschäftsführerin',       photo_url: '/images/andrea.jpg' },
  { id: 2, name: 'Natalie Oriet Rota',    role: 'Fitnessinstruktorin',      photo_url: '/images/natalie.jpg' },
  { id: 3, name: 'Tiffany Ismann',        role: 'Fitnessinstruktorin',      photo_url: '/images/tiffany.png' },
  { id: 4, name: 'Leo Tomazini',          role: 'Stv. Geschäftsführer',     photo_url: '/images/tomazini.jpg' },
  { id: 5, name: 'Alexandros Dimopoulos', role: 'Fitnessinstruktor',        photo_url: '/images/alex.jpg' },
  { id: 6, name: 'Florence Winkler',      role: 'Fitnessinstruktorin',      photo_url: '/images/florence.jpg' },
  { id: 7, name: 'Junioh Kamara',         role: 'Fachmann Bewegung',        photo_url: null },
]

const supabase = useSupabaseClient()
const dbTeam = ref<any[]>([])

onMounted(async () => {
  try {
    const { data } = await supabase.from('team_members').select('*').order('sort_order', { ascending: true })
    if (data && data.length > 0) dbTeam.value = data
  } catch {}
})

const displayTeam = computed(() => {
  if (!dbTeam.value.length) return fallbackTeam
  return dbTeam.value.map(member => {
    const fallback = fallbackTeam.find(f => f.name === member.name)
    return { ...member, photo_url: member.photo_url ?? fallback?.photo_url ?? null }
  })
})

const marqueeItems = computed(() => [...displayTeam.value, ...displayTeam.value])

function initials(name: string) {
  return name.split(' ').map(n => n[0]).slice(0, 2).join('').toUpperCase()
}
</script>

<style scoped>
.marquee-track {
  width: 100%;
  overflow: hidden;
}

.marquee-inner {
  display: flex;
  gap: 1px;
  width: max-content;
  animation: marquee 246s linear infinite;
}

.marquee-inner.paused {
  animation-play-state: paused;
}

.marquee-card {
  width: 220px;
}

@media (max-width: 640px) {
  .marquee-card { width: 160px; }
}

@keyframes marquee {
  from { transform: translateX(0); }
  to   { transform: translateX(-50%); }
}

.fade-enter-active, .fade-leave-active { transition: opacity 0.2s ease; }
.fade-enter-from, .fade-leave-to { opacity: 0; }
</style>
