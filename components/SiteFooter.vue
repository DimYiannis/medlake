<template>
  <footer class="section-divider" style="background:var(--footer-bg)">
    <div class="overflow-hidden select-none pointer-events-none">
      <p class="font-bold leading-none tracking-[-0.04em] uppercase px-10 pt-8"
        style="font-size:clamp(60px,12vw,160px);color:var(--bleed)">
        Medlake
      </p>
    </div>
    <div class="px-10 pb-12 pt-4 flex flex-col md:flex-row items-start md:items-end justify-between gap-8">
      <div>
        <p class="text-xs tracking-[0.2em] uppercase mb-4" style="color:var(--text-4)">Medlake Training</p>
        <address class="not-italic text-xs leading-6" style="color:var(--text-3)">
          Seestrasse 39<br>8700 Küsnacht, Schweiz<br>
          <a href="tel:+41449912202" class="hover:opacity-70 transition-opacity">+41 44 991 22 02</a><br>
          <a href="mailto:info@medlake.ch" class="hover:opacity-70 transition-opacity">info@medlake.ch</a>
        </address>
      </div>
      <nav class="flex flex-wrap gap-x-8 gap-y-3">
        <NuxtLink v-for="link in links" :key="link.to" :to="link.to"
          class="text-[10px] tracking-[0.15em] uppercase hover:opacity-60 transition-opacity" style="color:var(--text-3)">
          {{ link.label }}
        </NuxtLink>
      </nav>
      <div class="text-right">
        <p class="text-[10px] tracking-widest uppercase" style="color:var(--text-4)">© {{ new Date().getFullYear() }} Medlake</p>
        <NuxtLink to="/admin" class="text-[10px] tracking-widest uppercase mt-1 block hover:opacity-50 transition-opacity" style="color:var(--text-4)">Admin</NuxtLink>
      </div>
    </div>
  </footer>
</template>

<script setup lang="ts">
const links = [
  { to: '/team', label: 'Team' },
  { to: '/aerzte', label: 'Ärzte' },
  { to: '/preise', label: 'Preise' },
  { to: '/news', label: 'News' },
  { to: '/jobs', label: 'Jobs' },
  { to: '/medizinisches', label: 'Medizinisches' },
  { to: '/agb', label: 'AGB' },
  { to: '/kontakt', label: 'Kontakt' },
]
</script>
