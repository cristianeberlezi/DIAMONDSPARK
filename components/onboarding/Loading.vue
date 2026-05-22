<template>
  <div class="loading">
    <span class="corner tl"></span>
    <span class="corner tr"></span>
    <span class="corner bl"></span>
    <span class="corner br"></span>

    <!-- Rostos cyclando dentro do orb -->
    <div class="orb-wrap">
      <div class="orb-ring r1" :style="{ borderColor: currentChar.color, boxShadow: `0 0 12px ${currentChar.glow}` }"></div>
      <div class="orb-ring r2" :style="{ borderColor: currentChar.color }"></div>
      <div class="orb-ring r3" :style="{ borderColor: currentChar.color }"></div>

      <div class="face-stage" :style="{ '--c': currentChar.color, '--cg': currentChar.glow }">
        <transition name="face-swap" mode="out-in">
          <div class="face-card" :key="currentChar.letter">
            <img :src="currentChar.image" :alt="currentChar.name" @error="onImgError" />
            <span class="letter">{{ currentChar.letter }}</span>
          </div>
        </transition>
      </div>

      <!-- partículas pulsantes -->
      <div class="particle p1" :style="{ background: currentChar.color }"></div>
      <div class="particle p2" :style="{ background: currentChar.color }"></div>
      <div class="particle p3" :style="{ background: currentChar.color }"></div>
      <div class="particle p4" :style="{ background: currentChar.color }"></div>
    </div>

    <h2>CALCULANDO COMPATIBILIDADE</h2>
    <p class="char-label" :style="{ color: currentChar.color, textShadow: `0 0 10px ${currentChar.glow}` }">
      {{ currentChar.name }} · {{ currentChar.role }}
    </p>

    <ul class="steps">
      <li v-for="(s, i) in steps" :key="s" :class="{ done: i < step, active: i === step }">
        <span class="dot"></span>
        <span class="label">{{ s }}</span>
        <svg v-if="i < step" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#6FE36F" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="20 6 9 17 4 12"/>
        </svg>
        <span v-else-if="i === step" class="spinner"></span>
      </li>
    </ul>

    <div class="progress-line">
      <div class="progress-fill" :style="{ width: `${progress}%` }"></div>
    </div>
  </div>
</template>

<script setup>
import { profiles } from './data.js'

const emit = defineEmits(['done'])

const TOTAL_MS = 8000
const FACE_SWAP_MS = 600

const characterList = Object.values(profiles)
const currentFace = ref(0)
const currentChar = computed(() => characterList[currentFace.value % characterList.length])

const steps = [
  'Coletando respostas',
  'Cruzando perfis Holland',
  'Analisando compatibilidade',
  'Gerando seu personagem'
]
const step = ref(0)
const progress = ref(0)

let faceTimer, stepTimer, progressTimer, doneTimer
const startedAt = Date.now()

onMounted(() => {
  // troca os rostos a cada 600ms
  faceTimer = setInterval(() => {
    currentFace.value++
  }, FACE_SWAP_MS)

  // avança etapas a cada 2s (8s / 4 etapas)
  stepTimer = setInterval(() => {
    if (step.value < steps.length - 1) step.value++
  }, TOTAL_MS / steps.length)

  // progresso linear ao longo dos 8s
  progressTimer = setInterval(() => {
    const elapsed = Date.now() - startedAt
    progress.value = Math.min(100, (elapsed / TOTAL_MS) * 100)
  }, 50)

  // finaliza
  doneTimer = setTimeout(() => {
    clearInterval(faceTimer)
    clearInterval(stepTimer)
    clearInterval(progressTimer)
    emit('done')
  }, TOTAL_MS)
})

onBeforeUnmount(() => {
  clearInterval(faceTimer)
  clearInterval(stepTimer)
  clearInterval(progressTimer)
  clearTimeout(doneTimer)
})

function onImgError(e) {
  if (!e.target.src.endsWith('/images/avatar.png')) {
    e.target.src = '/images/avatar.png'
  }
}
</script>

<style lang="sass" scoped>
.loading
  position: relative
  width: 560px
  max-width: calc(100vw - 32px)
  padding: 44px 48px
  background: rgba(8, 18, 40, 0.7)
  border: 1px solid var(--game-border)
  border-radius: 16px
  backdrop-filter: blur(20px)
  text-align: center
  font-family: 'Rajdhani', 'Inter', sans-serif
  box-shadow: 0 0 40px rgba(0, 212, 255, 0.15)

.corner
  position: absolute
  width: 22px
  height: 22px
  border-color: var(--game-cyan)
  border-style: solid
  border-width: 0
.tl
  top: -1px
  left: -1px
  border-top-width: 2px
  border-left-width: 2px
  border-top-left-radius: 8px
.tr
  top: -1px
  right: -1px
  border-top-width: 2px
  border-right-width: 2px
  border-top-right-radius: 8px
.bl
  bottom: -1px
  left: -1px
  border-bottom-width: 2px
  border-left-width: 2px
  border-bottom-left-radius: 8px
.br
  bottom: -1px
  right: -1px
  border-bottom-width: 2px
  border-right-width: 2px
  border-bottom-right-radius: 8px

/* ===== Orb com rostos ===== */
.orb-wrap
  position: relative
  width: 180px
  height: 180px
  margin: 0 auto 24px

