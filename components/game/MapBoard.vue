<template>
  <div class="map-board">
    <!-- vídeo de fundo com crossfade -->
    <video ref="v1" class="bg-video" :class="{ active: vActive === 1 }" autoplay muted playsinline @timeupdate="onTime(1)">
      <source src="/videos/bg.mp4" type="video/mp4" />
    </video>
    <video ref="v2" class="bg-video" :class="{ active: vActive === 2 }" muted playsinline @timeupdate="onTime(2)">
      <source src="/videos/bg.mp4" type="video/mp4" />
    </video>

    <!-- regiões com labels -->
    <div class="region region-ocean">
      <div class="region-icon ocean">
        <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="#00D4FF" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
          <path d="M2 12c2-2 4-2 6 0s4 2 6 0 4-2 6 0 4 2 6 0"/>
          <path d="M2 6c2-2 4-2 6 0s4 2 6 0 4-2 6 0 4 2 6 0"/>
          <path d="M2 18c2-2 4-2 6 0s4 2 6 0 4-2 6 0 4 2 6 0"/>
        </svg>
      </div>
      <div class="region-text">
        <h3 class="cyan">OCEANO DA INOVAÇÃO</h3>
        <p>Explore novas tecnologias e<br>mergulhe no desconhecido.</p>
      </div>
    </div>

    <div class="region region-lands">
      <div class="region-icon orange">
        <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="#FF8A3D" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
          <path d="m2 20 6-10 4 6 3-4 7 8z"/>
          <circle cx="17" cy="6" r="2"/>
        </svg>
      </div>
      <div class="region-text">
        <h3 class="orange">TERRAS DA CRIAÇÃO</h3>
        <p>Construa, desenvolva e<br>transforme ideias em realidade.</p>
      </div>
    </div>

    <div class="region region-forest">
      <div class="region-icon green">
        <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="#6FE36F" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
          <path d="M11 20A7 7 0 0 1 9.8 6.1C15.5 5 17 4.48 19 2c1 2 2 4.18 2 8 0 5.5-4.78 10-10 10Z"/>
          <path d="M2 21c0-3 1.85-5.36 5.08-6"/>
        </svg>
      </div>
      <div class="region-text">
        <h3 class="green">FLORESTA DA CONEXÃO</h3>
        <p>Conecte pessoas, ideias<br>e cause impacto positivo.</p>
      </div>
    </div>

    <div class="region region-valley">
      <div class="region-icon purple">
        <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="#B86CFF" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="12" cy="12" r="10"/>
          <path d="M12 12c0-2 2-4 4-4s4 2 4 4-2 4-4 4"/>
          <circle cx="12" cy="12" r="2" fill="#B86CFF"/>
        </svg>
      </div>
      <div class="region-text">
        <h3 class="purple">VALE DO CONHECIMENTO</h3>
        <p>Desvende mistérios, expanda<br>sua mente e evolua sempre.</p>
      </div>
    </div>

    <!-- SVG com linhas conectando os nós -->
    <svg class="paths" viewBox="0 0 1000 700" preserveAspectRatio="none">
      <!-- oceano (cyan) -->
      <g stroke="#00D4FF" stroke-width="2" fill="none" filter="url(#glowCyan)">
        <path d="M180,170 L260,150 L340,200 L300,280 L200,290 L180,170" opacity="0.9"/>
      </g>
      <!-- ponte ocean → lands -->
      <path d="M340,200 L490,210" stroke="#FFFFFF" stroke-width="1.5" stroke-dasharray="4 4" opacity="0.4" fill="none"/>

      <!-- terras (orange) -->
      <g stroke="#FF8A3D" stroke-width="2" fill="none" filter="url(#glowOrange)">
        <path d="M540,180 L650,200 L780,180 L820,290 L720,330 L600,300 L540,260 L540,180" opacity="0.9"/>
      </g>

      <!-- floresta (green) -->
      <g stroke="#6FE36F" stroke-width="2" fill="none" filter="url(#glowGreen)">
        <path d="M170,510 L260,490 L350,510 L420,560 L420,610 L300,640 L200,620 L170,510" opacity="0.9"/>
      </g>
      <!-- ponte floresta → vale -->
      <path d="M420,560 L500,540" stroke="#FFFFFF" stroke-width="1.5" stroke-dasharray="4 4" opacity="0.4" fill="none"/>

      <!-- vale (purple) -->
      <g stroke="#B86CFF" stroke-width="2" fill="none" filter="url(#glowPurple)">
        <path d="M550,520 L650,530 L770,520 L830,570 L800,640 L700,650 L600,620 L550,580 L550,520" opacity="0.9"/>
      </g>

      <defs>
        <filter id="glowCyan" x="-50%" y="-50%" width="200%" height="200%">
          <feGaussianBlur stdDeviation="2" result="b"/>
          <feMerge><feMergeNode in="b"/><feMergeNode in="SourceGraphic"/></feMerge>
        </filter>
        <filter id="glowOrange" x="-50%" y="-50%" width="200%" height="200%">
          <feGaussianBlur stdDeviation="2" result="b"/>
          <feMerge><feMergeNode in="b"/><feMergeNode in="SourceGraphic"/></feMerge>
        </filter>
        <filter id="glowGreen" x="-50%" y="-50%" width="200%" height="200%">
          <feGaussianBlur stdDeviation="2" result="b"/>
          <feMerge><feMergeNode in="b"/><feMergeNode in="SourceGraphic"/></feMerge>
        </filter>
        <filter id="glowPurple" x="-50%" y="-50%" width="200%" height="200%">
          <feGaussianBlur stdDeviation="2" result="b"/>
          <feMerge><feMergeNode in="b"/><feMergeNode in="SourceGraphic"/></feMerge>
        </filter>
      </defs>
    </svg>

    <!-- nós -->
    <NuxtLink
      v-for="n in nodes"
      :key="`${n.region}-${n.label}-${n.x}`"
      :to="`/no/${n.label}`"
      :class="['node', n.region]"
      :style="{ left: n.x + '%', top: n.y + '%' }"
    >
      <span>{{ n.label }}</span>
    </NuxtLink>
  </div>
