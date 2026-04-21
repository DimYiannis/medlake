<template>
  <section ref="el" class="section-divider px-10 py-20">
    <p class="reveal text-[10px] tracking-[0.28em] uppercase mb-14" style="color:var(--text-3)">Galerie</p>

    <div class="grid grid-cols-2 md:grid-cols-3" style="gap:1px;background:var(--border);border:1px solid var(--border)">
      <div
        v-for="(photo, i) in displayPhotos"
        :key="photo.id || i"
        class="reveal aspect-[4/3] overflow-hidden cursor-pointer group relative flex items-center justify-center"
        :class="`reveal-delay-${(i % 3) + 1}`"
        style="background:var(--bg-card)"
        @click="openLightbox(i)"
      >
        <img v-if="photo.url" :src="photo.url" :alt="photo.caption || 'Medlake'"
          class="w-full h-full object-cover opacity-75 group-hover:opacity-95 group-hover:scale-105 transition-all duration-700" />
        <span v-else class="text-[9px] tracking-widest uppercase" style="color:var(--text-4)">Medlake</span>
        <div class="absolute inset-0 opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-center justify-center" style="background:rgba(0,0,0,0.2)">
          <span class="text-[10px] tracking-[0.2em] uppercase text-white/70">Ansehen</span>
        </div>
        <p v-if="photo.caption" class="absolute bottom-0 left-0 right-0 p-4 text-[11px] tracking-wide opacity-0 group-hover:opacity-100 transition-opacity text-white/80" style="background:linear-gradient(to top,rgba(0,0,0,0.6),transparent)">
          {{ photo.caption }}
        </p>
      </div>
    </div>

    <!-- Lightbox — always dark regardless of theme -->
    <Teleport to="body">
      <Transition name="lightbox">
        <div v-if="lightboxIndex !== null" class="fixed inset-0 z-[200] flex items-center justify-center" style="background:rgba(0,0,0,0.95)" @click.self="closeLightbox">
          <button class="absolute top-6 right-8 text-3xl text-white/40 hover:text-white transition-colors" @click="closeLightbox">×</button>
          <button class="absolute left-6 top-1/2 -translate-y-1/2 text-4xl text-white/30 hover:text-white transition-colors px-4 py-2" @click="prevPhoto">‹</button>
          <img v-if="displayPhotos[lightboxIndex]?.url" :src="displayPhotos[lightboxIndex].url" :alt="displayPhotos[lightboxIndex].caption || 'Medlake'" class="max-w-[85vw] max-h-[85vh] object-contain" />
          <div v-else class="text-white/20 text-sm tracking-widest">Kein Bild</div>
          <button class="absolute right-6 top-1/2 -translate-y-1/2 text-4xl text-white/30 hover:text-white transition-colors px-4 py-2" @click="nextPhoto">›</button>
          <p v-if="displayPhotos[lightboxIndex]?.caption" class="absolute bottom-8 left-1/2 -translate-x-1/2 text-[11px] tracking-widest uppercase text-white/30">
            {{ displayPhotos[lightboxIndex].caption }}
          </p>
        </div>
      </Transition>
    </Teleport>
  </section>
</template>

<script setup lang="ts">
const { el } = useReveal()
const supabase = useSupabaseClient()
const lightboxIndex = ref<number | null>(null)

const fallbackPhotos = Array.from({ length: 6 }, (_, i) => ({ id: i + 1, url: null, caption: null }))
const dbPhotos = ref<any[]>([])

onMounted(async () => {
  try {
    const { data } = await supabase.from('gallery_photos').select('*').order('sort_order', { ascending: true })
    if (data && data.length > 0) dbPhotos.value = data
  } catch {}
})

const displayPhotos = computed(() => dbPhotos.value.length ? dbPhotos.value : fallbackPhotos)

function openLightbox(i: number) { lightboxIndex.value = i }
function closeLightbox() { lightboxIndex.value = null }
function prevPhoto() { if (lightboxIndex.value === null) return; lightboxIndex.value = (lightboxIndex.value - 1 + displayPhotos.value.length) % displayPhotos.value.length }
function nextPhoto() { if (lightboxIndex.value === null) return; lightboxIndex.value = (lightboxIndex.value + 1) % displayPhotos.value.length }

onKeyStroke('Escape', closeLightbox)
onKeyStroke('ArrowLeft', prevPhoto)
onKeyStroke('ArrowRight', nextPhoto)
</script>

<style scoped>
.lightbox-enter-active, .lightbox-leave-active { transition: opacity 0.25s ease; }
.lightbox-enter-from, .lightbox-leave-to { opacity: 0; }
</style>
