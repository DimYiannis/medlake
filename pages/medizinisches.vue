<template>
  <div class="min-h-screen pt-36 pb-24" style="background:var(--bg)">

    <div class="px-10 mb-16 border-b pb-12" style="border-color:var(--border)">
      <p class="text-[10px] tracking-[0.3em] uppercase mb-4" style="color:var(--text-3)">Medlake — Wissen</p>
      <h1 class="font-semibold tracking-[-0.025em] leading-none" style="font-size:clamp(40px,6vw,80px);color:var(--text)">
        Medizinisches
      </h1>
      <p class="text-[15px] mt-5 leading-[1.8] max-w-xl" style="color:var(--text-2)">
        Fundiertes Hintergrundwissen über Muskeln, Krafttraining, Schmerzbehandlung und mehr — von unseren Fachärzten zusammengestellt.
      </p>
    </div>

    <!-- Chapter navigation -->
    <div class="px-10 mb-12 flex flex-wrap gap-3">
      <button
        v-for="ch in chapters" :key="ch.id"
        class="text-[10px] tracking-[0.18em] uppercase px-4 py-2 border transition-all"
        :style="activeChapter === ch.id
          ? `background:var(--text);color:var(--bg);border-color:var(--text)`
          : `background:transparent;color:var(--text-3);border-color:var(--border)`"
        @click="activeChapter = ch.id"
      >
        {{ ch.label }}
      </button>
    </div>

    <!-- Content -->
    <div class="px-10 max-w-3xl">

      <!-- Geschichte -->
      <div v-if="activeChapter === 'geschichte'" class="space-y-6">
        <p class="text-[10px] tracking-[0.25em] uppercase mb-6" style="color:var(--text-3)">Geschichte des Krafttrainings</p>
        <div v-for="item in geschichte" :key="item.year" class="flex gap-8 pb-8 border-b" style="border-color:var(--border)">
          <span class="text-[13px] font-medium flex-shrink-0 w-12" style="color:var(--text-3)">{{ item.year }}</span>
          <p class="text-[14px] leading-[1.8]" style="color:var(--text-2)">{{ item.text }}</p>
        </div>
      </div>

      <!-- Kraftzuwachs -->
      <div v-if="activeChapter === 'kraft'" class="space-y-6">
        <p class="text-[10px] tracking-[0.25em] uppercase mb-6" style="color:var(--text-3)">Kraftzuwachs & Trainingsprinzipien</p>
        <p class="text-[15px] leading-[1.85]" style="color:var(--text-2)">
          Der Kraftzuwachs ergibt sich aus Adaptationen von Muskeln und Nerven. Durch repetitives Üben wird die Aktivität der verschiedenen involvierten Nerven optimal synchronisiert. Auf der muskulären Ebene nimmt die Querschnittsfläche der verschiedenen Fasertypen zu.
        </p>
        <p class="text-[15px] leading-[1.85]" style="color:var(--text-2)">
          Die Muskulatur wächst nur am Widerstand. Um Kraft aufzubauen, muss der Widerstand bis zum Erreichen der Maximalkraft kontinuierlich vergrössert werden. Erst mit dem Erreichen der Ermüdungsgrenze wird jener Reiz gesetzt, der den Muskelaufbau auslöst.
        </p>
        <div class="mt-8">
          <p class="text-[10px] tracking-[0.2em] uppercase mb-5" style="color:var(--text-3)">Trainingsprinzipien</p>
          <div class="space-y-px" style="border-top:1px solid var(--border)">
            <div v-for="p in trainingsprinzipien" :key="p" class="flex gap-4 py-4 border-b" style="border-color:var(--border)">
              <span class="mt-1.5 w-1.5 h-1.5 rounded-full flex-shrink-0" style="background:var(--text-3)" />
              <p class="text-[14px] leading-[1.7]" style="color:var(--text-2)">{{ p }}</p>
            </div>
          </div>
        </div>
      </div>

      <!-- Alter -->
      <div v-if="activeChapter === 'alter'" class="space-y-6">
        <p class="text-[10px] tracking-[0.25em] uppercase mb-6" style="color:var(--text-3)">Muskelkraft & Alter</p>
        <p class="text-[15px] leading-[1.85]" style="color:var(--text-2)">
          Die Muskelkraft erreicht mit etwa 25 Jahren den Maximalwert. Wer nicht trainiert, verliert ungefähr 5% an Muskelmasse pro Lebensjahrzehnt — der Fettanteil steigt, das Gewicht bleibt bestenfalls gleich.
        </p>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-px mt-6" style="background:var(--border)">
          <div v-for="stat in alterStats" :key="stat.age" class="px-6 py-8" style="background:var(--bg-card)">
            <p class="text-[11px] tracking-[0.15em] uppercase mb-2" style="color:var(--text-3)">{{ stat.age }}</p>
            <p class="text-[clamp(24px,3vw,36px)] font-semibold tracking-[-0.02em]" style="color:var(--text)">{{ stat.loss }}</p>
            <p class="text-[13px] mt-1" style="color:var(--text-3)">{{ stat.desc }}</p>
          </div>
        </div>
        <p class="text-[15px] leading-[1.85] mt-6" style="color:var(--text-2)">
          Maria Fiatarone bewies 1990 in einer Studie mit 86–96-jährigen Patienten: Nach 10 Wochen Krafttraining stieg die Muskelkraft um 174%. Treppensteigen war wieder ohne Stock möglich. Die Trainierbarkeit der Muskeln bleibt bis ins hohe Alter erhalten.
        </p>
      </div>

      <!-- Rücken -->
      <div v-if="activeChapter === 'ruecken'" class="space-y-8">
        <p class="text-[10px] tracking-[0.25em] uppercase mb-6" style="color:var(--text-3)">Rückenschmerzen</p>
        <div v-for="section in rueckenSections" :key="section.title">
          <p class="text-[11px] tracking-[0.18em] uppercase mb-4" style="color:var(--text-3)">{{ section.title }}</p>
          <div class="space-y-px" style="border-top:1px solid var(--border)">
            <div v-for="item in section.items" :key="item" class="flex gap-4 py-3.5 border-b" style="border-color:var(--border)">
              <span class="mt-1.5 w-1.5 h-1.5 rounded-full flex-shrink-0" style="background:var(--text-4)" />
              <p class="text-[14px] leading-[1.7]" style="color:var(--text-2)">{{ item }}</p>
            </div>
          </div>
        </div>
      </div>

      <!-- Ausdauer -->
      <div v-if="activeChapter === 'ausdauer'" class="space-y-6">
        <p class="text-[10px] tracking-[0.25em] uppercase mb-6" style="color:var(--text-3)">Ausdauertraining</p>
        <p class="text-[15px] leading-[1.85]" style="color:var(--text-2)">
          Definition: Eine Leistung während längerer Zeit vollbringen zu können und danach möglichst bald wieder erholt zu sein. Die Energiebereitstellung entsteht aerob (mit Sauerstoffaufnahme) oder anaerob (durch andere chemische Prozesse).
        </p>
        <div class="px-7 py-6 border-l-2 mt-6" style="border-color:var(--text-3);background:var(--bg-card)">
          <p class="text-[12px] tracking-[0.15em] uppercase mb-3" style="color:var(--text-3)">Optimale Trainingsherzfrequenz</p>
          <p class="text-[15px] leading-[1.7]" style="color:var(--text-2)">
            Faustregel: Puls 220 minus Lebensalter, davon 60–70%. Weitere Methode: 65–70% der maximalen Herzfrequenz.
          </p>
        </div>
        <div class="mt-6">
          <p class="text-[11px] tracking-[0.18em] uppercase mb-4" style="color:var(--text-3)">Effekte des Ausdauertrainings</p>
          <div class="grid grid-cols-2 gap-px" style="background:var(--border)">
            <div v-for="e in ausdauerEffekte" :key="e" class="px-6 py-4" style="background:var(--bg)">
              <p class="text-[13px] leading-[1.6]" style="color:var(--text-2)">{{ e }}</p>
            </div>
          </div>
        </div>
      </div>

    </div>
  </div>