</template>

<script setup>
const nodes = [
  // OCEANO (cyan)
  { region: 'ocean', label: '1-1', x: 24, y: 26 },
  { region: 'ocean', label: '1-3', x: 34, y: 22 },
  { region: 'ocean', label: '1-2', x: 20, y: 39 },
  { region: 'ocean', label: '1-6', x: 36, y: 36 },
  { region: 'ocean', label: '1-3', x: 22, y: 51 },
  { region: 'ocean', label: '1-6', x: 33, y: 50 },

  // TERRAS (orange)
  { region: 'lands', label: '2-1', x: 54, y: 25 },
  { region: 'lands', label: '2-3', x: 65, y: 30 },
  { region: 'lands', label: '2-3', x: 78, y: 27 },
  { region: 'lands', label: '2-3', x: 56, y: 42 },
  { region: 'lands', label: '2-3', x: 68, y: 42 },
  { region: 'lands', label: '2-6', x: 81, y: 41 },
  { region: 'lands', label: '2-6', x: 75, y: 50 },

  // FLORESTA (green)
  { region: 'forest', label: '3-3', x: 35, y: 70 },
  { region: 'forest', label: '3-2', x: 22, y: 76 },
  { region: 'forest', label: '3-3', x: 31, y: 78 },
  { region: 'forest', label: '3-5', x: 41, y: 84 },
  { region: 'forest', label: '3-1', x: 21, y: 87 },
  { region: 'forest', label: '3-3', x: 30, y: 91 },
  { region: 'forest', label: '3-6', x: 40, y: 91 },

  // VALE (purple)
  { region: 'valley', label: '4-2', x: 55, y: 70 },
  { region: 'valley', label: '4-6', x: 73, y: 70 },
  { region: 'valley', label: '4-2', x: 55, y: 80 },
  { region: 'valley', label: '4-6', x: 81, y: 80 },
  { region: 'valley', label: '4-3', x: 62, y: 88 },
  { region: 'valley', label: '4-4', x: 72, y: 91 }
]

/* Video crossfade loop */
const v1 = ref(null)
const v2 = ref(null)
const vActive = ref(1)
const FADE_THRESHOLD = 0.8

function onTime(num) {
  const cur = num === 1 ? v1.value : v2.value
  const other = num === 1 ? v2.value : v1.value
  if (!cur || !other || !cur.duration) return
  if (vActive.value !== num) return
  if (cur.duration - cur.currentTime < FADE_THRESHOLD) {
    other.currentTime = 0
    other.play().catch(() => {})
    vActive.value = num === 1 ? 2 : 1
  }
}
</script>

