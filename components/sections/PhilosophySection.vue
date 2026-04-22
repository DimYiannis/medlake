<template>
  <section ref="el" class="section-divider px-10 py-28 relative overflow-hidden">

    <span class="quote-mark" aria-hidden="true">&ldquo;</span>

    <div class="max-w-5xl relative">

      <div class="reveal mb-10 flex items-center gap-4">
        <div class="h-px w-12" style="background:var(--text-3)"></div>
        <span class="text-[12px] tracking-[0.3em] uppercase" style="color:rgba(197,160,80,0.6)">Unsere Philosophie</span>
      </div>

      <div class="font-normal leading-[1.4] tracking-[-0.01em]" style="font-size:clamp(22px,3.5vw,50px);color:var(--text-2)">
        <span class="reveal reveal-delay-1 block text-[13px] tracking-[0.25em] uppercase mb-2" style="font-size:11px;color:var(--text-3)">Wer sind wir?</span>
        <span class="reveal reveal-delay-2 block">
          Kompetenzzentrum für <strong class="text-highlight" style="font-weight:500">Gesundheitsorientiertes Kraft- und Ausdauertraining.</strong>
        </span>

        <span class="reveal reveal-delay-3 block text-[13px] tracking-[0.25em] uppercase mt-10 mb-2" style="font-size:11px;color:var(--text-3)">Was unterscheidet uns von anderen Fitnesscentern?</span>
        <span class="reveal reveal-delay-4 block">
          <strong class="text-highlight" style="font-weight:500">Spezialärzte und Physiotherapeutinnen</strong>
          behandeln Rücken-, Nacken- und Gelenkschmerzen —
          Kraftmessungen von Rücken- und Nackenmuskulatur durch unsere
          <strong class="text-highlight" style="font-weight:500">Spezialärzte.</strong>
        </span>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
const { el } = useReveal()
</script>

<style scoped>
.quote-mark {
  position: absolute;
  top: 1rem;
  left: 1.5rem;
  font-size: 22rem;
  line-height: 1;
  color: var(--border);
  font-family: Georgia, 'Times New Roman', serif;
  pointer-events: none;
  user-select: none;
  opacity: 0.6;
}

.text-highlight {
  color: var(--text);
  position: relative;
  display: inline;
}

.text-highlight::after {
  content: '';
  position: absolute;
  bottom: 1px;
  left: 0;
  right: 0;
  height: 1px;
  background: var(--text-3);
  transform: scaleX(0);
  transform-origin: left;
  transition: transform 0.8s var(--ease-out-expo) 0.3s;
}

.reveal.visible .text-highlight::after {
  transform: scaleX(1);
}
</style>
