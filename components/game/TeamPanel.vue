<template>
  <aside class="team-panel">
    <div class="panel-head">EQUIPE</div>

    <div class="counter">
      <span class="num">{{ active }}</span>
      <span class="sep">/</span>
      <span class="total">{{ team.length }}</span>
      <span class="key">membros engajados</span>
    </div>

    <ul class="members">
      <li v-for="m in team" :key="m.id" :class="['member', `status-${m.status}`]">
        <div class="avatar">
          <img :src="m.avatar || '/images/avatar.png'" :alt="m.name" />
        </div>
        <div class="info">
          <strong>{{ m.name }}</strong>
          <span v-if="m.task">{{ m.task }}</span>
          <span v-else class="dim">Aguardando escolha</span>
        </div>
        <span :class="['indicator', m.status]"></span>
      </li>
    </ul>
  </aside>
</template>

<script setup>
const props = defineProps({
  team: { type: Array, required: true }
})

const active = computed(() => props.team.filter(m => m.status !== 'idle').length)

function initials(name) {
  if (!name) return '?'
  return name.split(' ').map(n => n[0]).slice(0, 2).join('').toUpperCase()
}
</script>

<style lang="sass" scoped>
.team-panel
  background: var(--game-panel)
  border: 1px solid var(--game-border)
  border-radius: 10px
  padding: 14px 16px
  backdrop-filter: blur(10px)
  font-family: 'Rajdhani', 'Inter', sans-serif
  flex: 1
  display: flex
  flex-direction: column
  min-height: 0

.panel-head
  font-family: 'Orbitron', sans-serif
  color: var(--game-text-dim)
  font-size: 11px
  font-weight: 600
  letter-spacing: 2px
  text-align: center
  margin-bottom: 12px

.counter
  display: flex
  align-items: baseline
  justify-content: center
  gap: 4px
  padding: 10px 0
  border-top: 1px solid var(--game-border)
  border-bottom: 1px solid var(--game-border)
  margin-bottom: 12px
  font-family: 'Orbitron', sans-serif

  .num
    color: var(--game-cyan)
    font-size: 28px
    font-weight: 800
    text-shadow: 0 0 10px var(--game-cyan-glow)

  .sep
    color: var(--game-text-dim)
    font-size: 18px

  .total
    color: var(--game-text)
    font-size: 18px
    font-weight: 700
    margin-right: 8px

  .key
    font-family: 'Rajdhani', 'Inter', sans-serif
    font-size: 11px
    color: var(--game-text-dim)
    letter-spacing: 0.5px

.members
  list-style: none
  margin: 0
  padding: 0
  display: flex
  flex-direction: column
  gap: 8px
  flex: 1
  min-height: 0
  overflow-y: auto
  padding-right: 4px

  &::-webkit-scrollbar
    width: 4px

  &::-webkit-scrollbar-track
    background: transparent

  &::-webkit-scrollbar-thumb
    background: var(--game-border)
    border-radius: 2px

.member
  display: grid
  grid-template-columns: 36px 1fr auto
  align-items: center
  gap: 10px
  padding: 8px
  border-radius: 6px
  background: rgba(0, 0, 0, 0.25)
  border: 1px solid transparent
  transition: all 0.2s

  &.status-done
    border-color: rgba(111, 227, 111, 0.3)

  &.status-claimed
    border-color: rgba(255, 138, 61, 0.3)

  &.status-mine
    border-color: var(--game-gold)
    background: rgba(255, 200, 69, 0.05)

.avatar
  width: 36px
  height: 36px
  border-radius: 50%
  background: linear-gradient(135deg, #1a2540, #0a1428)
  border: 1.5px solid var(--game-border-strong)
  display: flex
  align-items: center
  justify-content: center
  overflow: hidden
  flex-shrink: 0

  img
    width: 100%
    height: 100%
    object-fit: cover

.info
  display: flex
  flex-direction: column
  min-width: 0

  strong
    color: var(--game-text)
    font-size: 12px
    font-weight: 600
    white-space: nowrap
    overflow: hidden
    text-overflow: ellipsis

  span
    color: var(--game-text-dim)
    font-size: 11px
    white-space: nowrap
    overflow: hidden
    text-overflow: ellipsis

    &.dim
      font-style: italic
      opacity: 0.6

.indicator
  width: 8px
  height: 8px
  border-radius: 50%
  background: rgba(255, 255, 255, 0.15)

  &.done
    background: var(--game-green)
    box-shadow: 0 0 8px var(--game-green-glow)

  &.claimed
    background: var(--game-orange)
    box-shadow: 0 0 6px var(--game-orange-glow)

  &.mine
    background: var(--game-gold)
    box-shadow: 0 0 8px rgba(255, 200, 69, 0.5)
</style>
