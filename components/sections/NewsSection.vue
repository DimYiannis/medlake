<template>
  <section ref="el" class="section-divider px-10 py-20">
    <div class="flex items-end justify-between mb-14">
      <p class="reveal text-[10px] tracking-[0.28em] uppercase text-white/25">Aktuelles</p>
      <NuxtLink
        to="/news"
        class="reveal reveal-delay-1 text-[10px] tracking-[0.2em] uppercase text-white/25 hover:text-white transition-colors flex items-center gap-2"
      >
        Alle News <span>→</span>
      </NuxtLink>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-3 border border-ml-border">
      <article
        v-for="(post, i) in displayPosts"
        :key="post.id || i"
        class="reveal border-r border-b border-ml-border last-of-type:border-r-0 group cursor-pointer hover:bg-white/[0.02] transition-colors"
        :class="`reveal-delay-${i + 1}`"
        @click="navigate(post)"
      >
        <!-- Image -->
        <div class="h-[180px] overflow-hidden border-b border-ml-border">
          <img
            v-if="post.image_url"
            :src="post.image_url"
            :alt="post.title"
            class="w-full h-full object-cover opacity-60 group-hover:opacity-80 group-hover:scale-105 transition-all duration-700"
          />
          <div v-else class="w-full h-full bg-white/[0.03] flex items-center justify-center">
            <span class="text-[10px] tracking-[0.2em] uppercase text-white/15">Medlake</span>
          </div>
        </div>

        <!-- Content -->
        <div class="p-7">
          <p class="text-[10px] tracking-[0.22em] uppercase text-white/25 mb-4">{{ post.tag || 'News' }}</p>
          <h3 class="text-[16px] font-medium leading-[1.45] text-white mb-5 group-hover:text-white/80 transition-colors">
            {{ post.title }}
          </h3>
          <div class="flex items-center justify-between">
            <p class="text-[11px] text-white/20 tracking-[0.05em]">{{ formatDate(post.published_at || post.date) }}</p>
            <span class="text-[11px] tracking-[0.15em] uppercase text-white/20 group-hover:text-white/60 transition-colors">
              Lesen →
            </span>
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
  {
    id: 1,
    title: 'Sommeraktion: 3 Monate Premium Fitness für 275 CHF',
    tag: 'Aktion',
    image_url: null,
    slug: null,
    date: '2024-04-16',
    published_at: '2024-04-16',
  },
  {
    id: 2,
    title: 'Neue Datenschutzerklärung & AGB ab 1. September 2023',
    tag: 'Rechtliches',
    image_url: null,
    slug: null,
    date: '2023-08-28',
    published_at: '2023-08-28',
  },
  {
    id: 3,
    title: 'Unser Team stellt sich vor — lernen Sie die Menschen hinter Medlake kennen',
    tag: 'Team',
    image_url: null,
    slug: null,
    date: '2022-07-27',
    published_at: '2022-07-27',
  },
]

const dbPosts = ref<any[]>([])

onMounted(async () => {
  try {
    const supabase = useSupabase()
    const { data } = await supabase
      .from('news_posts')
      .select('*')
      .eq('published', true)
      .order('published_at', { ascending: false })
      .limit(3)
    if (data && data.length > 0) dbPosts.value = data
  } catch {
    // fallback
  }
})

const displayPosts = computed(() =>
  dbPosts.value.length ? dbPosts.value : fallbackPosts
)

function formatDate(dateStr: string) {
  if (!dateStr) return ''
  const d = new Date(dateStr)
  return d.toLocaleDateString('de-CH', { day: 'numeric', month: 'long', year: 'numeric' })
}

function navigate(post: any) {
  if (post.slug) router.push(`/news/${post.slug}`)
}
</script>
