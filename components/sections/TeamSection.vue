<template>
  <section ref="el" class="section-divider px-10 py-20">
    <p class="reveal text-[10px] tracking-[0.28em] uppercase text-white/25 mb-14">Das Team</p>

    <div class="grid grid-cols-2 md:grid-cols-4 border border-ml-border">
      <div
        v-for="(member, i) in displayTeam"
        :key="member.id || i"
        class="reveal border-r border-b border-ml-border last-of-type:border-r-0 p-7 hover:bg-white/[0.02] transition-colors"
        :class="`reveal-delay-${(i % 4) + 1}`"
      >
        <!-- Photo or initials -->
        <div class="w-12 h-12 rounded-full mb-5 overflow-hidden bg-white/[0.05] flex items-center justify-center">
          <img
            v-if="member.photo_url"
            :src="member.photo_url"
            :alt="member.name"
            class="w-full h-full object-cover"
          />
          <span v-else class="text-[13px] font-medium tracking-wider text-white/40">
            {{ initials(member.name) }}
          </span>
        </div>
        <p class="text-[15px] font-medium text-white mb-1.5">{{ member.name }}</p>
        <p class="text-[11px] tracking-[0.1em] uppercase text-white/30">{{ member.role }}</p>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
const { el } = useReveal()

// Fallback team data (shown if Supabase not configured)
const fallbackTeam = [
  { id: 1, name: 'Andrea Badstuber',  role: 'Geschäftsführerin',        photo_url: null },
  { id: 2, name: 'Natalie Oriet Rota', role: 'Fitnessinstruktorin',     photo_url: null },
  { id: 3, name: 'Tiffany Ismann',    role: 'Fitnessinstruktorin',      photo_url: null },
  { id: 4, name: 'Leo Tomazini',      role: 'Bewegungsspezialist',      photo_url: null },
]

const dbTeam = ref<any[]>([])

onMounted(async () => {
  try {
    const supabase = useSupabase()
    const { data } = await supabase
      .from('team_members')
      .select('*')
      .order('sort_order', { ascending: true })
    if (data && data.length > 0) dbTeam.value = data
  } catch {
    // Supabase not configured — fallback used
  }
})

const displayTeam = computed(() =>
  dbTeam.value.length ? dbTeam.value : fallbackTeam
)

function initials(name: string) {
  return name
    .split(' ')
    .map((n) => n[0])
    .slice(0, 2)
    .join('')
    .toUpperCase()
}
</script>
