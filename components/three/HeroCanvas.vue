<template>
  <canvas ref="canvasEl" class="absolute inset-0 w-full h-full" />
</template>

<script setup lang="ts">
import * as THREE from 'three'

const canvasEl = ref<HTMLCanvasElement | null>(null)

onMounted(() => {
  const canvas = canvasEl.value
  if (!canvas) return

  // ── Renderer ──
  const renderer = new THREE.WebGLRenderer({
    canvas,
    alpha: true,
    antialias: true,
    powerPreference: 'high-performance',
  })
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))
  renderer.toneMapping = THREE.ACESFilmicToneMapping
  renderer.toneMappingExposure = 1.2

  // ── Scene / Camera ──
  const scene = new THREE.Scene()
  const camera = new THREE.PerspectiveCamera(55, 2, 0.1, 300)
  camera.position.set(0, 0, 8)

  function resize() {
    const w = canvas!.clientWidth
    const h = canvas!.clientHeight
    renderer.setSize(w, h, false)
    camera.aspect = w / h
    camera.updateProjectionMatrix()
  }
  resize()
  const ro = new ResizeObserver(resize)
  ro.observe(canvas)

  // ── Particle field ──
  const PARTICLE_COUNT = 2400
  const pPositions = new Float32Array(PARTICLE_COUNT * 3)
  for (let i = 0; i < PARTICLE_COUNT; i++) {
    // Distribute in a hollow sphere shell
    const r = 4 + Math.random() * 16
    const theta = Math.random() * Math.PI * 2
    const phi = Math.acos(2 * Math.random() - 1)
    pPositions[i * 3]     = r * Math.sin(phi) * Math.cos(theta)
    pPositions[i * 3 + 1] = r * Math.sin(phi) * Math.sin(theta)
    pPositions[i * 3 + 2] = r * Math.cos(phi)
  }
  const pGeo = new THREE.BufferGeometry()
  pGeo.setAttribute('position', new THREE.BufferAttribute(pPositions, 3))
  const pMat = new THREE.PointsMaterial({
    color: 0xffffff,
    size: 0.03,
    transparent: true,
    opacity: 0.4,
    sizeAttenuation: true,
    depthWrite: false,
  })
  const particles = new THREE.Points(pGeo, pMat)
  scene.add(particles)

  // ── Core icosahedron ──
  const icoGeo = new THREE.IcosahedronGeometry(2.4, 3)

  // Solid dark shell
  const solidMat = new THREE.MeshStandardMaterial({
    color: 0x0a0a0a,
    metalness: 0.95,
    roughness: 0.15,
    transparent: true,
    opacity: 0.88,
    envMapIntensity: 1,
  })
  const solid = new THREE.Mesh(icoGeo, solidMat)
  solid.position.set(2.8, -0.3, 0)
  scene.add(solid)

  // Wireframe overlay
  const wireMat = new THREE.MeshBasicMaterial({
    color: 0xffffff,
    wireframe: true,
    transparent: true,
    opacity: 0.055,
  })
  const wire = new THREE.Mesh(icoGeo.clone(), wireMat)
  wire.position.copy(solid.position)
  scene.add(wire)

  // Slightly larger outer wireframe — more depth
  const outerWireMat = new THREE.MeshBasicMaterial({
    color: 0xffffff,
    wireframe: true,
    transparent: true,
    opacity: 0.018,
  })
  const outerWire = new THREE.Mesh(new THREE.IcosahedronGeometry(3.2, 2), outerWireMat)
  outerWire.position.copy(solid.position)
  scene.add(outerWire)

  // Inner bright core
  const coreGeo = new THREE.SphereGeometry(0.6, 32, 32)
  const coreMat = new THREE.MeshBasicMaterial({
    color: 0xffffff,
    transparent: true,
    opacity: 0.06,
  })
  const core = new THREE.Mesh(coreGeo, coreMat)
  core.position.copy(solid.position)
  scene.add(core)

  // ── Lights ──
  scene.add(new THREE.AmbientLight(0xffffff, 0.5))

  const keyLight = new THREE.PointLight(0xffffff, 4, 40)
  keyLight.position.set(6, 6, 6)
  scene.add(keyLight)

  const rimLight = new THREE.PointLight(0x8888ff, 2, 25)
  rimLight.position.set(-5, -4, 3)
  scene.add(rimLight)

  const fillLight = new THREE.PointLight(0xffffff, 1, 20)
  fillLight.position.set(0, 8, -4)
  scene.add(fillLight)

  // ── Mouse parallax ──
  let targetX = 0
  let targetY = 0
  let currentX = 0
  let currentY = 0

  function onMouseMove(e: MouseEvent) {
    targetX = (e.clientX / window.innerWidth - 0.5) * 2
    targetY = -(e.clientY / window.innerHeight - 0.5) * 2
  }
  window.addEventListener('mousemove', onMouseMove)

  // ── Animation ──
  let t = 0
  let rafId: number
  function animate() {
    rafId = requestAnimationFrame(animate)
    t += 0.003

    // Smooth mouse follow
    currentX += (targetX - currentX) * 0.04
    currentY += (targetY - currentY) * 0.04

    // Rotate icosahedron
    solid.rotation.x = t * 0.18 + currentY * 0.2
    solid.rotation.y = t * 0.26 + currentX * 0.2
    wire.rotation.copy(solid.rotation)
    outerWire.rotation.x = -t * 0.08
    outerWire.rotation.y =  t * 0.12 + currentX * 0.1

    // Subtle particle drift
    particles.rotation.y = t * 0.04
    particles.rotation.x = t * 0.02

    // Camera parallax
    camera.position.x += (currentX * 0.6 - camera.position.x) * 0.025
    camera.position.y += (currentY * 0.3 - camera.position.y) * 0.025
    camera.lookAt(scene.position)

    // Light orbit
    keyLight.position.x = 6 + Math.sin(t * 0.7) * 3
    keyLight.position.y = 6 + Math.cos(t * 0.5) * 2

    // Core pulse
    const pulse = 0.06 + Math.sin(t * 2.5) * 0.02
    coreMat.opacity = pulse

    renderer.render(scene, camera)
  }
  animate()

  // ── Cleanup ──
  onUnmounted(() => {
    cancelAnimationFrame(rafId)
    ro.disconnect()
    window.removeEventListener('mousemove', onMouseMove)
    renderer.dispose()
    solidMat.dispose()
    wireMat.dispose()
    pMat.dispose()
    icoGeo.dispose()
    pGeo.dispose()
  })
})
</script>
