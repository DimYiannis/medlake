<template>
  <div class="min-h-screen flex items-center justify-center px-6">
    <div class="w-full max-w-sm">
      <p class="text-[12px] tracking-[0.3em] uppercase text-white/20 mb-2 text-center">Medlake</p>
      <h1 class="text-[28px] font-semibold tracking-[-0.02em] text-center mb-10">Admin</h1>

      <form @submit.prevent="login" class="space-y-3">
        <input
          v-model="password"
          type="password"
          placeholder="Passwort"
          autofocus
          class="w-full bg-white/[0.04] border border-ml-border text-white text-[15px] px-4 py-3.5 placeholder-white/20 focus:outline-none focus:border-white/30 transition-colors"
        />
        <p v-if="error" class="text-[13px] text-red-400/70 tracking-wide">Falsches Passwort.</p>
        <button
          type="submit"
          :disabled="loading"
          class="w-full text-[13px] tracking-[0.2em] uppercase bg-white text-ml-black py-3.5 font-medium hover:bg-white/85 transition-colors disabled:opacity-40"
        >
          {{ loading ? '…' : 'Einloggen' }}
        </button>
      </form>
    </div>
  </div>
</template>

<script setup lang="ts">
definePageMeta({ layout: 'admin' })
useHead({ title: 'Admin Login – Medlake' })

const router = useRouter()
const password = ref('')
const error = ref(false)
const loading = ref(false)

async function login() {
  loading.value = true
  error.value = false
  try {
    const res = await $fetch('/api/admin/login', {
      method: 'POST',
      body: { password: password.value },
    })
    if ((res as any).ok) {
      localStorage.setItem('ml_admin', '1')
      router.push('/admin/dashboard')
    } else {
      error.value = true
    }
  } catch {
    error.value = true
  } finally {
    loading.value = false
  }
}
</script>
