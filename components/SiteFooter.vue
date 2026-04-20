<template>
  <footer class="section-divider bg-[#030303]">
    <!-- Big oversize label -->
    <div class="overflow-hidden select-none pointer-events-none">
      <p class="text-[clamp(60px,12vw,160px)] font-bold leading-none tracking-[-0.04em] text-white/[0.03] uppercase px-10 pt-8">
        Medlake
      </p>
    </div>

    <div class="px-10 pb-12 pt-4 flex flex-col md:flex-row items-start md:items-end justify-between gap-8">
      <!-- Left -->
      <div>
        <p class="text-xs tracking-[0.2em] uppercase text-white/20 mb-4">Medlake Training</p>
        <address class="not-italic text-xs text-white/30 leading-6">
          Seestrasse 39<br>
          8700 Küsnacht, Schweiz<br>
          <a href="tel:+41449912202" class="hover:text-white/60 transition-colors">+41 44 991 22 02</a><br>
          <a href="mailto:info@medlake.ch" class="hover:text-white/60 transition-colors">info@medlake.ch</a>
        </address>
      </div>

      <!-- Center links -->
      <nav class="flex flex-wrap gap-x-8 gap-y-3">
        <NuxtLink
          v-for="link in links"
          :key="link.to"
          :to="link.to"
          class="text-[10px] tracking-[0.15em] uppercase text-white/20 hover:text-white/60 transition-colors"
        >
          {{ link.label }}
        </NuxtLink>
      </nav>

      <!-- Right -->
      <div class="text-right">
        <p class="text-[10px] tracking-widest uppercase text-white/15">
          © {{ new Date().getFullYear() }} Medlake
        </p>
        <NuxtLink to="/admin" class="text-[10px] tracking-widest uppercase text-white/10 hover:text-white/30 transition-colors mt-1 block">
          Admin
        </NuxtLink>
      </div>
    </div>
  </footer>
</template>

<script setup lang="ts">
const links = [
  { to: '/team',       label: 'Team' },
  { to: '/aerzte',     label: 'Ärzte' },
  { to: '/preise',     label: 'Preise' },
  { to: '/news',       label: 'News' },
  { to: '/jobs',       label: 'Jobs' },
  { to: '/medizinisches', label: 'Medizinisches' },
  { to: '/agb',        label: 'AGB' },
  { to: '/kontakt',    label: 'Kontakt' },
]
</script>
