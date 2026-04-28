<template>
  <div class="relative" ref="el">
    <button
      class="text-[11px] tracking-[0.15em] uppercase px-2 py-1 transition-opacity hover:opacity-80 flex items-center gap-1"
      :style="{ color: 'var(--text-3)' }"
      @click="open = !open"
    >
      {{ locale.toUpperCase() }}
      <svg width="8" height="8" viewBox="0 0 8 8" fill="none" class="transition-transform duration-200" :class="open ? 'rotate-180' : ''">
        <path d="M1 2l3 3 3-3" stroke="currentColor" stroke-width="1.2" stroke-linecap="round" stroke-linejoin="round"/>
      </svg>
    </button>

    <Transition name="lang-drop">
      <div
        v-if="open"
        class="absolute right-0 top-full mt-1 py-1 min-w-[80px] border"
        style="background:var(--nav-bg);border-color:var(--border);backdrop-filter:blur(12px)"
      >
        <button
          v-for="loc in availableLocales"
          :key="loc.code"
          class="w-full text-left px-3 py-1.5 text-[11px] tracking-[0.15em] uppercase transition-opacity"
          :class="locale === loc.code ? 'opacity-100' : 'opacity-40 hover:opacity-80'"
          :style="{ color: 'var(--text)' }"
          @click="switchTo(loc.code)"
        >
          {{ loc.code.toUpperCase() }}
        </button>
      </div>
    </Transition>
  </div>
</template>

<script setup lang="ts">
const { locale, locales, setLocale } = useI18n()
const switchLocalePath = useSwitchLocalePath()
const router = useRouter()
const open = ref(false)
const el = ref<HTMLElement | null>(null)

const availableLocales = computed(() =>
  (locales.value as Array<{ code: string; name: string }>).filter(Boolean)
)

function switchTo(code: string) {
  open.value = false
  if (code === locale.value) return
  const path = switchLocalePath(code)
  if (path) router.push(path)
  else setLocale(code as any)
}

onMounted(() => {
  const handler = (e: MouseEvent) => {
    if (el.value && !el.value.contains(e.target as Node)) open.value = false
  }
  document.addEventListener('click', handler)
  onUnmounted(() => document.removeEventListener('click', handler))
})
</script>

<style scoped>
.lang-drop-enter-active, .lang-drop-leave-active { transition: opacity 0.15s ease, transform 0.15s ease; }
.lang-drop-enter-from, .lang-drop-leave-to { opacity: 0; transform: translateY(-4px); }
</style>
