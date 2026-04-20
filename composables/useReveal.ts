/**
 * useReveal — triggers a CSS class when element enters viewport
 * Usage: const { el } = useReveal()
 *        <div ref="el" class="reveal"> ... </div>
 */
export function useReveal(threshold = 0.12) {
  const el = ref<HTMLElement | null>(null)

  onMounted(() => {
    if (!el.value) return
    const observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            entry.target.classList.add('visible')
            observer.unobserve(entry.target)
          }
        })
      },
      { threshold }
    )
    // Observe all children with .reveal class
    el.value.querySelectorAll('.reveal').forEach((child) => observer.observe(child))
    // Also observe the root if it has .reveal
    if (el.value.classList.contains('reveal')) observer.observe(el.value)

    onUnmounted(() => observer.disconnect())
  })

  return { el }
}
