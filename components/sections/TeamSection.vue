<template>
  <section ref="el" class="section-divider py-20" style="background:var(--team-bg)">

    <div class="px-10 mb-12 flex items-end justify-between">
      <p class="reveal text-[10px] tracking-[0.28em] uppercase" style="color:var(--text-3)">Das Team</p>
      <NuxtLink
        to="/team"
        class="reveal reveal-delay-1 text-[10px] tracking-[0.2em] uppercase transition-opacity hover:opacity-50 flex items-center gap-2"
        style="color:var(--text-3)"
      >
        Alle ansehen
        <svg width="10" height="10" viewBox="0 0 12 12" fill="none">
          <path d="M1 6h10M6 1l5 5-5 5" stroke="currentColor" stroke-width="1" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
      </NuxtLink>
    </div>

    <div class="grid grid-cols-2 md:grid-cols-4 gap-px" style="background:var(--border)">
      <div
        v-for="(member, i) in displayTeam"
        :key="member.id || i"
        class="reveal group"
        :class="`reveal-delay-${(i % 4) + 1}`"
        style="background:var(--team-bg)"
      >
        <!-- Photo -->
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
          ></div>
        </div>

        <!-- Info -->
        <div class="px-5 py-5" style="border-top:1px solid var(--border)">
          <p class="text-[14px] font-medium mb-1 tracking-[-0.01em]" style="color:var(--text)">{{ member.name }}</p>
          <p class="text-[10px] tracking-[0.12em] uppercase" style="color:var(--text-3)">{{ member.role }}</p>
        </div>
      </div>
    </div>

  </section>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
const { el } = useReveal()

const fallbackTeam = [
  { id: 1, name: 'Andrea Badstuber',   role: 'Geschäftsführerin',  photo_url: '/images/andrea.jpg' },
  { id: 2, name: 'Natalie Oriet Rota', role: 'Fitnessinstruktorin', photo_url: '/images/natalie.jpg' },
  { id: 3, name: 'Tiffany Ismann',     role: 'Fitnessinstruktorin', photo_url: '/images/tiffany.png' },
  { id: 4, name: 'Leo Tomazini',       role: 'Bewegungsspezialist', photo_url: '/images/tomazini.jpg' },
]

const dbTeam = ref<any[]>([])

onMounted(async () => {
  try {
    const supabase = useSupabase()
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

function initials(name: string) {
  return name.split(' ').map(n => n[0]).slice(0, 2).join('').toUpperCase()
}
</script>
