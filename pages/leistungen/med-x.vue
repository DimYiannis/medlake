<template>
  <ServiceLayout>
    <template #title>Ärztliche Trainingstherapie (MED-X)</template>
    <template #intro>
      Computerisierte MedX-Geräte fördern den Muskelaufbau im Nacken- und Lendenbereich mit höchster Präzision — jede Therapieeinheit erfolgt in Einzelbehandlung mit dem Arzt.
    </template>
    <template #body>
      <div class="space-y-10">

        <div class="space-y-5">
          <p class="text-[17px] leading-[1.85]" style="color:var(--text-2)">
            Dank optimaler Fixierung des Patienten können Hilfsmuskeln völlig ausgeschaltet werden, was eine optimale Kräftigung der Zielmuskulatur bewirkt. Die Geräteeinstellung erlaubt ein dosiertes Bewegen im schmerzfreien Bereich.
          </p>
          <p class="text-[17px] leading-[1.85]" style="color:var(--text-2)">
            Mit Gewichten im Pfundbereich, mit dokumentierter Zeit und Bewegungsrepetition kann schonend und kontrolliert trainiert werden. Dies lässt ein Training nach akutem Schmerzschub, nach Gelenksblockierungen oder nach Rückenoperationen zu.
          </p>
        </div>

        <div class="px-7 py-6 border-l-2" style="border-color:var(--text-3);background:var(--bg-card)">
          <p class="text-[15px] tracking-[0.1em] uppercase mb-2" style="color:var(--text-3)">Computergestützte Analyse</p>
          <p class="text-[17px] leading-[1.7]" style="color:var(--text-2)">
            Aufgrund der gemessenen Werte errechnet der Computer die Kraftkurve des Patienten, welche mit alters-, geschlechts- und gewichtsspezifischen Normdaten verglichen wird.
          </p>
        </div>

        <div>
          <p class="text-[12px] tracking-[0.25em] uppercase mb-4" style="color:var(--text-3)">Geeignet für Patienten mit</p>
          <div class="space-y-px" style="border-top:1px solid var(--border)">
            <div v-for="i in indications" :key="i"
              class="flex items-start gap-4 py-4 border-b"
              style="border-color:var(--border)">
              <span class="mt-1 w-1.5 h-1.5 rounded-full flex-shrink-0" style="background:var(--text-3)" />
              <p class="text-[16px] leading-[1.7]" style="color:var(--text-2)">{{ i }}</p>
            </div>
          </div>
        </div>

      </div>
    </template>
  </ServiceLayout>
</template>

<script setup lang="ts">
useHead({ title: 'MED-X Trainingstherapie – Medlake' })
const indications = [
  'Eingeschränkter Beweglichkeit der Wirbelsäule',
  'Zu niedrigem Kraftniveau der Rückenstreckmuskulatur',
  'Chronischen Rücken- und Nackenschmerzen',
  'Zustand nach Rückenoperationen',
  'Zustand nach akutem Schmerzschub',
  'Gelenksblockierungen',
]
</script>
