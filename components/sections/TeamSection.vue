<template>
  <section ref="el" class="section-divider px-10 py-20" style="background:var(--team-bg)">
    <p class="reveal text-[10px] tracking-[0.28em] uppercase mb-14" style="color:var(--text-3)">Das Team</p>

    <div class="grid grid-cols-2 md:grid-cols-4 border" style="border-color:var(--border);gap:1px;background:var(--border)">
      <div
        v-for="(member, i) in displayTeam"
        :key="member.id || i"
        class="reveal p-7 transition-colors"
        :class="`reveal-delay-${(i % 4) + 1}`"
        style="background:var(--team-bg)"
        @mouseenter="e => (e.currentTarget as HTMLElement).style.background = 'var(--bg-card)'"
        @mouseleave="e => (e.currentTarget as HTMLElement).style.background = 'var(--team-bg)'"
      >
        <div class="w-12 h-12 rounded-full mb-5 overflow-hidden flex items-center justify-center" style="background:var(--border-2)">
          <img v-if="member.photo_url" :src="member.photo_url" :alt="member.name" class="w-full h-full object-cover" />
          <span v-else class="text-[13px] font-medium tracking-wider" style="color:var(--text-3)">
            {{ initials(member.name) }}
          </span>
        </div>
        <p class="text-[15px] font-medium mb-1.5" style="color:var(--text)">{{ member.name }}</p>
        <p class="text-[11px] tracking-[0.1em] uppercase" style="color:var(--text-3)">{{ member.role }}</p>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
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

const displayTeam = computed(() => dbTeam.value.length ? dbTeam.value : fallbackTeam)

function initials(name: string) {
  return name.split(' ').map(n => n[0]).slice(0, 2).join('').toUpperCase()
}
</script>
