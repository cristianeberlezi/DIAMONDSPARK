<template>
  <header class="node-header">
    <button class="back" @click="back">
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <polyline points="15 18 9 12 15 6"/>
      </svg>
      <span>VOLTAR AO MAPA</span>
    </button>

    <div class="hero">
      <div class="region-icon" :class="region">
        <slot name="icon">
          <svg width="36" height="36" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
            <path d="M2 12c2-2 4-2 6 0s4 2 6 0 4-2 6 0 4 2 6 0"/>
            <path d="M2 6c2-2 4-2 6 0s4 2 6 0 4-2 6 0 4 2 6 0"/>
            <path d="M2 18c2-2 4-2 6 0s4 2 6 0 4-2 6 0 4 2 6 0"/>
          </svg>
        </slot>
      </div>

      <div class="hero-text">
        <div class="title-row">
          <span class="code" :class="region">{{ code }}</span>
          <h1>{{ title }}</h1>
        </div>
        <p class="desc">{{ description }}</p>
      </div>

      <div class="rewards">
        <div class="rew">
          <svg width="22" height="22" viewBox="0 0 24 24" fill="#56C8FF"><path d="M3 12 L12 3 L21 12 L12 21 Z"/></svg>
          <span>{{ reward.xp }} XP</span>
        </div>
        <div class="rew">
          <svg width="22" height="22" viewBox="0 0 24 24">
            <circle cx="12" cy="12" r="10" fill="#FFB300" stroke="#FF8A3D" stroke-width="1.5"/>
          </svg>
          <span>{{ reward.coins }}</span>
        </div>
        <div class="rew">
          <svg width="22" height="22" viewBox="0 0 24 24" fill="#56C8FF"><path d="M6 3h12l4 6-10 12L2 9z"/></svg>
          <span>{{ reward.gems }}</span>
        </div>
      </div>
    </div>

    <div class="progress-block">
      <div class="progress-head">
        <span class="key">PROGRESSO DA EQUIPE</span>
        <span class="val">{{ progress.done }} <small>/ {{ progress.total }}</small></span>
      </div>
      <div class="bar">
        <div class="fill" :class="region" :style="{ width: `${(progress.done / progress.total) * 100}%` }"></div>
      </div>
      <div class="progress-hint">
        Quando todas as tarefas forem concluídas o próximo nó será desbloqueado
      </div>
    </div>
  </header>
</template>

<script setup>
defineProps({
  code: { type: String, required: true },
  title: { type: String, required: true },
  description: { type: String, default: '' },
  region: { type: String, default: 'ocean' },
  reward: { type: Object, default: () => ({ xp: 500, coins: 1000, gems: 10 }) },
  progress: { type: Object, default: () => ({ done: 0, total: 10 }) }
})

const router = useRouter()
function back() {
  router.push('/game')
}
</script>

<style lang="sass" scoped>
.node-header
  background: var(--game-panel)
  border: 1px solid var(--game-border)
  border-radius: 10px
  padding: 16px 20px
  backdrop-filter: blur(10px)
  font-family: 'Rajdhani', 'Inter', sans-serif

.back
  display: inline-flex
  align-items: center
  gap: 8px
  background: transparent
  border: none
  color: var(--game-text-dim)
  font-family: 'Orbitron', sans-serif
  font-size: 11px
  font-weight: 600
  letter-spacing: 1.5px
  cursor: pointer
  padding: 0
  margin-bottom: 14px
  transition: color 0.2s

  &:hover
    color: var(--game-cyan)

.hero
  display: grid
  grid-template-columns: auto 1fr auto
  gap: 18px
  align-items: center

.region-icon
  width: 64px
  height: 64px
  border-radius: 50%
  display: flex
  align-items: center
  justify-content: center
  background: rgba(8, 18, 40, 0.6)
  flex-shrink: 0

  &.ocean
    color: var(--game-cyan)
    border: 2px solid var(--game-cyan)
    box-shadow: 0 0 18px var(--game-cyan-glow), inset 0 0 12px rgba(0, 212, 255, 0.2)

  &.lands
    color: var(--game-orange)
    border: 2px solid var(--game-orange)
    box-shadow: 0 0 18px var(--game-orange-glow), inset 0 0 12px rgba(255, 138, 61, 0.2)

  &.forest
    color: var(--game-green)
    border: 2px solid var(--game-green)
    box-shadow: 0 0 18px var(--game-green-glow), inset 0 0 12px rgba(111, 227, 111, 0.2)

  &.valley
    color: var(--game-purple)
    border: 2px solid var(--game-purple)
    box-shadow: 0 0 18px var(--game-purple-glow), inset 0 0 12px rgba(184, 108, 255, 0.2)

.hero-text
  min-width: 0

.title-row
  display: flex
  align-items: baseline
  gap: 14px
  margin-bottom: 4px

  .code
    font-family: 'Orbitron', sans-serif
    font-weight: 700
    font-size: 26px

    &.ocean
      color: var(--game-cyan)
      text-shadow: 0 0 10px var(--game-cyan-glow)

    &.lands
      color: var(--game-orange)
      text-shadow: 0 0 10px var(--game-orange-glow)

    &.forest
      color: var(--game-green)
      text-shadow: 0 0 10px var(--game-green-glow)

    &.valley
      color: var(--game-purple)
      text-shadow: 0 0 10px var(--game-purple-glow)

  h1
    margin: 0
    font-family: 'Orbitron', sans-serif
    font-weight: 700
    font-size: 22px
    letter-spacing: 1.5px
    color: var(--game-text)

.desc
  margin: 0
  color: var(--game-text-dim)
  font-size: 13px
  line-height: 1.4

.rewards
  display: flex
  gap: 14px

.rew
  display: flex
  align-items: center
  gap: 6px
  padding: 8px 12px
  background: rgba(0, 0, 0, 0.3)
  border: 1px solid var(--game-border)
  border-radius: 8px

  span
    font-family: 'Orbitron', sans-serif
    font-size: 12px
    font-weight: 700
    color: var(--game-text)

/* Progresso */
.progress-block
  margin-top: 16px
  padding-top: 14px
  border-top: 1px solid var(--game-border)

.progress-head
  display: flex
  align-items: baseline
  justify-content: space-between
  margin-bottom: 8px

  .key
    font-family: 'Orbitron', sans-serif
    color: var(--game-text-dim)
    font-size: 11px
    font-weight: 600
    letter-spacing: 2px

  .val
    font-family: 'Orbitron', sans-serif
    color: var(--game-text)
    font-size: 18px
    font-weight: 700

    small
      color: var(--game-text-dim)
      font-size: 13px

.bar
  height: 8px
  background: rgba(255, 255, 255, 0.06)
  border-radius: 4px
  overflow: hidden
  border: 1px solid var(--game-border)

.fill
  height: 100%
  transition: width 0.6s ease

  &.ocean
    background: linear-gradient(90deg, #00D4FF, #56C8FF)
    box-shadow: 0 0 10px var(--game-cyan-glow)

  &.lands
    background: linear-gradient(90deg, #FF8A3D, #FFB36B)
    box-shadow: 0 0 10px var(--game-orange-glow)

  &.forest
    background: linear-gradient(90deg, #6FE36F, #9BF09B)
    box-shadow: 0 0 10px var(--game-green-glow)

  &.valley
    background: linear-gradient(90deg, #B86CFF, #D29BFF)
    box-shadow: 0 0 10px var(--game-purple-glow)

.progress-hint
  margin-top: 8px
  color: var(--game-text-dim)
  font-size: 12px
  font-style: italic
</style>
