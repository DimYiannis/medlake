<template>
  <div class="min-h-screen pt-36 pb-24" style="background:var(--bg)">

    <div class="px-10 mb-16 border-b pb-12" style="border-color:var(--border)">
      <p class="text-[10px] tracking-[0.3em] uppercase mb-4" style="color:var(--text-3)">Medlake</p>
      <h1 class="font-semibold tracking-[-0.025em] leading-none" style="font-size:clamp(40px,6vw,80px);color:var(--text)">
        Kontakt
      </h1>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-2 gap-px px-10" style="background:var(--border)">

      <!-- Contact info -->
      <div class="px-0 py-10 pr-16" style="background:var(--bg)">
        <p class="text-[10px] tracking-[0.25em] uppercase mb-8" style="color:var(--text-3)">Kontaktdaten</p>
        <div class="space-y-7">
          <div v-for="item in contactItems" :key="item.key" class="flex gap-8">
            <span class="text-[10px] tracking-[0.18em] uppercase w-20 flex-shrink-0 pt-0.5" style="color:var(--text-4)">{{ item.key }}</span>
            <component
              :is="item.href ? 'a' : 'span'"
              :href="item.href"
              class="text-[14px] leading-relaxed transition-opacity"
              :class="item.href ? 'hover:opacity-60 cursor-pointer' : ''"
              style="color:var(--text-2)"
            >{{ item.value }}</component>
          </div>
        </div>

        <div class="mt-12 pt-10 border-t" style="border-color:var(--border)">
          <p class="text-[10px] tracking-[0.25em] uppercase mb-6" style="color:var(--text-3)">Öffnungszeiten</p>
          <div class="space-y-3">
            <div v-for="h in hours" :key="h.day" class="flex justify-between py-3 border-b" style="border-color:var(--border)">
              <span class="text-[13px]" style="color:var(--text-3)">{{ h.day }}</span>
              <span class="text-[14px] font-medium" style="color:var(--text)">{{ h.time }}</span>
            </div>
          </div>
          <div class="mt-8">
            <a href="https://connect.shore.com/bookings/medlake-training/services"
              target="_blank" rel="noopener"
              class="inline-flex items-center gap-3 text-[11px] tracking-[0.2em] uppercase px-6 py-3.5 font-medium transition-opacity hover:opacity-80"
              style="background:var(--btn-bg);color:var(--btn-text)">
              Termin buchen
            </a>
          </div>
        </div>
      </div>

      <!-- Contact form -->
      <div class="px-10 py-10" style="background:var(--bg-card)">
        <p class="text-[10px] tracking-[0.25em] uppercase mb-8" style="color:var(--text-3)">Schreiben Sie uns</p>
        <form @submit.prevent="submit" class="space-y-4">
          <div class="grid grid-cols-2 gap-4">
            <div>
              <label class="text-[10px] tracking-[0.18em] uppercase mb-2 block" style="color:var(--text-3)">Name</label>
              <input v-model="form.name" type="text" placeholder="Ihr Name"
                class="w-full text-[13px] px-4 py-3 focus:outline-none transition-colors"
                style="background:var(--bg-input);border:1px solid var(--border);color:var(--text)" />
            </div>
            <div>
              <label class="text-[10px] tracking-[0.18em] uppercase mb-2 block" style="color:var(--text-3)">E-Mail</label>
              <input v-model="form.email" type="email" placeholder="ihre@email.ch"
                class="w-full text-[13px] px-4 py-3 focus:outline-none transition-colors"
                style="background:var(--bg-input);border:1px solid var(--border);color:var(--text)" />
            </div>
          </div>
          <div>
            <label class="text-[10px] tracking-[0.18em] uppercase mb-2 block" style="color:var(--text-3)">Betreff</label>
            <input v-model="form.subject" type="text" placeholder="Betreff"
              class="w-full text-[13px] px-4 py-3 focus:outline-none transition-colors"
              style="background:var(--bg-input);border:1px solid var(--border);color:var(--text)" />
          </div>
          <div>
            <label class="text-[10px] tracking-[0.18em] uppercase mb-2 block" style="color:var(--text-3)">Nachricht</label>
            <textarea v-model="form.message" rows="5" placeholder="Ihre Nachricht..."
              class="w-full text-[13px] px-4 py-3 focus:outline-none transition-colors resize-none"
              style="background:var(--bg-input);border:1px solid var(--border);color:var(--text)" />
          </div>
          <button type="submit" :disabled="sending"
            class="w-full text-[11px] tracking-[0.2em] uppercase py-4 font-medium transition-opacity hover:opacity-80 disabled:opacity-40"
            style="background:var(--btn-bg);color:var(--btn-text)">
            {{ sending ? 'Wird gesendet…' : 'Nachricht senden' }}
          </button>
          <p v-if="sent" class="text-[12px] text-center tracking-wide" style="color:var(--text-3)">
            Vielen Dank — wir melden uns bald bei Ihnen.
          </p>
        </form>
      </div>

    </div>
  </div>
</template>

<script setup lang="ts">
useHead({ title: 'Kontakt – Medlake' })

const settings = await useSiteSettings()

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

const hours = computed(() => settings.value?.opening_hours ?? [])

const form = reactive({ name: '', email: '', subject: '', message: '' })
const sending = ref(false)
const sent = ref(false)

async function submit() {
  sending.value = true
  await new Promise(r => setTimeout(r, 1000))
  sending.value = false
  sent.value = true
  Object.assign(form, { name: '', email: '', subject: '', message: '' })
}
</script>
