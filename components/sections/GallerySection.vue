<template>
  <section ref="el" class="section-divider px-10 py-20">
    <p class="reveal text-[10px] tracking-[0.28em] uppercase text-white/25 mb-14">Galerie</p>

    <div class="grid grid-cols-2 md:grid-cols-3 gap-px bg-ml-border">
      <div
        v-for="(photo, i) in displayPhotos"
        :key="photo.id || i"
        class="reveal aspect-[4/3] overflow-hidden bg-[#0d0d0d] cursor-pointer group relative"
        :class="`reveal-delay-${(i % 3) + 1}`"
        @click="openLightbox(i)"
      >
        <img
          v-if="photo.url"
          :src="photo.url"
          :alt="photo.caption || 'Medlake'"
          class="w-full h-full object-cover opacity-70 group-hover:opacity-90 group-hover:scale-105 transition-all duration-700"
        />
        <div v-else class="w-full h-full flex items-center justify-center">
          <span class="text-[9px] tracking-widest uppercase text-white/10">Medlake</span>
        </div>
        <div class="absolute inset-0 bg-black/0 group-hover:bg-black/20 transition-colors duration-300" />
        <p
          v-if="photo.caption"
          class="absolute bottom-0 left-0 right-0 p-4 text-[11px] text-white/0 group-hover:text-white/70 transition-colors duration-300 tracking-wide bg-gradient-to-t from-black/60 to-transparent"
        >
          {{ photo.caption }}
        </p>
      </div>
    </div>

    <!-- Lightbox -->
    <Teleport to="body">
      <Transition name="lightbox">
        <div
          v-if="lightboxIndex !== null"
          class="fixed inset-0 z-[200] bg-black/95 flex items-center justify-center"
          @click.self="closeLightbox"
        >
          <button
            class="absolute top-6 right-8 text-white/40 hover:text-white text-3xl transition-colors"
            @click="closeLightbox"
          >
            ×
          </button>
          <button
            class="absolute left-6 top-1/2 -translate-y-1/2 text-white/30 hover:text-white text-4xl transition-colors px-4 py-2"
            @click="prevPhoto"
          >
            ‹
          </button>
          <img
            v-if="displayPhotos[lightboxIndex]?.url"
            :src="displayPhotos[lightboxIndex].url"
            :alt="displayPhotos[lightboxIndex].caption || 'Medlake'"
            class="max-w-[85vw] max-h-[85vh] object-contain"
          />
          <div v-else class="text-white/20 text-sm tracking-widest">Kein Bild</div>
          <button
            class="absolute right-6 top-1/2 -translate-y-1/2 text-white/30 hover:text-white text-4xl transition-colors px-4 py-2"
            @click="nextPhoto"
          >
            ›
          </button>
          <p
            v-if="displayPhotos[lightboxIndex]?.caption"
            class="absolute bottom-8 left-1/2 -translate-x-1/2 text-[11px] tracking-widest uppercase text-white/30"
          >
            {{ displayPhotos[lightboxIndex].caption }}
          </p>
        </div>
      </Transition>
    </Teleport>
  </section>
</template>

<script setup lang="ts">
const { el } = useReveal()
const lightboxIndex = ref<number | null>(null)

const fallbackPhotos = Array.from({ length: 6 }, (_, i) => ({
  id: i + 1,
  url: null,
  caption: null,
}))

const dbPhotos = ref<any[]>([])

onMounted(async () => {
  try {
    const supabase = useSupabase()
    const { data } = await supabase
      .from('gallery_photos')
      .select('*')
      .order('sort_order', { ascending: true })
    if (data && data.length > 0) dbPhotos.value = data
  } catch { /* fallback */ }
})

const displayPhotos = computed(() =>
  dbPhotos.value.length ? dbPhotos.value : fallbackPhotos
)

function openLightbox(i: number) { lightboxIndex.value = i }
function closeLightbox() { lightboxIndex.value = null }
function prevPhoto() {
  if (lightboxIndex.value === null) return
  lightboxIndex.value = (lightboxIndex.value - 1 + displayPhotos.value.length) % displayPhotos.value.length
}
function nextPhoto() {
  if (lightboxIndex.value === null) return
  lightboxIndex.value = (lightboxIndex.value + 1) % displayPhotos.value.length
}

onKeyStroke('Escape', closeLightbox)
onKeyStroke('ArrowLeft', prevPhoto)
onKeyStroke('ArrowRight', nextPhoto)
</script>

<style scoped>
.lightbox-enter-active, .lightbox-leave-active { transition: opacity 0.25s ease; }
.lightbox-enter-from, .lightbox-leave-to { opacity: 0; }
</style>
