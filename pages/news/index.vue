<template>
  <div class="pt-36 px-10 pb-24 min-h-screen">
    <!-- Header -->
    <div class="mb-16 border-b pb-10" style="border-color:var(--border)">
      <p class="text-[12px] tracking-[0.28em] uppercase mb-4" style="color:var(--text-3)">Medlake</p>
      <h1 class="text-[clamp(40px,6vw,80px)] font-semibold tracking-[-0.025em] leading-none" style="color:var(--text)">News</h1>
    </div>

    <!-- Grid -->
    <div v-if="posts && posts.length" class="grid grid-cols-1 md:grid-cols-3 gap-px" style="background:var(--border);border:1px solid var(--border)">
      <NuxtLink
        v-for="post in posts"
        :key="post.id"
        :to="`/news/${post.slug}`"
        class="p-7 transition-colors group"
        style="background:var(--bg-card)"
        @mouseenter="($el as HTMLElement).style.background='var(--bg-2)'"
        @mouseleave="($el as HTMLElement).style.background='var(--bg-card)'"
      >
        <div class="h-40 mb-5 overflow-hidden" style="background:var(--bg-2)">
          <img
            v-if="post.image_url"
            :src="post.image_url"
            :alt="post.title"
            class="w-full h-full object-cover opacity-60 group-hover:opacity-80 group-hover:scale-105 transition-all duration-700"
          />
          <div v-else class="w-full h-full" style="background:var(--bg-2)" />
        </div>
        <p class="text-[12px] tracking-[0.22em] uppercase mb-3" style="color:var(--text-3)">{{ post.tag || 'News' }}</p>
        <h2 class="text-[16px] font-medium leading-[1.45] mb-4" style="color:var(--text)">{{ post.title }}</h2>
        <p class="text-[13px]" style="color:var(--text-4)">{{ formatDate(post.published_at) }}</p>
      </NuxtLink>
    </div>

    <p v-else class="text-sm tracking-widest" style="color:var(--text-3)">Keine Beiträge vorhanden.</p>
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
