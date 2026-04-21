<template>
  <div class="min-h-screen pt-36 pb-24" style="background:var(--bg)">

    <!-- Header -->
    <div class="px-10 mb-16 border-b pb-12" style="border-color:var(--border)">
      <p class="text-[10px] tracking-[0.3em] uppercase mb-4" style="color:var(--text-3)">Medlake</p>
      <h1 class="font-semibold tracking-[-0.025em] leading-none" style="font-size:clamp(40px,6vw,80px);color:var(--text)">
        Unsere Ärzte
      </h1>
      <p class="text-[15px] mt-5 leading-[1.8] max-w-xl" style="color:var(--text-2)">
        Fach- und Spezialärzte begleiten Sie auf dem Weg zu mehr Gesundheit und Wohlbefinden — direkt vor Ort im Medlake.
      </p>
    </div>

    <!-- Doctors -->
    <div class="px-10 space-y-px" style="border-top:1px solid var(--border)">
      <div v-for="doctor in doctors" :key="doctor.id"
        class="grid grid-cols-1 md:grid-cols-3 gap-px" style="background:var(--border)">
        <div class="px-10 py-12 md:col-span-1" style="background:var(--bg-card)">
          <div class="w-20 h-20 rounded-full mb-6 overflow-hidden flex items-center justify-center"
            style="background:var(--bg-2)">
            <img v-if="doctor.photo_url" :src="doctor.photo_url" :alt="doctor.name"
              class="w-full h-full object-cover object-top" />
          </div>
          <p class="text-[10px] tracking-[0.2em] uppercase mb-1" style="color:var(--text-3)">{{ doctor.role }}</p>
          <h2 class="text-[22px] font-medium mb-2" style="color:var(--text)">{{ doctor.name }}</h2>
          <p class="text-[13px] leading-[1.6] mb-6" style="color:var(--text-3)">{{ doctor.specialty }}</p>
          <a v-if="doctor.phone" :href="`tel:${doctor.phone.replace(/\s/g,'')}`"
            class="inline-flex items-center gap-2 text-[11px] tracking-[0.15em] uppercase transition-opacity hover:opacity-60"
            style="color:var(--text-2)">
            <svg width="12" height="12" viewBox="0 0 12 12" fill="none">
              <path d="M10.5 8.5c-.5.5-1 1-1.5 1C6 9.5 2.5 6 2.5 3c0-.5.5-1 1-1.5L5 3l-1 2 1.5 1.5L7 5l1.5 3.5z"
                stroke="currentColor" stroke-width="1" stroke-linecap="round"/>
            </svg>
            {{ doctor.phone }}
          </a>
        </div>
        <div class="px-10 py-12 md:col-span-2" style="background:var(--bg)">
          <p class="text-[10px] tracking-[0.2em] uppercase mb-5" style="color:var(--text-3)">Ausbildung & Werdegang</p>
          <div class="space-y-4">
            <div v-for="item in doctor.bio" :key="item" class="flex gap-4">
              <span class="mt-1.5 w-1.5 h-1.5 rounded-full flex-shrink-0" style="background:var(--text-4)" />
              <p class="text-[14px] leading-[1.7]" style="color:var(--text-2)">{{ item }}</p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- CTA -->
    <div class="px-10 mt-16 pt-12 border-t" style="border-color:var(--border)">
      <p class="text-[10px] tracking-[0.25em] uppercase mb-6" style="color:var(--text-3)">Termin vereinbaren</p>
      <a
        href="https://connect.shore.com/bookings/medlake-training/services"
        target="_blank" rel="noopener"
        class="inline-flex items-center gap-3 text-[11px] tracking-[0.2em] uppercase px-7 py-4 font-medium transition-opacity hover:opacity-80"
        style="background:var(--btn-bg);color:var(--btn-text)"
      >
        Jetzt buchen
        <svg width="12" height="12" viewBox="0 0 12 12" fill="none">
          <path d="M1 6h10M6 1l5 5-5 5" stroke="currentColor" stroke-width="1" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
      </a>
    </div>

  </div>
</template>

<script setup lang="ts">
useHead({ title: 'Unsere Ärzte – Medlake' })
const doctors = await useDoctors()
</script>