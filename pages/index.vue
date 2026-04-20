<template>
  <div>
    <SectionsHeroSection />
    <UiMarqueeTicker />
    <SectionsStatsSection />
    <SectionsPhilosophySection />
    <SectionsServicesSection />
    <SectionsTeamSection />
    <SectionsGallerySection />
    <SectionsNewsSection />
    <SectionsHoursContactSection />
  </div>
</template>

<script setup lang="ts">
onMounted(() => {
  const target = sessionStorage.getItem('scrollTo')
  if (!target) return
  sessionStorage.removeItem('scrollTo')

  // Poll until body overflow is unlocked (carousel finished)
  // then scroll to the target section
  let attempts = 0
  const interval = setInterval(() => {
    attempts++
    const bodyUnlocked = document.body.style.overflow !== 'hidden'
    const el = document.getElementById(target)

    if (bodyUnlocked && el) {
      clearInterval(interval)
      setTimeout(() => {
        el.scrollIntoView({ behavior: 'smooth', block: 'start' })
      }, 80)
    }

    // Give up after 10 seconds
    if (attempts > 100) clearInterval(interval)
  }, 100)
})
</script>