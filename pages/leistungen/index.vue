<template>
  <div class="min-h-screen pt-32 pb-24" style="background:var(--bg)">

    <div class="px-10 mb-16 border-b pb-12" style="border-color:var(--border)">
      <p class="text-[10px] tracking-[0.3em] uppercase mb-4" style="color:var(--text-3)">Medlake</p>
      <h1 class="font-semibold tracking-[-0.025em] leading-none" style="font-size:clamp(36px,6vw,80px);color:var(--text)">
        Unser Angebot
      </h1>
      <p class="text-[15px] mt-5 leading-[1.8] max-w-xl" style="color:var(--text-2)">
        Kompetenzzentrum für Kraft- und Ausdauertraining — medizinisch begleitet von Fachärzten und Physiotherapeutinnen.
      </p>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-2 border-l border-t" style="border-color:var(--border)">
      <NuxtLink
        v-for="(s, i) in services"
        :key="s.slug"
        :to="`/leistungen/${s.slug}`"
        class="service-card group border-r border-b px-10 py-10 block transition-colors"
        style="border-color:var(--border)"
      >
        <div class="flex items-start justify-between mb-5">
          <span class="text-[11px] tracking-[0.2em]" style="color:var(--text-4)">
            {{ String(i + 1).padStart(2, '0') }}
          </span>
          <svg width="14" height="14" viewBox="0 0 14 14" fill="none"
            class="opacity-0 group-hover:opacity-100 transition-all duration-300 group-hover:translate-x-1"
            style="color:var(--text-3)">
            <path d="M1 7h12M7 1l6 6-6 6" stroke="currentColor" stroke-width="1" stroke-linecap="round" stroke-linejoin="round"/>
          </svg>
        </div>
        <h2
          class="font-medium tracking-[-0.01em] mb-3 transition-opacity duration-200 group-hover:opacity-60"
          style="font-size:clamp(18px,2vw,24px);color:var(--text)"
        >{{ s.title }}</h2>
        <p class="text-[13px] leading-[1.7]" style="color:var(--text-3)">{{ s.excerpt }}</p>
      </NuxtLink>
    </div>

  </div>
</template>

<script setup lang="ts">
useHead({ title: 'Leistungen – Medlake' })

const services = [
  { slug: 'krafttraining',    title: 'Krafttraining',                                   excerpt: 'Gesundheitsorientiertes Training für besseren Allgemeinzustand und Schmerzprävention.' },
  { slug: 'herz-kreislauf',   title: 'Herz & Kreislauf',                                excerpt: 'Cardio-Training für ein starkes, ökonomisches Herzkreislaufsystem.' },
  { slug: 'hilfe-bei-schmerzen', title: 'Hilfe bei Schmerzen',                          excerpt: 'Behandlung von Nacken-, Rücken- und Gelenkschmerzen durch drei Spezialärzte.' },
  { slug: 'firmenfitness',    title: 'Firmenfitness',                                   excerpt: 'Kooperation für Unternehmensgesundheit — investieren Sie in Ihre Mitarbeitenden.' },
  { slug: 'med-x',            title: 'Ärztliche Trainingstherapie (MED-X)',             excerpt: 'Computerisierte MedX-Geräte für präzisen Muskelaufbau im Nacken- und Lendenbereich.' },
  { slug: 'physiotherapie',   title: 'Physiotherapie & MTT',                            excerpt: 'Medizinische Trainingstherapie zur Steigerung der Belastbarkeit des Bewegungsapparates.' },
  { slug: 'galileo',          title: 'Galileo Vibrationsplatte',                        excerpt: 'Seitenalternierende Vibration für Muskelaufbau, Rehabilitation und Schmerztherapie.' },
  { slug: 'kinesis',          title: 'KINESIS Training',                                excerpt: 'Funktionelles Ganzkörpertraining für Kraft, Flexibilität und Koordination.' },
]
</script>

<style scoped>
.service-card { background: var(--bg); }
.service-card:hover { background: var(--bg-card); }
</style>
