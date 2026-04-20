<template>
  <div class="min-h-screen pt-36 pb-24" style="background:var(--bg)">

    <div class="px-10 mb-16 border-b pb-12" style="border-color:var(--border)">
      <p class="text-[10px] tracking-[0.3em] uppercase mb-4" style="color:var(--text-3)">Medlake</p>
      <h1 class="font-semibold tracking-[-0.025em] leading-none" style="font-size:clamp(40px,6vw,80px);color:var(--text)">
        Das Team
      </h1>
      <p class="text-[15px] mt-5 leading-[1.8] max-w-xl" style="color:var(--text-2)">
        Menschen mit Leidenschaft für Gesundheit, Bewegung und persönliche Betreuung — das ist das Medlake Team.
      </p>
    </div>

    <!-- Team grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 gap-px px-10" style="background:var(--border)">
      <div
        v-for="member in team"
        :key="member.name"
        class="flex gap-7 px-8 py-10 transition-colors"
        style="background:var(--bg)"
        @mouseenter="e => (e.currentTarget as HTMLElement).style.background = 'var(--bg-card)'"
        @mouseleave="e => (e.currentTarget as HTMLElement).style.background = 'var(--bg)'"
      >
        <!-- Avatar / photo -->
        <div class="w-16 h-16 rounded-full flex-shrink-0 overflow-hidden flex items-center justify-center text-[16px] font-medium"
          style="background:var(--bg-2);color:var(--text-3)">
          <img
            v-if="member.photo"
            :src="member.photo"
            :alt="member.name"
            class="w-full h-full object-cover"
          />
          <span v-else>{{ initials(member.name) }}</span>
        </div>

        <div>
          <h2 class="text-[17px] font-medium mb-1" style="color:var(--text)">{{ member.name }}</h2>
          <p class="text-[11px] tracking-[0.12em] uppercase mb-3" style="color:var(--text-3)">{{ member.role }}</p>
          <p v-if="member.desc" class="text-[13px] leading-[1.7]" style="color:var(--text-2)">{{ member.desc }}</p>
        </div>
      </div>
    </div>

    <!-- Join CTA -->
    <div class="px-10 mt-16 pt-12 border-t" style="border-color:var(--border)">
      <p class="text-[10px] tracking-[0.25em] uppercase mb-3" style="color:var(--text-3)">Teil des Teams werden?</p>
      <NuxtLink to="/jobs"
        class="inline-flex items-center gap-2 text-[11px] tracking-[0.18em] uppercase transition-opacity hover:opacity-60"
        style="color:var(--text-2)">
        Offene Stellen ansehen
        <svg width="12" height="12" viewBox="0 0 12 12" fill="none"><path d="M1 6h10M6 1l5 5-5 5" stroke="currentColor" stroke-width="1" stroke-linecap="round" stroke-linejoin="round"/></svg>
      </NuxtLink>
    </div>

  </div>
</template>

<script setup lang="ts">
useHead({ title: 'Das Team – Medlake' })

const team = [
  {
    name:  'Andrea Badstuber',
    role:  'Geschäftsführerin / Mitinhaberin',
    photo: '/images/andrea.jpg',
    desc:  null,
  },
  {
    name:  'Leonardo Tomazini',
    role:  'Stv. Geschäftsführer',
    photo: 'images/tomazini.jpg',
    desc:  'Spezialist Bewegungs- und Gesundheitsförderung mit eidg. Fachausweis',
  },
  {
    name:  'Tiffany Ismann',
    role:  'Fitnessinstruktorin',
    photo: '/images/tiffany.png',
    desc:  null,
  },
  {
    name:  'Natalie Oriet Rota',
    role:  'Spezialistin Bewegungs- und Gesundheitsförderung',
    photo: 'images/natalie.jpg',
    desc:  'Mit eidg. Fachausweis',
  },
  {
    name:  'Alexandros Dimopoulos',
    role:  'Fitnessinstruktor',
    photo: '/images/alex.jpg',
    desc:  'Bachelor-Abschluss in Sportwissenschaft',
  },
  {
    name:  'Florence Winkler',
    role:  'Fitnessinstruktorin',
    photo: '/images/florence.jpg',
    desc:  'Ausbildung zur Spezialistin Bewegungs- und Gesundheitsförderung mit eidg. Fachausweis',
  },
  {
    name:  'Junioh Kamara',
    role:  'Fachmann Bewegungs- und Gesundheitsförderung',
    photo: null,
    desc:  'Mit EFZ',
  },
]

function initials(name: string) {
  return name.split(' ').map(n => n[0]).slice(0, 2).join('').toUpperCase()
}
</script>
