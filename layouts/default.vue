<template>
  <div>
    <SiteNav />
    <main>
      <slot />
    </main>
    <SiteFooter />
  </div>
</template>

<script setup lang="ts">
const { initTheme } = useTheme()
onMounted(() => initTheme())
</script>