<style lang="sass" scoped>
.map-board
  position: relative
  display: block
  width: 100%
  height: 100%
  min-width: 0
  min-height: 0
  background: var(--game-bg)
  overflow: hidden

.bg-video
  position: absolute
  inset: 0
  width: 100%
  height: 100%
  object-fit: cover
  z-index: 0
  opacity: 0
  transition: opacity 0.9s ease-in-out
  pointer-events: none

  &.active
    opacity: 1

.region
  position: absolute
  display: flex
  align-items: flex-start
  gap: 12px
  z-index: 2

.region-ocean
  top: 6%
  left: 10%

.region-lands
  top: 6%
  left: 50%

.region-forest
  top: 48%
  left: 10%

.region-valley
  top: 48%
  left: 50%

.region-icon
  width: 52px
  height: 52px
  border-radius: 50%
  display: flex
  align-items: center
  justify-content: center
  background: rgba(8, 18, 40, 0.6)
  backdrop-filter: blur(6px)

  &.ocean
    border: 2px solid var(--game-cyan)
    box-shadow: 0 0 16px var(--game-cyan-glow), inset 0 0 10px rgba(0, 212, 255, 0.2)

  &.orange
    border: 2px solid var(--game-orange)
    box-shadow: 0 0 16px var(--game-orange-glow), inset 0 0 10px rgba(255, 138, 61, 0.2)

  &.green
    border: 2px solid var(--game-green)
    box-shadow: 0 0 16px var(--game-green-glow), inset 0 0 10px rgba(111, 227, 111, 0.2)

  &.purple
    border: 2px solid var(--game-purple)
    box-shadow: 0 0 16px var(--game-purple-glow), inset 0 0 10px rgba(184, 108, 255, 0.2)

.region-text
  font-family: 'Rajdhani', 'Inter', sans-serif

  h3
    margin: 4px 0 4px
    font-family: 'Orbitron', sans-serif
    font-weight: 700
    font-size: 16px
    letter-spacing: 1.5px

    &.cyan
      color: var(--game-cyan)
      text-shadow: 0 0 10px var(--game-cyan-glow)

    &.orange
      color: var(--game-orange)
      text-shadow: 0 0 10px var(--game-orange-glow)

    &.green
      color: var(--game-green)
      text-shadow: 0 0 10px var(--game-green-glow)

    &.purple
      color: var(--game-purple)
      text-shadow: 0 0 10px var(--game-purple-glow)

  p
    margin: 0
    color: var(--game-text-dim)
    font-size: 12px
    line-height: 1.4

.paths
  position: absolute
  inset: 0
  width: 100%
  height: 100%
  z-index: 1
  pointer-events: none

.node
  position: absolute
  transform: translate(-50%, -50%)
  width: 40px
  height: 40px
  border-radius: 50%
  background: rgba(8, 18, 40, 0.85)
  display: flex
  align-items: center
  justify-content: center
  font-family: 'Orbitron', sans-serif
  font-weight: 700
  font-size: 11px
  color: var(--game-text)
  cursor: pointer
  z-index: 3
  transition: transform 0.15s
  text-decoration: none

  &:hover
    transform: translate(-50%, -50%) scale(1.12)

  &.ocean
    border: 2px solid var(--game-cyan)
    box-shadow: 0 0 12px var(--game-cyan-glow), inset 0 0 8px rgba(0, 212, 255, 0.3)
    color: var(--game-cyan)

  &.lands
    border: 2px solid var(--game-orange)
    box-shadow: 0 0 12px var(--game-orange-glow), inset 0 0 8px rgba(255, 138, 61, 0.3)
    color: var(--game-orange)

  &.forest
    border: 2px solid var(--game-green)
    box-shadow: 0 0 12px var(--game-green-glow), inset 0 0 8px rgba(111, 227, 111, 0.3)
    color: var(--game-green)

  &.valley
    border: 2px solid var(--game-purple)
    box-shadow: 0 0 12px var(--game-purple-glow), inset 0 0 8px rgba(184, 108, 255, 0.3)
    color: var(--game-purple)
</style>