</template>

<script setup lang="ts">
useHead({ title: 'Medizinisches – Medlake' })

const chapters = [
  { id: 'geschichte', label: 'Geschichte' },
  { id: 'kraft',      label: 'Kraftzuwachs' },
  { id: 'alter',      label: 'Muskelkraft & Alter' },
  { id: 'ruecken',    label: 'Rückenschmerzen' },
  { id: 'ausdauer',   label: 'Ausdauer' },
]
const activeChapter = ref('geschichte')

const geschichte = [
  { year: '1850', text: 'Henrik Ling, der Begründer der schwedischen Heilgymnastik, führt mit Patienten gebremste Widerstandsbewegungen durch, um geschwächte Patienten zu kräftigen.' },
  { year: '1885', text: 'Gustaf Zander entwickelt medico-mechanische Apparate als Prototypen der heutigen Trainingsgeräte und gründet 1890 medico-mechanische Institute in ganz Europa.' },
  { year: '1970', text: 'Arthur Jones entwickelt die Nautilus-Kraftgeräte — zuerst von Bodybuildern, später von Sportlern und Patienten genutzt.' },
  { year: '1980', text: 'Arthur Jones führt die MedX-Technologie ein. Computerisierte Geräte ermöglichen reproduzierbare Kraft- und Bewegungsmessungen für wissenschaftliche Studien.' },
]

