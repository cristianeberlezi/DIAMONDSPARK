<template>
  <div :class="['stat-card', accent]">
    <span class="corner tl"></span>
    <span class="corner br"></span>

    <header>
      <div class="icon" v-html="icon"></div>
      <span v-if="trend" :class="['trend', trend > 0 ? 'up' : 'down']">
        <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
          <polyline v-if="trend > 0" points="18 15 12 9 6 15"/>
          <polyline v-else points="6 9 12 15 18 9"/>
        </svg>
        {{ Math.abs(trend) }}%
      </span>
    </header>

    <div class="value">
      <strong>{{ value }}</strong>
      <span v-if="suffix" class="suffix">{{ suffix }}</span>
    </div>

    <div class="label">{{ label }}</div>
    <div v-if="sub" class="sub">{{ sub }}</div>
  </div>
</template>

<script setup>
defineProps({
  label: { type: String, required: true },
  value: { type: [String, Number], required: true },
  suffix: { type: String, default: '' },
  icon: { type: String, default: '' },
  accent: { type: String, default: 'cyan' }, // cyan | orange | green | purple | gold
  trend: { type: Number, default: 0 },
  sub: { type: String, default: '' }
})
</script>

<style lang="sass" scoped>
.stat-card
  position: relative
  padding: 18px 20px
  background: rgba(8, 18, 40, 0.55)
  border: 1px solid var(--game-border)
  border-radius: 12px
  backdrop-filter: blur(8px)
  font-family: 'Rajdhani', 'Inter', sans-serif
  transition: all 0.2s

  &.cyan
    --c: var(--game-cyan)
    --cg: var(--game-cyan-glow)
  &.orange
    --c: var(--game-orange)
    --cg: var(--game-orange-glow)
  &.green
    --c: var(--game-green)
    --cg: var(--game-green-glow)
  &.purple
    --c: var(--game-purple)
    --cg: var(--game-purple-glow)
  &.gold
    --c: var(--game-gold)
    --cg: rgba(255, 200, 69, 0.5)

  &:hover
    border-color: var(--c)
    box-shadow: 0 0 14px var(--cg)

.corner
  position: absolute
  width: 14px
  height: 14px
  border-color: var(--c)
  border-style: solid
  border-width: 0

.tl
  top: -1px
  left: -1px
  border-top-width: 2px
  border-left-width: 2px
  border-top-left-radius: 8px

.br
  bottom: -1px
  right: -1px
  border-bottom-width: 2px
  border-right-width: 2px
  border-bottom-right-radius: 8px

header
  display: flex
  align-items: center
  justify-content: space-between
  margin-bottom: 16px

.icon
  width: 36px
  height: 36px
  border-radius: 8px
  background: rgba(0, 0, 0, 0.4)
  border: 1px solid var(--c)
  display: flex
  align-items: center
  justify-content: center
  color: var(--c)
  box-shadow: 0 0 10px var(--cg), inset 0 0 6px rgba(255, 255, 255, 0.04)

.trend
  display: inline-flex
  align-items: center
  gap: 3px
  padding: 3px 8px
  border-radius: 999px
  font-family: 'Orbitron', sans-serif
  font-size: 10px
  font-weight: 700

  &.up
    background: rgba(111, 227, 111, 0.12)
    color: var(--game-green)

  &.down
    background: rgba(233, 75, 140, 0.12)
    color: #E94B8C

.value
  display: flex
  align-items: baseline
  gap: 6px
  margin-bottom: 4px

  strong
    font-family: 'Orbitron', sans-serif
    font-size: 32px
    font-weight: 800
    color: var(--game-text)
    text-shadow: 0 0 12px var(--cg)
    line-height: 1

  .suffix
    color: var(--game-text-dim)
    font-size: 14px

.label
  font-family: 'Orbitron', sans-serif
  font-size: 11px
  letter-spacing: 1.5px
  color: var(--game-text-dim)
  font-weight: 600
  text-transform: uppercase

.sub
  margin-top: 8px
  font-size: 11px
  color: var(--game-text-dim)
</style>
