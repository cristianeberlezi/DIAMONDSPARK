<template>
  <div :class="['deliverable', { locked }]" :style="{ '--c': phaseColor, '--cg': phaseGlow }">
    <div class="left">
      <div class="checkpoint">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
          <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
          <polyline points="14 2 14 8 20 8"/>
          <path d="m9 15 2 2 4-4"/>
        </svg>
      </div>
    </div>

    <div class="content">
      <span class="key">📦 ENTREGÁVEL DA FASE</span>
      <h3>{{ deliverable.title }}</h3>
      <p>{{ deliverable.description }}</p>
    </div>

    <div class="right">
      <span class="hint">Desbloqueia próxima fase quando completo</span>
    </div>
  </div>
</template>

<script setup>
defineProps({
  deliverable: { type: Object, required: true },
  phaseColor: { type: String, default: '#00D4FF' },
  phaseGlow: { type: String, default: 'rgba(0, 212, 255, 0.5)' },
  locked: { type: Boolean, default: false }
})
</script>

<style lang="sass" scoped>
.deliverable
  display: grid
  grid-template-columns: auto 1fr auto
  align-items: center
  gap: 18px
  padding: 16px 20px
  background: linear-gradient(90deg, rgba(8, 18, 40, 0.7), rgba(8, 18, 40, 0.5))
  border: 1px dashed var(--c)
  border-radius: 12px
  backdrop-filter: blur(10px)
  font-family: 'Rajdhani', 'Inter', sans-serif

  &.locked
    border-color: var(--game-border)
    opacity: 0.6

.checkpoint
  width: 56px
  height: 56px
  border-radius: 12px
  background: rgba(0, 0, 0, 0.4)
  border: 2px solid var(--c)
  display: flex
  align-items: center
  justify-content: center
  color: var(--c)
  box-shadow: 0 0 16px var(--cg), inset 0 0 8px rgba(255, 255, 255, 0.04)

.deliverable.locked .checkpoint
  border-color: var(--game-border)
  color: var(--game-text-dim)
  box-shadow: none

.content
  min-width: 0

.key
  display: block
  font-family: 'Orbitron', sans-serif
  font-size: 10px
  letter-spacing: 2px
  color: var(--c)
  text-shadow: 0 0 6px var(--cg)
  margin-bottom: 4px

.deliverable.locked .key
  color: var(--game-text-dim)
  text-shadow: none

h3
  margin: 0 0 4px
  font-family: 'Orbitron', sans-serif
  font-size: 16px
  font-weight: 700
  color: var(--game-text)

p
  margin: 0
  color: var(--game-text-dim)
  font-size: 13px
  line-height: 1.4

.right
  text-align: right

.hint
  font-size: 11px
  color: var(--game-text-dim)
  font-style: italic
  max-width: 200px
  line-height: 1.3
  display: inline-block

@media screen and (max-width: 900px)
  .deliverable
    grid-template-columns: auto 1fr
    gap: 14px

  .right
    grid-column: 1 / 3
    text-align: left
</style>
