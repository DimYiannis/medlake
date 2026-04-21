<template>
  <nav
    class="fixed top-0 left-0 right-0 z-50 flex items-center justify-between px-10 py-6 transition-all duration-500"
    :class="{ 'nav-scrolled': scrolled }"
  >
    <NuxtLink to="/" class="text-sm font-medium tracking-[0.2em] uppercase transition-opacity hover:opacity-60" style="color:var(--text)">
      Med<span style="color:var(--text-3)">lake</span>
    </NuxtLink>

    <ul class="hidden nav:flex items-center gap-8 list-none">
      <li v-for="link in links" :key="link.to">
        <NuxtLink :to="link.to"
          class="text-[11px] tracking-[0.15em] uppercase transition-opacity hover:opacity-80"
          style="color:var(--text-3)">
          {{ link.label }}
        </NuxtLink>
      </li>
    </ul>

    <div class="hidden nav:flex items-center gap-1">
      <ClientOnly><UiThemeToggle /></ClientOnly>
      <a
        href="https://connect.shore.com/bookings/medlake-training/services"
        target="_blank"
        rel="noopener"
        class="cta-btn text-[11px] tracking-[0.15em] uppercase px-5 py-2.5 transition-all duration-300 border"
      >
        Termin buchen
      </a>
    </div>

    <div class="nav:hidden flex items-center gap-1">
      <ClientOnly><UiThemeToggle /></ClientOnly>
      <button class="flex flex-col gap-1.5 p-1" @click="mobileOpen = !mobileOpen" aria-label="Menu">
        <span class="block w-5 h-px transition-all" style="background:var(--text)" :class="mobileOpen ? 'rotate-45 translate-y-2' : ''" />
        <span class="block w-5 h-px transition-all" style="background:var(--text)" :class="mobileOpen ? 'opacity-0' : ''" />
        <span class="block w-5 h-px transition-all" style="background:var(--text)" :class="mobileOpen ? '-rotate-45 -translate-y-2' : ''" />
      </button>
    </div>

    <Transition name="mobile-menu">
      <div
        v-if="mobileOpen"
        class="absolute top-full left-0 right-0 py-8 px-10 nav:hidden border-b"
        style="background:var(--nav-bg);border-color:var(--border);backdrop-filter:blur(12px)"
      >
        <ul class="flex flex-col gap-6 list-none mb-8">
          <li v-for="link in links" :key="link.to">
            <NuxtLink :to="link.to" class="text-sm tracking-widest uppercase" style="color:var(--text-3)" @click="mobileOpen = false">
              {{ link.label }}
            </NuxtLink>
          </li>
        </ul>
        <a
          href="https://connect.shore.com/bookings/medlake-training/services"
          target="_blank"
          class="cta-btn text-[11px] tracking-[0.15em] uppercase inline-block px-5 py-3 border"
        >
          Termin buchen
        </a>
      </div>
    </Transition>
  </nav>
</template>

<script setup lang="ts">
const mobileOpen = ref(false)
const scrolled = ref(false)

const links = [
  { to: '/team',          label: 'Team' },
  { to: '/aerzte',        label: 'Ärzte' },
  { to: '/preise',        label: 'Preise' },
  { to: '/news',          label: 'News' },
  { to: '/jobs',          label: 'Jobs' },
  { to: '/medizinisches', label: 'Medizinisches' },
  { to: '/kontakt',       label: 'Kontakt' },
  { to: '/agb',           label: 'AGB' },
]

onMounted(() => {
  const fn = () => { scrolled.value = window.scrollY > 40 }
  window.addEventListener('scroll', fn, { passive: true })
  onUnmounted(() => window.removeEventListener('scroll', fn))
})
</script>

<style scoped>
.nav-scrolled {
  background: var(--nav-bg);
  backdrop-filter: blur(12px);
  border-bottom: 1px solid var(--border);
}
.cta-btn {
  color: var(--text);
  border-color: var(--border-2);
  background: transparent;
}
.cta-btn:hover {
  background: var(--btn-bg);
  color: var(--btn-text);
  border-color: var(--btn-bg);
}
.mobile-menu-enter-active,
.mobile-menu-leave-active {
  transition: opacity 0.2s ease, transform 0.2s ease;
}
.mobile-menu-enter-from,
.mobile-menu-leave-to {
  opacity: 0;
  transform: translateY(-8px);
}
</style>