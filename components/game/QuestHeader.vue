<template>
  <header class="quest-header">
    <div class="top">
      <div class="title-block">
        <span class="template-pill">{{ quest.template }}</span>
        <h1>{{ quest.title }}</h1>
        <p class="subtitle">{{ quest.subtitle }}</p>
      </div>

      <div class="rewards">
        <div class="rew">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="#56C8FF"><path d="M3 12 L12 3 L21 12 L12 21 Z"/></svg>
          <span>{{ quest.reward.xp }} XP</span>
        </div>
        <div class="rew">
          <svg width="18" height="18" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10" fill="#FFB300" stroke="#FF8A3D" stroke-width="1.5"/></svg>
          <span>{{ quest.reward.coins }}</span>
        </div>
        <div class="rew">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="#56C8FF"><path d="M6 3h12l4 6-10 12L2 9z"/></svg>
          <span>{{ quest.reward.gems }}</span>
        </div>
        <div class="rew days">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="12" cy="12" r="10"/>
            <polyline points="12 6 12 12 16 14"/>
          </svg>
          <span>{{ quest.totalDays }} dias</span>
        </div>
      </div>
    </div>

    <!-- Barra de fases -->
    <div class="phases-bar">
      <div
        v-for="(p, i) in quest.phases"
        :key="p.key"
        :class="['phase', p.status, { current: p.key === quest.currentPhase }]"
        :style="{ '--c': p.color, '--cg': p.glow }"
      >
        <div class="phase-number">
          <svg v-if="p.status === 'done'" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="20 6 9 17 4 12"/>
          </svg>
          <svg v-else-if="p.status === 'locked'" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <rect x="3" y="11" width="18" height="11" rx="2"/>
            <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
          </svg>
          <span v-else>{{ i + 1 }}</span>
        </div>

        <div class="phase-info">
          <span class="phase-title">{{ p.title }}</span>
          <span class="phase-days">
            <template v-if="p.key === quest.currentPhase">DIA {{ quest.currentPhaseDay }} / {{ p.days }}</template>
            <template v-else>{{ p.days }} DIAS</template>
          </span>
        </div>

        <div v-if="p.key === quest.currentPhase" class="phase-progress">
          <div class="phase-fill" :style="{ width: `${(quest.currentPhaseDay / p.days) * 100}%` }"></div>
        </div>

        <div v-if="i < quest.phases.length - 1" class="connector" :class="{ active: p.status === 'done' }"></div>
      </div>
    </div>
  </header>
</template>

<script setup>
defineProps({
  quest: { type: Object, required: true }
})
</script>

<style lang="sass" scoped>
.quest-header
  background: rgba(8, 18, 40, 0.7)
  border: 1px solid var(--game-border)
  border-radius: 12px
  padding: 18px 22px
  backdrop-filter: blur(10px)
  font-family: 'Rajdhani', 'Inter', sans-serif

.top
  display: flex
  align-items: flex-start
  justify-content: space-between
  gap: 20px
  margin-bottom: 18px

.template-pill
  display: inline-block
  padding: 4px 10px
  background: rgba(0, 0, 0, 0.4)
  border: 1px solid var(--game-cyan)
  border-radius: 999px
  font-family: 'Orbitron', sans-serif
  font-size: 9px
  letter-spacing: 1.5px
  color: var(--game-cyan)
  text-shadow: 0 0 6px var(--game-cyan-glow)
  margin-bottom: 8px

h1
  margin: 0
  font-family: 'Orbitron', sans-serif
  font-size: 26px
  font-weight: 800
  letter-spacing: 1px
  color: var(--game-text)
  text-shadow: 0 0 12px var(--game-cyan-glow)

.subtitle
  margin: 6px 0 0
  color: var(--game-text-dim)
  font-size: 14px
  line-height: 1.4

.rewards
  display: flex
  align-items: center
  gap: 8px
  flex-wrap: wrap
  flex-shrink: 0

.rew
  display: flex
  align-items: center
  gap: 6px
  padding: 7px 12px
  background: rgba(0, 0, 0, 0.35)
  border: 1px solid var(--game-border)
  border-radius: 8px

  span
    font-family: 'Orbitron', sans-serif
    font-size: 12px
    font-weight: 700
    color: var(--game-text)

  &.days
    color: var(--game-text-dim)

/* ===== Phases bar ===== */
.phases-bar
  display: grid
  grid-template-columns: repeat(4, 1fr)
  gap: 12px

.phase
  position: relative
  display: grid
  grid-template-columns: 38px 1fr
  align-items: center
  gap: 12px
  padding: 12px 14px
  background: rgba(0, 0, 0, 0.3)
  border: 1px solid var(--game-border)
  border-radius: 10px
  transition: all 0.3s

  &.current
    background: rgba(0, 0, 0, 0.4)
    border-color: var(--c)
    box-shadow: 0 0 16px var(--cg), inset 0 0 10px rgba(255, 255, 255, 0.03)

  &.done
    border-color: var(--c)
    opacity: 0.85

  &.locked
    opacity: 0.45

.phase-number
  width: 38px
  height: 38px
  border-radius: 50%
  background: rgba(0, 0, 0, 0.4)
  border: 2px solid var(--game-border)
  display: flex
  align-items: center
  justify-content: center
  font-family: 'Orbitron', sans-serif
  font-size: 14px
  font-weight: 800
  color: var(--game-text-dim)
  flex-shrink: 0

.phase.current .phase-number
  border-color: var(--c)
  color: var(--c)
  text-shadow: 0 0 8px var(--cg)
  box-shadow: 0 0 12px var(--cg)

.phase.done .phase-number
  background: var(--c)
  border-color: var(--c)
  color: #001a33

.phase.locked .phase-number
  color: var(--game-text-dim)

.phase-info
  display: flex
  flex-direction: column
  gap: 2px
  min-width: 0

.phase-title
  font-family: 'Orbitron', sans-serif
  font-size: 13px
  font-weight: 700
  letter-spacing: 1.5px
  color: var(--game-text)

.phase.current .phase-title
  color: var(--c)
  text-shadow: 0 0 6px var(--cg)

.phase.locked .phase-title
  color: var(--game-text-dim)

.phase-days
  font-family: 'Orbitron', sans-serif
  font-size: 10px
  color: var(--game-text-dim)
  letter-spacing: 1px

.phase.current .phase-days
  color: var(--c)
  opacity: 0.9

.phase-progress
  grid-column: 1 / 3
  margin-top: 8px
  height: 4px
  background: rgba(255, 255, 255, 0.06)
  border-radius: 2px
  overflow: hidden

.phase-fill
  height: 100%
  background: linear-gradient(90deg, var(--c), color-mix(in srgb, var(--c) 60%, white))
  box-shadow: 0 0 8px var(--cg)

.connector
  position: absolute
  top: 50%
  right: -12px
  transform: translateY(-50%)
  width: 12px
  height: 2px
  background: var(--game-border)
  z-index: 1

  &.active
    background: var(--c)
    box-shadow: 0 0 6px var(--cg)

@media screen and (max-width: 1100px)
  .phases-bar
    grid-template-columns: 1fr
    gap: 8px

  .connector
    display: none
</style>
