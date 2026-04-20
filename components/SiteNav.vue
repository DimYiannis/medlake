<template>
  <nav
    ref="navEl"
    class="fixed top-0 left-0 right-0 z-50 flex items-center justify-between px-10 py-6 transition-all duration-500"
    :class="scrolled ? 'bg-ml-black/90 backdrop-blur-sm border-b border-ml-border' : ''"
  >
    <!-- Logo -->
    <NuxtLink to="/" class="text-white text-sm font-medium tracking-[0.2em] uppercase hover:opacity-70 transition-opacity">
      Med<span class="text-white/40">lake</span>
    </NuxtLink>

    <!-- Desktop links -->
    <ul class="hidden md:flex items-center gap-8 list-none">
      <li v-for="link in links" :key="link.to">
        <NuxtLink
          :to="link.to"
          class="text-[11px] text-white/50 hover:text-white transition-colors tracking-[0.15em] uppercase"
        >
          {{ link.label }}
        </NuxtLink>
      </li>
    </ul>

    <!-- CTA -->
    <a
      href="https://connect.shore.com/bookings/medlake-training/services"
      target="_blank"
      rel="noopener"
      class="hidden md:inline-flex items-center gap-2 text-[11px] tracking-[0.15em] uppercase border border-white/25 px-5 py-2.5 text-white hover:bg-white hover:text-ml-black transition-all duration-300"
    >
      Termin buchen
    </a>

    <!-- Mobile burger -->
    <button
      class="md:hidden flex flex-col gap-1.5 p-1"
      @click="mobileOpen = !mobileOpen"
      aria-label="Menu öffnen"
    >
      <span class="block w-5 h-px bg-white transition-all" :class="mobileOpen ? 'rotate-45 translate-y-2' : ''" />
      <span class="block w-5 h-px bg-white transition-all" :class="mobileOpen ? 'opacity-0' : ''" />
      <span class="block w-5 h-px bg-white transition-all" :class="mobileOpen ? '-rotate-45 -translate-y-2' : ''" />
    </button>

    <!-- Mobile menu -->
    <Transition name="mobile-menu">
      <div
        v-if="mobileOpen"
        class="absolute top-full left-0 right-0 bg-ml-black border-b border-ml-border py-8 px-10 md:hidden"
      >
        <ul class="flex flex-col gap-6 list-none mb-8">
          <li v-for="link in links" :key="link.to">
            <NuxtLink
              :to="link.to"
              class="text-sm text-white/60 hover:text-white tracking-widest uppercase"
              @click="mobileOpen = false"
            >
              {{ link.label }}
            </NuxtLink>
          </li>
        </ul>
        <a
          href="https://connect.shore.com/bookings/medlake-training/services"
          target="_blank"
          class="inline-block text-[11px] tracking-[0.15em] uppercase border border-white/25 px-5 py-3 text-white"
        >
          Termin buchen
        </a>
      </div>
    </Transition>
  </nav>
</template>

<script setup lang="ts">
const navEl = ref<HTMLElement | null>(null)
const scrolled = ref(false)
const mobileOpen = ref(false)

const links = [
  { to: '/team',    label: 'Team' },
  { to: '/aerzte',  label: 'Ärzte' },
  { to: '/preise',  label: 'Preise' },
  { to: '/news',    label: 'News' },
  { to: '/kontakt', label: 'Kontakt' },
]

onMounted(() => {
  const onScroll = () => { scrolled.value = window.scrollY > 40 }
  window.addEventListener('scroll', onScroll, { passive: true })
  onUnmounted(() => window.removeEventListener('scroll', onScroll))
})
</script>

<style scoped>
.mobile-menu-enter-active,
.mobile-menu-leave-active {
  transition: opacity 0.25s ease, transform 0.25s ease;
}
.mobile-menu-enter-from,
.mobile-menu-leave-to {
  opacity: 0;
  transform: translateY(-8px);
}
</style>
