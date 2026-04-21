<template>
  <div ref="el" class="min-h-screen pt-36 pb-24" style="background:var(--bg)">

    <!-- Header -->
    <div class="px-10 mb-20">
      <p class="reveal text-[10px] tracking-[0.3em] uppercase mb-5" style="color:var(--text-3)">Medlake · Küsnacht</p>
      <h1 class="reveal reveal-delay-1 font-semibold tracking-[-0.03em] leading-none" style="font-size:clamp(48px,7vw,96px);color:var(--text)">
        Das Team
      </h1>
      <p class="reveal reveal-delay-2 text-[15px] mt-6 leading-[1.8] max-w-lg" style="color:var(--text-2)">
        Menschen mit Leidenschaft für Gesundheit, Bewegung und persönliche Betreuung.
      </p>
    </div>

    <!-- Grid -->
    <div class="px-10 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-px" style="background:var(--border)">
      <div
        v-for="(member, i) in team"
        :key="member.name"
        class="reveal group"
        :class="`reveal-delay-${(i % 3) + 1}`"
        style="background:var(--bg)"
      >
        <!-- Photo -->
        <div class="overflow-hidden aspect-[3/4] relative" style="background:var(--bg-2)">
          <img
            v-if="member.photo_url"
            :src="member.photo_url"
            :alt="member.name"
            class="w-full h-full object-cover transition-transform duration-700 ease-out group-hover:scale-105"
          />
          <div
            v-else
            class="w-full h-full flex items-center justify-center text-[32px] font-medium tracking-wide"
            style="color:var(--text-3)"
          >
            {{ initials(member.name) }}
          </div>

          <!-- Hover overlay -->
          <div
            class="absolute inset-0 opacity-0 group-hover:opacity-100 transition-opacity duration-500"
            style="background:linear-gradient(to top, rgba(0,0,0,0.55) 0%, transparent 50%)"
          ></div>
        </div>

        <!-- Info -->
        <div class="px-7 py-6" style="border-top:1px solid var(--border)">
          <h2 class="text-[16px] font-medium mb-1.5 tracking-[-0.01em]" style="color:var(--text)">{{ member.name }}</h2>
          <p class="text-[10px] tracking-[0.15em] uppercase mb-3" style="color:var(--text-3)">{{ member.role }}</p>
          <p v-if="member.desc" class="text-[13px] leading-[1.7]" style="color:var(--text-2)">{{ member.desc }}</p>
        </div>
      </div>
    </div>

    <!-- CTA -->
    <div class="reveal px-10 mt-20 pt-12 border-t flex items-center justify-between" style="border-color:var(--border)">
      <div>
        <p class="text-[10px] tracking-[0.25em] uppercase mb-3" style="color:var(--text-3)">Teil des Teams werden?</p>
        <NuxtLink
          to="/jobs"
          class="inline-flex items-center gap-3 text-[11px] tracking-[0.18em] uppercase transition-opacity hover:opacity-60"
          style="color:var(--text-2)"
        >
          Offene Stellen ansehen
          <svg width="12" height="12" viewBox="0 0 12 12" fill="none">
            <path d="M1 6h10M6 1l5 5-5 5" stroke="currentColor" stroke-width="1" stroke-linecap="round" stroke-linejoin="round"/>
          </svg>
        </NuxtLink>
      </div>
      <p class="text-[10px] tracking-[0.2em] uppercase" style="color:var(--text-4)">{{ team.length }} Mitglieder</p>
    </div>

  </div>
</template>

<script setup lang="ts">
useHead({ title: 'Das Team – Medlake' })

const { el } = useReveal()

const team = await useTeamMembers()

function initials(name: string) {
  return name.split(' ').map(n => n[0]).slice(0, 2).join('').toUpperCase()
}
</script>
