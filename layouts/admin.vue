<template>
  <div>
    <slot />
  </div>
</template>

<script setup lang="ts">
onMounted(() => {
  document.documentElement.removeAttribute('data-theme')
})
</script>
