<template>
  <section ref="el" class="section-divider px-10 py-20">
    <p class="reveal text-[10px] tracking-[0.28em] uppercase text-white/25 mb-12">Unser Angebot</p>

    <div>
      <div
        v-for="(service, i) in services"
        :key="service.name"
        class="reveal service-row border-b border-ml-border flex items-stretch cursor-pointer group"
        :class="{ 'active': activeIndex === i }"
        @click="toggle(i)"
      >
        <!-- Number -->
        <span class="flex-shrink-0 w-16 pt-8 pb-6 text-[11px] tracking-[0.2em] text-white/15 font-medium">
          {{ String(i + 1).padStart(2, '0') }}
        </span>

        <!-- Body -->
        <div class="flex-1 py-8 pr-4">
          <h3
            class="text-[clamp(18px,2.2vw,28px)] font-medium tracking-[-0.01em] text-white transition-opacity duration-300"
            :class="activeIndex === i ? 'opacity-50' : 'group-hover:opacity-75'"
          >
            {{ service.name }}
          </h3>
          <Transition name="expand">
            <p
              v-if="activeIndex === i"
              class="text-[13px] text-white/40 leading-[1.8] mt-4 max-w-xl"
            >
              {{ service.desc }}
            </p>
          </Transition>
        </div>

        <!-- Arrow -->
        <span
          class="flex-shrink-0 w-12 flex items-start justify-end pt-8 text-white/20 text-2xl transition-all duration-300"
          :class="activeIndex === i ? 'rotate-45 text-white/60' : 'group-hover:text-white/40'"
        >
          +
        </span>
      </div>
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
  {
    name: 'Krafttraining',
    desc: 'Gesundheitsorientiertes Krafttraining führt zu einem besseren Allgemeinzustand. Mitverantwortlich für akute und chronische Schmerzen des Bewegungsapparates sind schwache Muskeln. Wir trainieren präzise, medizinisch begleitet — mit messbaren Ergebnissen.',
  },
  {
    name: 'Herz & Kreislauf',
    desc: 'Cardio-Training führt zur Ökonomisierung des Herzkreislaufsystems mit verbesserter Muskeldurchblutung. Trainierte Herzen schlagen ruhiger, kraftvoller, ausdauernder — wir zeigen Ihnen den Weg dorthin.',
  },
  {
    name: 'Physiotherapie & MTT',
    desc: 'Medizinische Trainingstherapie zur Steigerung der Belastbarkeit des Bewegungsapparates. Kraft, Ausdauer, Mobilisation und Koordination — individuell abgestimmt, therapeutisch begleitet.',
  },
  {
    name: 'Ärztliche Trainingstherapie (MedX)',
    desc: 'Computerisierte MedX-Geräte fördern den Muskelaufbau im Nacken- und Lendenbereich mit höchster Präzision. Dank optimaler Fixierung des Patienten wird die Muskulatur isoliert und messbar gestärkt.',
  },
  {
    name: 'Galileo Vibrationsplatte',
    desc: 'Seitenalternierende Vibrationsbewegungen bringen Muskeln über Dehnreflexe zu vermehrten Kontraktionen. Die Intensität ist fein dosierbar — für maximale Wirkung bei minimalem Aufwand.',
  },
  {
    name: 'Kinesis Training',
    desc: 'KINESIS — griechisch für Bewegung. Das auf Technogym-Technologie basierende Konzept ermöglicht dreidimensionale, funktionelle Bewegung mit natürlichem Widerstand.',
  },
  {
    name: 'Firmenfitness',
    desc: 'Ihr Beitrag zur Gesundheit Ihrer Mitarbeitenden. Profitieren Sie von unserer Firmen-Kooperation und investieren Sie in die Leistungsfähigkeit Ihres Teams.',
  },
]
</script>

<style scoped>
.service-row:first-child {
  border-top: 1px solid rgba(255,255,255,0.07);
}
.expand-enter-active,
.expand-leave-active {
  transition: opacity 0.3s ease, max-height 0.4s ease;
  overflow: hidden;
  max-height: 200px;
}
.expand-enter-from,
.expand-leave-to {
  opacity: 0;
  max-height: 0;
}
</style>
