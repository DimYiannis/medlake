<template>
  <button
    @click="toggleTheme"
    class="w-9 h-9 flex items-center justify-center transition-opacity hover:opacity-60"
    :aria-label="theme === 'dark' ? 'Light mode' : 'Dark mode'"
  >
    <!-- Sun: show in dark mode -->
    <svg v-if="theme === 'dark'" width="16" height="16" viewBox="0 0 24 24" fill="none"
      stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"
      style="color: rgba(255,255,255,0.5)">
      <circle cx="12" cy="12" r="4"/>
      <path d="M12 2v2M12 20v2M4.93 4.93l1.41 1.41M17.66 17.66l1.41 1.41M2 12h2M20 12h2M6.34 17.66l-1.41 1.41M19.07 4.93l-1.41 1.41"/>
    </svg>
    <!-- Moon: show in light mode -->
    <svg v-else width="16" height="16" viewBox="0 0 24 24" fill="none"
      stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"
      style="color: rgba(0,0,0,0.45)">
      <path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"/>
    </svg>
  </button>
</template>

<script setup lang="ts">
const { theme, toggleTheme } = useTheme()
</script>
