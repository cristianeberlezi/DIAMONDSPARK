<template>
  <div class="login-page">
    <video ref="v1" class="bg-video" :class="{ active: active === 1 }" autoplay muted playsinline @timeupdate="onTime(1)">
      <source src="/videos/bg.mp4" type="video/mp4" />
    </video>
    <video ref="v2" class="bg-video" :class="{ active: active === 2 }" muted playsinline @timeupdate="onTime(2)">
      <source src="/videos/bg.mp4" type="video/mp4" />
    </video>

    <div class="overlay"></div>
    <div class="overlay-grid"></div>

    <div class="content">
      <AuthForm />
    </div>

    <div class="footer">
      <span>© 2026 Diamond Spark</span>
      <span class="dot">•</span>
      <a href="#">Termos</a>
      <span class="dot">•</span>
      <a href="#">Privacidade</a>
    </div>
  </div>
</template>

<script setup>
definePageMeta({
  layout: 'default'
})

useHead({
  title: 'Login — Diamond Spark'
})

const v1 = ref(null)
const v2 = ref(null)
const active = ref(1)
const FADE_THRESHOLD = 0.8 // segundos antes do fim para iniciar o crossfade

function onTime(num) {
  const cur = num === 1 ? v1.value : v2.value
  const other = num === 1 ? v2.value : v1.value
  if (!cur || !other || !cur.duration) return

  // só age se este vídeo for o atualmente visível
  if (active.value !== num) return

  if (cur.duration - cur.currentTime < FADE_THRESHOLD) {
    other.currentTime = 0
    other.play().catch(() => {})
    active.value = num === 1 ? 2 : 1
  }
}
</script>

<style lang="sass" scoped>
.login-page
  position: relative
  width: 100vw
  height: 100vh
  overflow: hidden
  background: var(--game-bg)
  font-family: 'Rajdhani', 'Inter', sans-serif

.bg-video
  position: absolute
  inset: 0
  width: 100%
  height: 100%
  object-fit: cover
  object-position: center
  transform: scale(1.18)
  transform-origin: center
  z-index: 0
  opacity: 0
  transition: opacity 0.9s ease-in-out

  &.active
    opacity: 1

/* sobreposição escura para legibilidade */
.overlay
  position: absolute
  inset: 0
  background: radial-gradient(ellipse at center, rgba(5, 11, 26, 0.55) 0%, rgba(5, 11, 26, 0.85) 80%, rgba(5, 11, 26, 0.95) 100%)
  z-index: 1

/* grade sci-fi sutil */
.overlay-grid
  position: absolute
  inset: 0
  background-image: linear-gradient(rgba(0, 212, 255, 0.04) 1px, transparent 1px), linear-gradient(90deg, rgba(0, 212, 255, 0.04) 1px, transparent 1px)
  background-size: 60px 60px
  z-index: 2
  pointer-events: none
  mask-image: radial-gradient(ellipse at center, black 30%, transparent 80%)

.content
  position: relative
  z-index: 3
  width: 100%
  height: 100%
  display: flex
  align-items: center
  justify-content: center
  padding: 32px

.footer
  position: absolute
  bottom: 20px
  left: 0
  right: 0
  text-align: center
  color: var(--game-text-dim)
  font-size: 12px
  z-index: 3
  display: flex
  align-items: center
  justify-content: center
  gap: 10px

  a
    color: var(--game-text-dim)
    text-decoration: none

    &:hover
      color: var(--game-cyan)

  .dot
    opacity: 0.5
</style>
