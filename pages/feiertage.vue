<template>
  <div class="min-h-screen pt-36 pb-24" style="background:var(--bg)">

    <!-- Header -->
    <div class="px-10 mb-16 border-b pb-12" style="border-color:var(--border)">
      <p class="text-[10px] tracking-[0.3em] uppercase mb-4" style="color:var(--text-3)">Medlake</p>
      <h1 class="font-semibold tracking-[-0.025em] leading-none" style="font-size:clamp(40px,6vw,80px);color:var(--text)">
        Feiertage
      </h1>
      <p class="text-[15px] mt-5 leading-[1.8] max-w-xl" style="color:var(--text-2)">
        Unsere Öffnungszeiten an Feiertagen. An Weihnachten und Neujahr können die Zeiten variieren.
      </p>
    </div>

    <!-- Holiday tables -->
    <div class="px-10 space-y-16">
      <div v-for="year in schedule" :key="year.year">
        <p class="text-[10px] tracking-[0.25em] uppercase mb-6" style="color:var(--text-3)">{{ year.year }}</p>
        <div class="border" style="border-color:var(--border)">
          <div
            v-for="(entry, i) in year.entries"
            :key="i"
            class="flex items-center gap-6 px-6 py-4 border-b last:border-b-0"
            style="border-color:var(--border);background:var(--bg)"
          >
            <p class="text-[13px] w-28 flex-shrink-0 tabular-nums" style="color:var(--text-3)">{{ entry.date }}</p>
            <p class="flex-1 text-[14px]" style="color:var(--text)">{{ entry.holiday }}</p>
            <p
              class="text-[13px] font-medium flex-shrink-0"
              :style="entry.hours === 'GESCHLOSSEN' ? 'color:#f87171' : 'color:var(--text-2)'"
            >
              {{ entry.hours }}
            </p>
          </div>
        </div>
      </div>
    </div>

    <!-- Note -->
    <div class="px-10 mt-12 pt-10 border-t" style="border-color:var(--border)">
      <p class="text-[13px] leading-[1.8] max-w-xl" style="color:var(--text-3)">
        Änderungen vorbehalten. Bei Fragen stehen wir Ihnen unter
        <a href="tel:+41449912202" class="underline underline-offset-2 hover:opacity-70 transition-opacity">+41 44 991 22 02</a>
        oder
        <a href="mailto:info@medlake.ch" class="underline underline-offset-2 hover:opacity-70 transition-opacity">info@medlake.ch</a>
        gerne zur Verfügung.
      </p>
    </div>

  </div>
</template>

<script setup lang="ts">
useHead({ title: 'Feiertage – Medlake' })
const schedule = await useHolidays()
</script>
