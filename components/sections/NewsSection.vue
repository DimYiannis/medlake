<template>
  <section ref="el" class="section-divider px-10 py-20">
    <div class="flex items-end justify-between mb-14">
      <p class="reveal text-[12px] tracking-[0.28em] uppercase" style="color:var(--text-3)">Aktuelles</p>
      <NuxtLink to="/news" class="reveal reveal-delay-1 text-[12px] tracking-[0.2em] uppercase flex items-center gap-2 transition-opacity hover:opacity-70" style="color:var(--text-3)">
        Alle News <span>→</span>
      </NuxtLink>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-3 border" style="border-color:var(--border);gap:1px;background:var(--border)">
      <article
        v-for="(post, i) in displayPosts"
        :key="post.id || i"
        class="reveal group cursor-pointer transition-colors"
        :class="`reveal-delay-${i + 1}`"
        style="background:var(--bg)"
        @click="navigate(post)"
        @mouseenter="e => (e.currentTarget as HTMLElement).style.background = 'var(--bg-card)'"
        @mouseleave="e => (e.currentTarget as HTMLElement).style.background = 'var(--bg)'"
      >
        <div class="h-[180px] overflow-hidden border-b" style="border-color:var(--border)">
          <img v-if="post.image_url" :src="post.image_url" :alt="post.title"
            class="w-full h-full object-cover opacity-80 group-hover:scale-105 transition-all duration-700" />
          <div v-else class="w-full h-full flex items-center justify-center" style="background:var(--bg-card)">
            <span class="text-[12px] tracking-[0.2em] uppercase" style="color:var(--text-4)">Medlake</span>
          </div>
        </div>
        <div class="p-7">
          <p class="text-[12px] tracking-[0.22em] uppercase mb-4" style="color:var(--text-3)">{{ post.tag || 'News' }}</p>
          <h3 class="text-[16px] font-medium leading-[1.45] mb-5" style="color:var(--text)">{{ post.title }}</h3>
          <div class="flex items-center justify-between">
            <p class="text-[13px] tracking-[0.05em]" style="color:var(--text-4)">{{ formatDate(post.published_at || post.date) }}</p>
            <span class="text-[13px] tracking-[0.15em] uppercase transition-opacity group-hover:opacity-70" style="color:var(--text-3)">Lesen →</span>
          </div>
        </div>
      </article>
    </div>
  </section>
</template>

<script setup lang="ts">
const router = useRouter()
const { el } = useReveal()

const fallbackPosts = [
  { id: 1, title: 'Sommeraktion: 3 Monate Premium Fitness für 275 CHF', tag: 'Aktion',      image_url: null, slug: null, date: '2024-04-16', published_at: '2024-04-16' },
  { id: 2, title: 'Neue Datenschutzerklärung & AGB ab 1. September 2023', tag: 'Rechtliches', image_url: null, slug: null, date: '2023-08-28', published_at: '2023-08-28' },
  { id: 3, title: 'Unser Team stellt sich vor', tag: 'Team', image_url: null, slug: null, date: '2022-07-27', published_at: '2022-07-27' },
]

const dbPosts = ref<any[]>([])
onMounted(async () => {
  try {
    const supabase = useSupabaseClient()
    const { data } = await supabase.from('news_posts').select('*').eq('published', true).order('published_at', { ascending: false }).limit(3)
    if (data && data.length > 0) dbPosts.value = data
  } catch {}
})

const displayPosts = computed(() => dbPosts.value.length ? dbPosts.value : fallbackPosts)

function formatDate(d: string) {
  if (!d) return ''
  return new Date(d).toLocaleDateString('de-CH', { day: 'numeric', month: 'long', year: 'numeric' })
}
function navigate(post: any) {
  if (post.slug) router.push(`/news/${post.slug}`)
}
</script>
