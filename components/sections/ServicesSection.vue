<template>
  <section ref="el" class="section-divider px-10 py-20">
    <p class="reveal text-[10px] tracking-[0.28em] uppercase mb-12" style="color:var(--text-3)">Unser Angebot</p>

    <div>
      <div
        v-for="(service, i) in services"
        :key="service.name"
        class="service-row border-b"
        style="border-color:var(--border)"
      >
        <!-- Header toggles accordion -->
        <div
          class="flex items-center cursor-pointer py-8"
          @click="toggle(i)"
        >
          <span class="flex-shrink-0 w-16 text-[11px] tracking-[0.2em] font-medium" style="color:var(--text-4)">
            {{ String(i + 1).padStart(2, '0') }}
          </span>
          <h3
            class="flex-1 font-medium tracking-[-0.01em] pr-4 transition-opacity duration-300"
            style="font-size:clamp(18px,2.2vw,28px);color:var(--text)"
          >
            {{ service.name }}
          </h3>
          <span
            class="flex-shrink-0 w-10 text-right text-2xl transition-all duration-300"
            :style="activeIndex === i
              ? 'transform:rotate(45deg);color:var(--text-2)'
              : 'color:var(--text-4)'"
          >+</span>
        </div>

        <!-- Body: outside toggle, no reveal class -->
        <div
          v-if="activeIndex === i"
          class="pl-16 pb-8"
        >
          <p class="text-[13px] leading-[1.85] max-w-xl mb-5" style="color:var(--text-2)">
            {{ service.desc }}
          </p>
          <NuxtLink
            :to="service.link"
            class="inline-flex items-center gap-2 text-[11px] tracking-[0.18em] uppercase transition-opacity hover:opacity-60"
            style="color:var(--text-2)"
          >
            Mehr erfahren
            <svg width="12" height="12" viewBox="0 0 12 12" fill="none">
              <path d="M1 6h10M6 1l5 5-5 5" stroke="currentColor" stroke-width="1" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
          </NuxtLink>
        </div>
      </div>
    </div>

    <div class="mt-12">
      <NuxtLink
        to="/leistungen"
        class="inline-flex items-center gap-3 text-[11px] tracking-[0.2em] uppercase transition-opacity hover:opacity-60"
        style="color:var(--text-3)"
      >
        Alle Leistungen ansehen
        <svg width="12" height="12" viewBox="0 0 12 12" fill="none">
          <path d="M1 6h10M6 1l5 5-5 5" stroke="currentColor" stroke-width="1" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
      </NuxtLink>
    </div>
  </section>
</template>

<script setup lang="ts">
const { el } = useReveal()
const activeIndex = ref(0)

function toggle(i: number) {
  activeIndex.value = activeIndex.value === i ? -1 : i
}

const services = [
  { name: 'Krafttraining',                       link: '/leistungen/krafttraining',       desc: 'Gesundheitsorientiertes Krafttraining führt zu einem besseren Allgemeinzustand. Mitverantwortlich für akute und chronische Schmerzen des Bewegungsapparates sind schwache Muskeln. Wir trainieren präzise, medizinisch begleitet — mit messbaren Ergebnissen.' },
  { name: 'Herz & Kreislauf',                    link: '/leistungen/herz-kreislauf',      desc: 'Cardio-Training führt zur Ökonomisierung des Herzkreislaufsystems mit verbesserter Muskeldurchblutung. Trainierte Herzen schlagen ruhiger, kraftvoller, ausdauernder.' },
  { name: 'Hilfe bei Schmerzen',                 link: '/leistungen/hilfe-bei-schmerzen', desc: 'Schmerzen im Nacken, Rücken und Gelenken werden von drei Spezialärzten mit computerisierten Kräftigungsgeräten behandelt — unterstützt von Physiotherapeutinnen.' },
  { name: 'Firmenfitness',                       link: '/leistungen/firmenfitness',       desc: 'Ihr Beitrag zur Gesundheit Ihrer Mitarbeitenden. Profitieren Sie von unserer Firmen-Kooperation und investieren Sie in die Leistungsfähigkeit Ihres Teams.' },
  { name: 'Ärztliche Trainingstherapie (MED-X)', link: '/leistungen/med-x',               desc: 'Computerisierte MedX-Geräte fördern den Muskelaufbau im Nacken- und Lendenbereich. Jede Therapieeinheit erfolgt in Einzelbehandlung mit dem Arzt.' },
  { name: 'Physiotherapie & MTT',                link: '/leistungen/physiotherapie',      desc: 'Medizinische Trainingstherapie zur Steigerung der Belastbarkeit des Bewegungsapparates — individuell abgestimmt und von Krankenkassen anerkannt.' },
  { name: 'Galileo Vibrationsplatte',            link: '/leistungen/galileo',             desc: 'Seitenalternierende Vibrationsbewegungen bringen Muskeln über Dehnreflexe zu vermehrten Kontraktionen — für Sport, Rehabilitation und Schmerztherapie.' },
  { name: 'KINESIS Training',                    link: '/leistungen/kinesis',             desc: 'Einzigartiges Ganzkörpertraining durch Seilrollen-Widerstand. Kraft, Flexibilität, Koordination und Haltungskontrolle — alles in einem System.' },
]
</script>

<style scoped>
.service-row:first-child { border-top: 1px solid var(--border); }
</style>