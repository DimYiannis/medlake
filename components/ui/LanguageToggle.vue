<template>
  <div class="flex items-center gap-1">
    <button
      v-for="loc in availableLocales"
      :key="loc.code"
      class="text-[11px] tracking-[0.15em] uppercase px-2 py-1 transition-opacity"
      :class="locale === loc.code ? 'opacity-100' : 'opacity-40 hover:opacity-70'"
      :style="{ color: 'var(--text)' }"
      :aria-label="`Switch to ${loc.name}`"
      @click="switchTo(loc.code)"
    >
      {{ loc.code.toUpperCase() }}
    </button>
  </div>
</template>

<script setup lang="ts">
const { locale, locales, setLocale } = useI18n()
const switchLocalePath = useSwitchLocalePath()
const router = useRouter()

const availableLocales = computed(() =>
  (locales.value as Array<{ code: string; name: string }>).filter(Boolean)
)

function switchTo(code: string) {
  if (code === locale.value) return
  const path = switchLocalePath(code)
  if (path) router.push(path)
  else setLocale(code as any)
}
</script>