const trainingsprinzipien = [
  'Trainieren Sie 1–2 Mal pro Woche, jedes Training soll den ganzen Körper umfassen.',
  'Trainieren Sie zuerst die grossen Muskelpartien.',
  'Wählen Sie ein Gewicht, das eine Übungsdauer von 90–120 Sekunden erlaubt.',
  'Führen Sie die Bewegung bis zur Erschöpfung der betroffenen Muskeln durch.',
  'Kann die Trainingszeit überschritten werden, erhöhen Sie beim nächsten Training das Gewicht.',
  'Vermeiden Sie Pressen, Mitschwingen des Körpers und ruckartige Bewegungen.',
  'Trinken Sie vor, während und nach dem Training ausreichend Wasser.',
]

const alterStats = [
  { age: 'Ab 30 Jahre', loss: '~1% / Jahr', desc: 'Beginn des Kraftverlusts ohne spezifisches Training' },
  { age: 'Ab 60 Jahre', loss: '~15% / Jahr', desc: 'Deutlich erhöhter Kraftverlust im 6./7. Lebensjahrzehnt' },
  { age: 'Ab 70 Jahre', loss: '~30% / Jahr', desc: 'Starker Kraftverlust ohne regelmässiges Training' },
]

const rueckenSections = [
  {
    title: 'Ursachen mechanisch bedingter Rückenschmerzen',
    items: ['Fehlbelastung der Wirbelgelenke', 'Muskelverkrampfung', 'Bandscheibenabnützung', 'Nervenkompression', 'Bindegewebeüberdehnung'],
  },
  {
    title: 'Prophylaxe',
    items: ['Übergewicht vermeiden, aufrechte Haltung einnehmen', 'Häufig Positionen wechseln', 'Beim Bücken Hüften und Knie beugen', 'Schwere Gegenstände körpernah heben', 'Lasten auf beide Schultern verteilen', 'Rückengymnastik und Krafttraining durchführen'],
  },
  {
    title: 'Wann zum Arzt?',
    items: ['Bei Schmerzen, die über mehrere Tage zunehmen', 'Wirbelsäulenblockade', 'Schmerzausstrahlung in Arm oder Bein', 'Muskelschwäche'],
  },
]

const ausdauerEffekte = [
  'Ökonomisierung des Herzkreislaufsystems',
  'Tieferer Ruhepuls',
  'Bessere Muskeldurchblutung',
  'Schnellere Regeneration',
  'Erhöhte Stresstoleranz',
  'Optimales Körpergewicht',
]
</script>
