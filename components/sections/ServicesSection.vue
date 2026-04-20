<template>
  <section ref="el" class="section-divider px-10 py-20">
    <p class="reveal text-[10px] tracking-[0.28em] uppercase mb-12" style="color:var(--text-3)">Unser Angebot</p>

    <div>
      <div
        v-for="(service, i) in services"
        :key="service.name"
        class="reveal service-row border-b flex items-stretch cursor-pointer group"
        :class="{ 'active': activeIndex === i }"
        style="border-color:var(--border)"
        @click="toggle(i)"
      >
        <span class="flex-shrink-0 w-16 pt-8 pb-6 text-[11px] tracking-[0.2em] font-medium" style="color:var(--text-4)">
          {{ String(i + 1).padStart(2, '0') }}
        </span>

        <div class="flex-1 py-8 pr-4">
          <h3
            class="font-medium tracking-[-0.01em] transition-opacity duration-300"
            style="font-size:clamp(18px,2.2vw,28px);color:var(--text)"
            :style="activeIndex === i ? 'opacity:0.45' : ''"
          >
            {{ service.name }}
          </h3>
          <Transition name="expand">
            <p v-if="activeIndex === i" class="text-[13px] leading-[1.8] mt-4 max-w-xl" style="color:var(--text-3)">
              {{ service.desc }}
            </p>
          </Transition>
        </div>

        <span
          class="flex-shrink-0 w-12 flex items-start justify-end pt-8 text-2xl transition-all duration-300"
          :style="activeIndex === i ? 'transform:rotate(45deg);color:var(--text-2)' : 'color:var(--text-4)'"
        >+</span>
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
  { name: 'Krafttraining', desc: 'Gesundheitsorientiertes Krafttraining führt zu einem besseren Allgemeinzustand. Mitverantwortlich für akute und chronische Schmerzen des Bewegungsapparates sind schwache Muskeln. Wir trainieren präzise, medizinisch begleitet — mit messbaren Ergebnissen.' },
  { name: 'Herz & Kreislauf', desc: 'Cardio-Training führt zur Ökonomisierung des Herzkreislaufsystems mit verbesserter Muskeldurchblutung. Trainierte Herzen schlagen ruhiger, kraftvoller, ausdauernder — wir zeigen Ihnen den Weg dorthin.' },
  { name: 'Physiotherapie & MTT', desc: 'Medizinische Trainingstherapie zur Steigerung der Belastbarkeit des Bewegungsapparates. Kraft, Ausdauer, Mobilisation und Koordination — individuell abgestimmt, therapeutisch begleitet.' },
  { name: 'Ärztliche Trainingstherapie (MedX)', desc: 'Computerisierte MedX-Geräte fördern den Muskelaufbau im Nacken- und Lendenbereich mit höchster Präzision. Dank optimaler Fixierung des Patienten wird die Muskulatur isoliert und messbar gestärkt.' },
  { name: 'Galileo Vibrationsplatte', desc: 'Seitenalternierende Vibrationsbewegungen bringen Muskeln über Dehnreflexe zu vermehrten Kontraktionen. Die Intensität ist fein dosierbar — für maximale Wirkung bei minimalem Aufwand.' },
  { name: 'Kinesis Training', desc: 'KINESIS — griechisch für Bewegung. Das auf Technogym-Technologie basierende Konzept ermöglicht dreidimensionale, funktionelle Bewegung mit natürlichem Widerstand.' },
  { name: 'Firmenfitness', desc: 'Ihr Beitrag zur Gesundheit Ihrer Mitarbeitenden. Profitieren Sie von unserer Firmen-Kooperation und investieren Sie in die Leistungsfähigkeit und das Wohlbefinden Ihres Teams.' },
]
</script>

<style scoped>
.service-row:first-child { border-top: 1px solid var(--border); }
.expand-enter-active, .expand-leave-active { transition: opacity 0.3s ease, max-height 0.4s ease; overflow: hidden; max-height: 200px; }
.expand-enter-from, .expand-leave-to { opacity: 0; max-height: 0; }
</style>
