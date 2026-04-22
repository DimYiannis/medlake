<template>
  <section ref="el" class="section-divider grid grid-cols-1 md:grid-cols-2">

    <!-- Hours -->
    <div class="px-10 py-20 relative overflow-hidden border-b md:border-b-0 md:border-r" style="border-color:var(--border)">
      <p class="absolute bottom-0 left-0 font-bold leading-none tracking-[-0.04em] uppercase select-none pointer-events-none" style="font-size:clamp(55px,9vw,130px);color:var(--bleed)">
        Öffnungs<br>zeiten
      </p>
      <p class="reveal text-[12px] tracking-[0.28em] uppercase mb-10" style="color:var(--text-3)">Öffnungszeiten</p>
      <div class="relative z-10">
        <div v-for="(row, i) in hours" :key="row.day" class="reveal flex justify-between items-center py-4 border-b" :class="`reveal-delay-${i + 1}`" style="border-color:var(--border)">
          <span class="text-[15px] tracking-wide" style="color:var(--text-3)">{{ row.day }}</span>
          <NuxtLink v-if="row.link" :to="row.link"
            class="text-[17px] font-medium tracking-wide transition-opacity hover:opacity-60 underline underline-offset-4 decoration-1 cursor-pointer"
            style="color:var(--text)">{{ row.time }}</NuxtLink>
          <span v-else class="text-[17px] font-medium tracking-wide" style="color:var(--text)">{{ row.time }}</span>
        </div>
        <div class="mt-10 reveal reveal-delay-4">
          <a href="https://connect.shore.com/bookings/medlake-training/services" target="_blank" rel="noopener"
            class="inline-flex items-center text-[13px] tracking-[0.2em] uppercase px-7 py-3.5 font-medium transition-opacity hover:opacity-80"
            style="background:var(--btn-bg);color:var(--btn-text)">
            Jetzt Termin buchen
          </a>
        </div>
      </div>
    </div>

    <!-- Contact -->
    <div class="px-10 py-20">
      <p class="reveal text-[12px] tracking-[0.28em] uppercase mb-10" style="color:var(--text-3)">Kontakt</p>
      <div class="space-y-7 mb-14">
        <div v-for="(item, i) in contactItems" :key="item.key" class="reveal flex gap-8" :class="`reveal-delay-${i + 1}`">
          <span class="text-[12px] tracking-[0.2em] uppercase w-20 flex-shrink-0 pt-0.5" style="color:var(--text-4)">{{ item.key }}</span>
          <component :is="item.href ? 'a' : 'span'" :href="item.href"
            class="text-[16px] leading-relaxed transition-opacity" :class="item.href ? 'hover:opacity-70 cursor-pointer' : ''"
            style="color:var(--text-2)">
            {{ item.value }}
          </component>
        </div>
      </div>

      <!-- Contact form -->
      <div class="reveal reveal-delay-4">
        <p class="text-[12px] tracking-[0.28em] uppercase mb-6" style="color:var(--text-4)">Schreiben Sie uns</p>
        <form @submit.prevent="submitForm" class="space-y-3">
          <input v-model="form.name" type="text" placeholder="Name" class="form-input w-full text-[15px] px-4 py-3 focus:outline-none transition-colors" />
          <input v-model="form.email" type="email" placeholder="E-Mail" class="form-input w-full text-[15px] px-4 py-3 focus:outline-none transition-colors" />
          <input v-model="form.subject" type="text" placeholder="Betreff" class="form-input w-full text-[15px] px-4 py-3 focus:outline-none transition-colors" />
          <textarea v-model="form.message" placeholder="Ihre Nachricht" rows="4" class="form-input w-full text-[15px] px-4 py-3 focus:outline-none transition-colors resize-none" />
          <button type="submit" :disabled="sending"
            class="w-full text-[13px] tracking-[0.2em] uppercase py-3.5 font-medium transition-opacity hover:opacity-80 disabled:opacity-40"
            style="background:var(--btn-bg);color:var(--btn-text)">
            {{ sending ? 'Wird gesendet…' : 'Nachricht senden' }}
          </button>
          <p v-if="sent" class="text-[12px] tracking-wide text-center" style="color:var(--text-3)">Vielen Dank — wir melden uns bald.</p>
        </form>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
const { el } = useReveal()

const settings = await useSiteSettings()

const hours = computed(() => settings.value?.opening_hours ?? [])

const contactItems = computed(() => {
  const c = settings.value?.contact
  if (!c) return []
  return [
    { key: 'Adresse', value: c.address, href: null },
    { key: 'Telefon', value: c.phone,   href: `tel:${c.phone.replace(/\s/g, '')}` },
    { key: 'Fax',     value: c.fax,     href: null },
    { key: 'Email',   value: c.email,   href: `mailto:${c.email}` },
  ]
})

const form = reactive({ name: '', email: '', subject: '', message: '' })
const sending = ref(false)
const sent = ref(false)

async function submitForm() {
  sending.value = true
  await new Promise(r => setTimeout(r, 1000))
  sending.value = false
  sent.value = true
  Object.assign(form, { name: '', email: '', subject: '', message: '' })
}
</script>

<style scoped>
.form-input {
  background: var(--bg-input);
  border: 1px solid var(--border);
  color: var(--text);
}
.form-input::placeholder { color: var(--text-4); }
.form-input:focus { border-color: var(--border-2); }
</style>
