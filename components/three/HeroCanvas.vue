<template>
  <canvas ref="canvasEl" class="absolute inset-0 w-full h-full" />
</template>

<script setup lang="ts">
import * as THREE from 'three'

const canvasEl = ref<HTMLCanvasElement | null>(null)
const { theme } = useTheme()

const SLIDES = [
  { src: '/images/fitness.jpg' },
  { src: '/images/arzt.jpg' },
  { src: '/images/physiotherapie.jpg' },
]

const emit = defineEmits<{
  slide:    [index: number]
  unlocked: []
  phase:    [phase: 'far' | 'zooming' | 'close']
}>()

onMounted(() => {
  const canvas = canvasEl.value
  if (!canvas) return

  // ── Renderer ──
  const renderer = new THREE.WebGLRenderer({ canvas, alpha: true, antialias: true, powerPreference: 'high-performance' })
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))
  renderer.toneMapping = THREE.ACESFilmicToneMapping
  renderer.toneMappingExposure = 1.08

  const scene = new THREE.Scene()
  const camera = new THREE.PerspectiveCamera(50, 2, 0.1, 300)

  const CAM_FAR   = 28
  const CAM_CLOSE = 6
  camera.position.set(0, 0, CAM_FAR)

  function resize() {
    const w = canvas!.clientWidth, h = canvas!.clientHeight
    renderer.setSize(w, h, false)
    camera.aspect = w / h
    camera.updateProjectionMatrix()
  }
  resize()
  const ro = new ResizeObserver(resize)
  ro.observe(canvas)

  // ── Particles ──
  const N = 1800
  const pPos = new Float32Array(N * 3)
  for (let i = 0; i < N; i++) {
    const r = 5 + Math.random() * 22
    const th = Math.random() * Math.PI * 2
    const ph = Math.acos(2 * Math.random() - 1)
    pPos[i * 3]     = r * Math.sin(ph) * Math.cos(th)
    pPos[i * 3 + 1] = r * Math.sin(ph) * Math.sin(th)
    pPos[i * 3 + 2] = r * Math.cos(ph)
  }
  const pGeo = new THREE.BufferGeometry()
  pGeo.setAttribute('position', new THREE.BufferAttribute(pPos, 3))
  const pMat = new THREE.PointsMaterial({
    color: 0xffffff, size: 0.06, transparent: true,
    opacity: 0.35, sizeAttenuation: true, depthWrite: false,
  })
  const pts = new THREE.Points(pGeo, pMat)
  scene.add(pts)

  // ── Cards ──
  const CARD_W = 8.0
  const CARD_H = 4.2
  const FALLBACK = [0x1a2540, 0x1a3028, 0x301a1a]
  const loader = new THREE.TextureLoader()

  interface Card { mesh: THREE.Mesh; mat: THREE.MeshStandardMaterial; frame: THREE.LineSegments }
  const cards: Card[] = []

  SLIDES.forEach((slide, i) => {
    const geo = new THREE.PlaneGeometry(CARD_W, CARD_H)
    const mat = new THREE.MeshStandardMaterial({
      color: FALLBACK[i], transparent: true,
      opacity: 0.92, side: THREE.FrontSide,
    })
    const mesh = new THREE.Mesh(geo, mat)
    mesh.position.set(i * 0.6 - 0.6, -i * 0.3, -i * 1.2)
    mesh.rotation.y = (i - 1) * 0.08
    scene.add(mesh)

    const edges = new THREE.EdgesGeometry(new THREE.PlaneGeometry(CARD_W, CARD_H))
    const frame = new THREE.LineSegments(
      edges,
      new THREE.LineBasicMaterial({ color: 0xffffff, transparent: true, opacity: 0.12 })
    )
    frame.position.copy(mesh.position)
    frame.position.z += 0.006
    frame.rotation.y = mesh.rotation.y
    scene.add(frame)

    cards.push({ mesh, mat, frame })

    loader.load(slide.src, (tex) => {
      tex.colorSpace = THREE.SRGBColorSpace
      mat.map = tex
      mat.color.set(0xffffff)
      mat.needsUpdate = true
    })
  })

  // ── Lights ──
  scene.add(new THREE.AmbientLight(0xffffff, 0.7))
  const key = new THREE.PointLight(0xffffff, 4, 80)
  key.position.set(4, 6, 10)
  scene.add(key)
  const fill = new THREE.PointLight(0x6688cc, 1.5, 50)
  fill.position.set(-5, -4, 6)
  scene.add(fill)

  // ── State ──
  // phase: 0=far, 1=transitioning, 2=close carousel, 3=unlocked
  let phase        = 0
  let currentSlide = 0
  let animSlide    = 0
  let camZ         = CAM_FAR
  let camZTarget   = CAM_FAR
  let locked       = true
  let cooldown     = 0
  let accumulated  = 0

  emit('phase', 'far')

  // ── Scroll lock helpers ──
  function lockScroll() {
    document.body.style.overflow = 'hidden'
    window.scrollTo(0, 0)
  }

  function unlockScroll() {
    document.body.style.overflow = ''
    locked = false
    phase  = 3
    emit('unlocked')
  }

  // Re-engage when user scrolls back to top of page
  function onPageScroll() {
    if (locked) return
    if (window.scrollY <= 0) {
      // User is back at top — re-lock and go back to last slide
      locked       = true
      phase        = 2
      currentSlide = SLIDES.length - 1
      animSlide    = SLIDES.length - 1
      camZ         = CAM_CLOSE
      camZTarget   = CAM_CLOSE
      lockScroll()
      emit('phase', 'close')
      emit('slide', currentSlide)
    }
  }

  lockScroll()

  // ── Slide navigation ──
  function zoomIn() {
    phase      = 1
    camZTarget = CAM_CLOSE
    cooldown   = 90
    emit('phase', 'zooming')
    setTimeout(() => { phase = 2; emit('phase', 'close') }, 1200)
  }

  function zoomOut() {
    phase      = 1
    camZTarget = CAM_FAR
    cooldown   = 90
    emit('phase', 'zooming')
    setTimeout(() => {
      phase        = 0
      currentSlide = 0
      animSlide    = 0
      emit('phase', 'far')
    }, 1200)
  }

  function advanceSlide(dir: number) {
    if (cooldown > 0) return

    if (phase === 0) {
      if (dir > 0) { zoomIn(); return }
      return
    }

    if (phase === 1) return // mid-transition, ignore

    if (phase === 2) {
      const next = currentSlide + dir

      if (next < 0) {
        // Back past first → zoom out to far
        zoomOut()
        return
      }

      if (next >= SLIDES.length) {
        // Past last → unlock page scroll
        unlockScroll()
        return
      }

      currentSlide = next
      cooldown = 65
      emit('slide', currentSlide)
      return
    }
  }

  // ── Event listeners ──
  function onWheel(e: WheelEvent) {
    if (!locked) return
    e.preventDefault()
    accumulated += e.deltaY
    if (Math.abs(accumulated) < 40) return
    advanceSlide(accumulated > 0 ? 1 : -1)
    accumulated = 0
  }

  let touchY = 0
  const onTouchStart = (e: TouchEvent) => { touchY = e.touches[0].clientY }
  const onTouchEnd   = (e: TouchEvent) => {
    if (!locked) return
    const d = touchY - e.changedTouches[0].clientY
    if (Math.abs(d) < 40) return
    advanceSlide(d > 0 ? 1 : -1)
  }

  const onKey = (e: KeyboardEvent) => {
    if (!locked) return
    if (e.key === 'ArrowDown') { e.preventDefault(); advanceSlide(1) }
    if (e.key === 'ArrowUp')   { e.preventDefault(); advanceSlide(-1) }
  }

  window.addEventListener('wheel',      onWheel,       { passive: false })
  window.addEventListener('touchstart', onTouchStart,  { passive: true })
  window.addEventListener('touchend',   onTouchEnd,    { passive: true })
  window.addEventListener('keydown',    onKey)
  window.addEventListener('scroll',     onPageScroll,  { passive: true })

  // ── Mouse parallax ──
  let tx = 0, ty = 0, cx = 0, cy = 0
  const onMouse = (e: MouseEvent) => {
    tx = (e.clientX / window.innerWidth  - 0.5) * 2
    ty = -(e.clientY / window.innerHeight - 0.5) * 2
  }
  window.addEventListener('mousemove', onMouse)

  // ── Helpers ──
  function lerp(a: number, b: number, f: number) { return a + (b - a) * f }

  function syncFrame(card: Card) {
    card.frame.position.x = card.mesh.position.x
    card.frame.position.y = card.mesh.position.y
    card.frame.position.z = card.mesh.position.z + 0.006
    card.frame.rotation.y = card.mesh.rotation.y
    ;(card.frame.material as THREE.LineBasicMaterial).opacity = card.mat.opacity * 0.12
  }

  function positionCardsFar() {
    cards.forEach((card, i) => {
      card.mesh.position.x = lerp(card.mesh.position.x, i * 0.6 - 0.6, 0.04)
      card.mesh.position.y = lerp(card.mesh.position.y, -i * 0.3 + Math.sin(t * 0.4 + i) * 0.08, 0.04)
      card.mesh.position.z = lerp(card.mesh.position.z, -i * 1.2, 0.04)
      card.mesh.rotation.y = lerp(card.mesh.rotation.y, (i - 1) * 0.08, 0.04)
      card.mat.opacity      = lerp(card.mat.opacity, 0.88 - i * 0.1, 0.04)
      syncFrame(card)
    })
  }

  function positionCardsClose(frac: number) {
    cards.forEach((card, i) => {
      const offset = i - frac
      let tx2: number, tz: number, ry: number, op: number

      if (Math.abs(offset) < 0.015) {
        tx2 = 0; tz = 0; ry = 0; op = 0.95
      } else if (offset > 0) {
        tx2 = 11 + (offset - 1) * 3.5
        tz  = -offset * 1.8
        ry  = -0.18
        op  = Math.max(0, 0.4 - (offset - 1) * 0.35)
      } else {
        tx2 = -11 - (Math.abs(offset) - 1) * 3.5
        tz  = -Math.abs(offset) * 1.8
        ry  = 0.18
        op  = Math.max(0, 0.4 - (Math.abs(offset) - 1) * 0.35)
      }

      card.mesh.position.x = lerp(card.mesh.position.x, tx2, 0.075)
      card.mesh.position.z = lerp(card.mesh.position.z, tz,  0.075)
      card.mesh.rotation.y = lerp(card.mesh.rotation.y, ry,  0.075)
      card.mat.opacity      = lerp(card.mat.opacity,     op,  0.075)
      card.mesh.position.y  = lerp(
        card.mesh.position.y,
        i === currentSlide ? Math.sin(t * 0.65) * 0.04 + cy * 0.05 : 0,
        0.04
      )
      syncFrame(card)
    })
  }

  // ── Animation loop ──
  let t = 0, rafId: number

  function animate() {
    rafId = requestAnimationFrame(animate)
    t += 0.004
    if (cooldown > 0) cooldown--

    cx += (tx - cx) * 0.03
    cy += (ty - cy) * 0.03

    // Camera Z
    camZ = lerp(camZ, camZTarget, phase === 1 ? 0.045 : 0.02)
    camera.position.z = camZ

    if (phase === 0 || (phase === 1 && camZTarget === CAM_FAR)) {
      positionCardsFar()
      camera.position.x = lerp(camera.position.x, cx * 0.4, 0.02)
      camera.position.y = lerp(camera.position.y, cy * 0.3, 0.02)
      scene.rotation.y  = Math.sin(t * 0.15) * 0.06
      scene.rotation.x  = Math.sin(t * 0.10) * 0.03
    } else {
      animSlide = lerp(animSlide, currentSlide, 0.075)
      positionCardsClose(animSlide)
      scene.rotation.y = lerp(scene.rotation.y, 0, 0.05)
      scene.rotation.x = lerp(scene.rotation.x, 0, 0.05)
      camera.position.x = lerp(camera.position.x, cx * 0.2,  0.025)
      camera.position.y = lerp(camera.position.y, cy * 0.14, 0.025)
    }

    camera.lookAt(0, 0, 0)

    pts.rotation.y = t * 0.018
    pts.rotation.x = t * 0.009
    pMat.size = lerp(pMat.size, camZ > 12 ? 0.06 : 0.022, 0.02)

    key.position.x = 4 + Math.sin(t * 0.35) * 1.5
    key.position.y = 6 + Math.cos(t * 0.28) * 1.2

    renderer.render(scene, camera)
  }
  animate()

  onUnmounted(() => {
    cancelAnimationFrame(rafId)
    ro.disconnect()
    document.body.style.overflow = ''
    window.removeEventListener('wheel',      onWheel)
    window.removeEventListener('touchstart', onTouchStart)
    window.removeEventListener('touchend',   onTouchEnd)
    window.removeEventListener('keydown',    onKey)
    window.removeEventListener('scroll',     onPageScroll)
    window.removeEventListener('mousemove',  onMouse)
    renderer.dispose()
  })
})
</script>