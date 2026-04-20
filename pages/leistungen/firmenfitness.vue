<template>
  <ServiceLayout>
    <template #title>Firmenfitness</template>
    <template #intro>
      Ihr Beitrag zur Gesundheit Ihrer Mitarbeitenden. Profitieren Sie von einer Firmen-Kooperation mit Medlake und investieren Sie in Ihren Erfolgsfaktor Nr. 1.
    </template>
    <template #body>
      <div class="space-y-10">

        <div>
          <p class="text-[10px] tracking-[0.25em] uppercase mb-6" style="color:var(--text-3)">Vorteile für Ihr Unternehmen</p>
          <div class="space-y-px" style="border-top:1px solid var(--border)">
            <div v-for="b in benefits" :key="b"
              class="flex items-start gap-4 py-4 border-b"
              style="border-color:var(--border)">
              <span class="mt-1 w-1.5 h-1.5 rounded-full flex-shrink-0" style="background:var(--text-3)" />
              <p class="text-[14px] leading-[1.7]" style="color:var(--text-2)">{{ b }}</p>
            </div>
          </div>
        </div>

        <p class="text-[15px] leading-[1.85]" style="color:var(--text-2)">
          Neben der fachlichen Aus- und Weiterbildung der Mitarbeitenden ist ihre körperliche Fitness eine wesentliche Grundlage für Unternehmensqualität und Produktivität. Wir motivieren Ihre Teams zu mehr Bewegung und Gesundheit — mit messbaren Ergebnissen.
        </p>

      </div>
    </template>
  </ServiceLayout>
</template>

<script setup lang="ts">
useHead({ title: 'Firmenfitness – Medlake' })
const benefits = [
  'Höhere Team- und Leistungsfähigkeit der Mitarbeitenden',
  'Stärkt das Selbstvertrauen und die Motivation',
  'Verbessert Ihr Unternehmensimage als attraktiver Arbeitgeber',
  'Förderung von Stressresistenz und mentaler Stärke',
  'Prävention vom Unternehmen aktiv gefördert',
  'Niedrigerer Krankheitsstand durch regelmässiges Fitnesstraining',
]
</script>