.orb-ring
  position: absolute
  inset: 0
  border-radius: 50%
  border: 2px solid var(--game-cyan)
  opacity: 0.6
  transition: border-color 0.6s ease, box-shadow 0.6s ease
  animation: pulse 2s ease infinite

  &.r2
    inset: 14px
    animation-delay: 0.4s
  &.r3
    inset: 28px
    animation-delay: 0.8s

@keyframes pulse
  0%
    transform: scale(1)
    opacity: 0.7
  50%
    opacity: 0.2
  100%
    transform: scale(1.2)
    opacity: 0

.face-stage
  position: absolute
  inset: 38px
  border-radius: 50%
  overflow: hidden
  border: 3px solid var(--c)
  box-shadow: 0 0 30px var(--cg), inset 0 0 14px rgba(255, 255, 255, 0.08)
  background: linear-gradient(135deg, rgba(8, 18, 40, 0.95), rgba(5, 11, 26, 1))
  transition: border-color 0.4s ease, box-shadow 0.4s ease

.face-card
  position: absolute
  inset: 0
  display: flex
  align-items: center
  justify-content: center

  img
    width: 100%
    height: 100%
    object-fit: cover

  .letter
    position: absolute
    bottom: 4px
    right: 4px
    width: 26px
    height: 26px
    border-radius: 50%
    background: rgba(5, 11, 26, 0.85)
    border: 2px solid var(--c)
    display: flex
    align-items: center
    justify-content: center
    font-family: 'Orbitron', sans-serif
    font-size: 11px
    font-weight: 800
    color: var(--c)
    text-shadow: 0 0 6px var(--cg)
    backdrop-filter: blur(4px)

.face-swap-enter-active
  transition: opacity 0.3s ease, transform 0.3s ease

.face-swap-leave-active
  transition: opacity 0.25s ease, transform 0.25s ease

.face-swap-enter-from
  opacity: 0
  transform: scale(0.8) rotate(8deg)

.face-swap-leave-to
  opacity: 0
  transform: scale(1.15) rotate(-6deg)

.particle
  position: absolute
  width: 6px
  height: 6px
  border-radius: 50%
  box-shadow: 0 0 8px currentColor
  transition: background 0.4s

  &.p1
    top: 10%
    left: 50%
    animation: orbit-1 3s linear infinite

  &.p2
    top: 50%
    right: 10%
    animation: orbit-2 3.6s linear infinite

  &.p3
    bottom: 10%
    left: 50%
    animation: orbit-3 4s linear infinite

  &.p4
    top: 50%
    left: 10%
    animation: orbit-4 3.2s linear infinite

@keyframes orbit-1
  from
    transform: rotate(0deg) translateX(80px) rotate(0deg)
  to
    transform: rotate(360deg) translateX(80px) rotate(-360deg)

@keyframes orbit-2
  from
    transform: rotate(90deg) translateX(80px) rotate(-90deg)
  to
    transform: rotate(450deg) translateX(80px) rotate(-450deg)

@keyframes orbit-3
  from
    transform: rotate(180deg) translateX(80px) rotate(-180deg)
  to
    transform: rotate(540deg) translateX(80px) rotate(-540deg)

@keyframes orbit-4
  from
    transform: rotate(270deg) translateX(80px) rotate(-270deg)
  to
    transform: rotate(630deg) translateX(80px) rotate(-630deg)

/* ===== Textos ===== */
h2
  margin: 0 0 8px
  font-family: 'Orbitron', sans-serif
  font-size: 22px
  font-weight: 700
  letter-spacing: 3px
  color: var(--game-text)
  text-shadow: 0 0 10px var(--game-cyan-glow)

.char-label
  margin: 0 0 28px
  font-family: 'Orbitron', sans-serif
  font-size: 13px
  letter-spacing: 2px
  transition: color 0.6s ease, text-shadow 0.6s ease

.steps
  list-style: none
  margin: 0 0 24px
  padding: 0
  display: flex
  flex-direction: column
  gap: 12px
  text-align: left

  li
    display: grid
    grid-template-columns: 12px 1fr 16px
    align-items: center
    gap: 12px
    padding: 8px 0
    opacity: 0.4
    transition: opacity 0.3s

    &.done
      opacity: 1

    &.active
      opacity: 1

      .dot
        background: var(--game-cyan)
        box-shadow: 0 0 8px var(--game-cyan-glow)

      .label
        color: var(--game-cyan)

    .dot
      width: 8px
      height: 8px
      border-radius: 50%
      background: var(--game-text-dim)

    &.done .dot
      background: var(--game-green)

    .label
      font-size: 14px
      color: var(--game-text)
      font-family: 'Orbitron', sans-serif
      letter-spacing: 1px

.spinner
  width: 14px
  height: 14px
  border: 2px solid rgba(0, 212, 255, 0.3)
  border-top-color: var(--game-cyan)
  border-radius: 50%
  animation: spin 0.8s linear infinite

@keyframes spin
  from
    transform: rotate(0)
  to
    transform: rotate(360deg)

.progress-line
  height: 4px
  background: rgba(255, 255, 255, 0.06)
  border-radius: 2px
  overflow: hidden
  border: 1px solid var(--game-border)

.progress-fill
  height: 100%
  background: linear-gradient(90deg, #00D4FF, #56C8FF)
  box-shadow: 0 0 10px var(--game-cyan-glow)
</style>
