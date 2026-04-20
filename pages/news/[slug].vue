<template>
  <div class="pt-36 px-10 pb-24 min-h-screen">
    <div v-if="post" class="max-w-2xl mx-auto">
      <NuxtLink to="/news" class="text-[10px] tracking-[0.2em] uppercase text-white/25 hover:text-white transition-colors mb-10 inline-block">
        ← Alle News
      </NuxtLink>

      <p class="text-[10px] tracking-[0.22em] uppercase text-white/25 mb-4">{{ post.tag || 'News' }}</p>
      <h1 class="text-[clamp(28px,4vw,52px)] font-semibold tracking-[-0.02em] leading-[1.15] mb-6">
        {{ post.title }}
      </h1>
      <p class="text-[12px] text-white/20 mb-12">{{ formatDate(post.published_at) }}</p>

      <div
        v-if="post.image_url"
        class="w-full aspect-video overflow-hidden mb-12 border border-ml-border"
      >
        <img :src="post.image_url" :alt="post.title" class="w-full h-full object-cover opacity-80" />
      </div>

      <div
        class="prose prose-invert prose-sm max-w-none text-white/60 leading-[1.9] text-[15px]"
        v-html="post.content"
      />
    </div>

    <div v-else class="text-white/20 text-sm tracking-widest pt-20 text-center">
      Beitrag nicht gefunden.
    </div>
  </div>
</template>

<script setup lang="ts">
const route = useRoute()
const post = ref<any>(null)

useHead(() => ({
  title: post.value ? `${post.value.title} – Medlake` : 'News – Medlake',
}))

onMounted(async () => {
  try {
    const supabase = useSupabase()
    const { data } = await supabase
      .from('news_posts')
      .select('*')
      .eq('slug', route.params.slug)
      .eq('published', true)
      .single()
    post.value = data
  } catch { /* not found */ }
})

function formatDate(d: string) {
  if (!d) return ''
  return new Date(d).toLocaleDateString('de-CH', { day: 'numeric', month: 'long', year: 'numeric' })
}
</script>
