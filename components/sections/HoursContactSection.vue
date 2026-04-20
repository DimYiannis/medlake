<template>
  <section ref="el" class="section-divider">
    <div class="grid grid-cols-1 md:grid-cols-2">

      <!-- Hours -->
      <div class="px-10 py-20 border-r border-ml-border relative overflow-hidden">
        <!-- Big oversize label -->
        <p class="absolute bottom-0 left-0 text-[clamp(55px,9vw,130px)] font-bold leading-none tracking-[-0.04em] text-white/[0.03] uppercase select-none pointer-events-none">
          Öffnungs<br>zeiten
        </p>

        <p class="reveal text-[10px] tracking-[0.28em] uppercase text-white/25 mb-10">Öffnungszeiten</p>

        <div class="relative z-10">
          <div
            v-for="(row, i) in hours"
            :key="row.day"
            class="reveal flex justify-between items-center py-4 border-b border-ml-border"
            :class="`reveal-delay-${i + 1}`"
          >
            <span class="text-[13px] text-white/40 tracking-wide">{{ row.day }}</span>
            <span class="text-[15px] font-medium text-white tracking-wide">{{ row.time }}</span>
          </div>

          <div class="mt-10 reveal reveal-delay-4">
            <a
              href="https://connect.shore.com/bookings/medlake-training/services"
              target="_blank"
              rel="noopener"
              class="inline-flex items-center gap-3 text-[11px] tracking-[0.2em] uppercase bg-white text-ml-black px-7 py-3.5 font-medium hover:bg-white/85 transition-colors"
            >
              Termin buchen
            </a>
          </div>
        </div>
      </div>

      <!-- Contact -->
      <div class="px-10 py-20">
        <p class="reveal text-[10px] tracking-[0.28em] uppercase text-white/25 mb-10">Kontakt</p>

        <div class="space-y-7">
          <div v-for="(item, i) in contactItems" :key="item.key"
            class="reveal flex gap-8"
            :class="`reveal-delay-${i + 1}`"
          >
            <span class="text-[10px] tracking-[0.2em] uppercase text-white/20 w-20 flex-shrink-0 pt-0.5">
              {{ item.key }}
            </span>
            <component
              :is="item.href ? 'a' : 'span'"
              :href="item.href"
              class="text-[14px] text-white/55 leading-relaxed hover:text-white transition-colors"
              :class="item.href ? 'cursor-pointer' : ''"
            >
              {{ item.value }}
            </component>
          </div>
        </div>

        <!-- Inline contact form -->
        <div class="mt-14 reveal reveal-delay-4">
          <p class="text-[10px] tracking-[0.28em] uppercase text-white/20 mb-6">Schreiben Sie uns</p>
          <form @submit.prevent="submitForm" class="space-y-3">
            <input
              v-model="form.name"
              type="text"
              placeholder="Name"
              class="w-full bg-white/[0.04] border border-ml-border text-white text-[13px] px-4 py-3 placeholder-white/20 focus:outline-none focus:border-white/30 transition-colors"
            />
            <input
              v-model="form.email"
              type="email"
              placeholder="E-Mail"
              class="w-full bg-white/[0.04] border border-ml-border text-white text-[13px] px-4 py-3 placeholder-white/20 focus:outline-none focus:border-white/30 transition-colors"
            />
            <input
              v-model="form.subject"
              type="text"
              placeholder="Betreff"
              class="w-full bg-white/[0.04] border border-ml-border text-white text-[13px] px-4 py-3 placeholder-white/20 focus:outline-none focus:border-white/30 transition-colors"
            />
            <textarea
              v-model="form.message"
              placeholder="Ihre Nachricht"
              rows="4"
              class="w-full bg-white/[0.04] border border-ml-border text-white text-[13px] px-4 py-3 placeholder-white/20 focus:outline-none focus:border-white/30 transition-colors resize-none"
            />
            <button
              type="submit"
              :disabled="sending"
              class="w-full text-[11px] tracking-[0.2em] uppercase bg-white text-ml-black py-3.5 font-medium hover:bg-white/85 transition-colors disabled:opacity-40"
            >
              {{ sending ? 'Wird gesendet…' : 'Nachricht senden' }}
            </button>
            <p v-if="sent" class="text-[12px] text-white/40 tracking-wide text-center">
              Vielen Dank — wir melden uns bald.
            </p>
          </form>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
const { el } = useReveal()

const hours = [
  { day: 'Montag – Freitag', time: '06:30 – 21:00' },
  { day: 'Samstag – Sonntag', time: '08:00 – 18:00' },
  { day: 'Feiertage', time: 'Variabel' },
]

const contactItems = [
  { key: 'Adresse', value: 'Seestrasse 39, 8700 Küsnacht', href: null },
  { key: 'Telefon', value: '+41 44 991 22 02', href: 'tel:+41449912202' },
  { key: 'Fax',     value: '+41 44 991 22 03', href: null },
  { key: 'Email',   value: 'info@medlake.ch', href: 'mailto:info@medlake.ch' },
]

const form = reactive({ name: '', email: '', subject: '', message: '' })
const sending = ref(false)
const sent = ref(false)

async function submitForm() {
  sending.value = true
  // Replace with your actual form endpoint or Supabase insert
  await new Promise((r) => setTimeout(r, 1000))
  sending.value = false
  sent.value = true
  Object.assign(form, { name: '', email: '', subject: '', message: '' })
}
</script>
