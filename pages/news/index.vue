<template>
  <div class="pt-36 px-10 pb-24 min-h-screen">
    <!-- Header -->
    <div class="mb-16 border-b border-ml-border pb-10">
      <p class="text-[10px] tracking-[0.28em] uppercase text-white/25 mb-4">Medlake</p>
      <h1 class="text-[clamp(40px,6vw,80px)] font-semibold tracking-[-0.025em] leading-none">News</h1>
    </div>

    <!-- Grid -->
    <div v-if="posts && posts.length" class="grid grid-cols-1 md:grid-cols-3 gap-px bg-ml-border border border-ml-border">
      <NuxtLink
        v-for="post in posts"
        :key="post.id"
        :to="`/news/${post.slug}`"
        class="bg-ml-black p-7 hover:bg-white/[0.02] transition-colors group"
      >
        <div class="h-40 mb-5 overflow-hidden">
          <img
            v-if="post.image_url"
            :src="post.image_url"
            :alt="post.title"
            class="w-full h-full object-cover opacity-60 group-hover:opacity-80 group-hover:scale-105 transition-all duration-700"
          />
          <div v-else class="w-full h-full bg-white/[0.03]" />
        </div>
        <p class="text-[10px] tracking-[0.22em] uppercase text-white/25 mb-3">{{ post.tag || 'News' }}</p>
        <h2 class="text-[16px] font-medium leading-[1.45] text-white mb-4">{{ post.title }}</h2>
        <p class="text-[11px] text-white/20">{{ formatDate(post.published_at) }}</p>
      </NuxtLink>
    </div>

    <p v-else class="text-white/20 text-sm tracking-widest">Keine Beiträge vorhanden.</p>
  </div>
</template>

<script setup lang="ts">
useHead({ title: 'News – Medlake' })

const supabase = useSupabaseClient()

const { data: posts } = await useAsyncData('news-posts', async () => {
  const { data, error } = await supabase
    .from('news_posts')
    .select('*')
    .eq('published', true)
    .order('published_at', { ascending: false })
  if (error) throw error
  return data ?? []
})

function formatDate(d: string) {
  if (!d) return ''
  return new Date(d).toLocaleDateString('de-CH', { day: 'numeric', month: 'long', year: 'numeric' })
}
</script>
