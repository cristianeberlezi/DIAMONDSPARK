<template>
  <div :class="['task-card', region, statusClass]">
    <!-- frame corners -->
    <span class="corner tl"></span>
    <span class="corner tr"></span>
    <span class="corner bl"></span>
    <span class="corner br"></span>

    <div class="head">
      <div class="profile-tag">
        <span class="emoji">{{ profileIcons[task.profile]?.emoji || '⚡' }}</span>
        <span class="label">{{ profileIcons[task.profile]?.label || 'Geral' }}</span>
      </div>
      <div class="xp">+{{ task.xp }} XP</div>
    </div>

    <h3>{{ task.title }}</h3>
    <p class="desc">{{ task.description }}</p>

    <div class="footer">
      <!-- estado: aberta -->
      <template v-if="task.status === 'open'">
        <div class="status open">
          <span class="dot"></span>
          DISPONÍVEL
        </div>
        <button class="btn-action" :class="region" @click="$emit('claim')">
          <span>FAZER ESSA</span>
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="9 18 15 12 9 6"/>
          </svg>
        </button>
      </template>

      <!-- estado: minha -->
      <template v-else-if="task.status === 'mine'">
        <div class="status mine">
          <span class="dot"></span>
          VOCÊ PEGOU
        </div>
        <button class="btn-action" :class="region" @click="$emit('submit')">
          <span>ENVIAR ENTREGA</span>
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="9 18 15 12 9 6"/>
          </svg>
        </button>
      </template>

      <!-- estado: em andamento (outro) -->
      <template v-else-if="task.status === 'claimed'">
        <div class="status claimed">
          <span class="dot"></span>
          EM PROGRESSO
        </div>
        <div class="assignee">
          <div class="avatar">
            <img :src="task.assignee.avatar || '/images/avatar.png'" :alt="task.assignee.name" />
          </div>
          <span>{{ task.assignee.name }}</span>
        </div>
      </template>

      <!-- estado: concluída -->
      <template v-else-if="task.status === 'done'">
        <div class="status done">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="20 6 9 17 4 12"/>
          </svg>
          CONCLUÍDA
        </div>
        <div class="assignee">
          <div class="avatar done">
            <img :src="task.assignee.avatar || '/images/avatar.png'" :alt="task.assignee.name" />
          </div>
          <span>{{ task.assignee.name }}</span>
        </div>
      </template>
    </div>
  </div>
</template>

<script setup>
const props = defineProps({
  task: { type: Object, required: true },
  region: { type: String, default: 'ocean' }
})

defineEmits(['claim', 'submit'])

const profileIcons = {
  investigador: { emoji: '🔍', label: 'Investigador' },
  designer: { emoji: '🎨', label: 'Designer' },
  dev: { emoji: '💻', label: 'Dev' },
  lider: { emoji: '🎯', label: 'Líder' },
  comunicador: { emoji: '📢', label: 'Comunicador' },
  estrategista: { emoji: '🧠', label: 'Estrategista' },
  criativo: { emoji: '✨', label: 'Criativo' },
  analista: { emoji: '📊', label: 'Analista' },
  apresentador: { emoji: '🎤', label: 'Apresentador' },
  documentador: { emoji: '📝', label: 'Documentador' }
}

const statusClass = computed(() => `status-${props.task?.status || 'open'}`)

function initials(name) {
  if (!name) return '?'
  return name.split(' ').map(n => n[0]).slice(0, 2).join('').toUpperCase()
}
</script>

<style lang="sass" scoped>
.task-card
  position: relative
  background: var(--game-panel)
  border: 1px solid var(--game-border)
  border-radius: 10px
  padding: 16px
  backdrop-filter: blur(8px)
  font-family: 'Rajdhani', 'Inter', sans-serif
  transition: all 0.25s
  cursor: default

  &.ocean
    border-color: rgba(0, 212, 255, 0.4)

    &:hover
      border-color: var(--game-cyan)
      box-shadow: 0 0 22px rgba(0, 212, 255, 0.18), inset 0 0 12px rgba(0, 212, 255, 0.04)

  &.lands
    border-color: rgba(255, 138, 61, 0.4)

    &:hover
      border-color: var(--game-orange)
      box-shadow: 0 0 22px rgba(255, 138, 61, 0.18), inset 0 0 12px rgba(255, 138, 61, 0.04)

  &.forest
    border-color: rgba(111, 227, 111, 0.4)

    &:hover
      border-color: var(--game-green)
      box-shadow: 0 0 22px rgba(111, 227, 111, 0.18), inset 0 0 12px rgba(111, 227, 111, 0.04)

  &.valley
    border-color: rgba(184, 108, 255, 0.4)

    &:hover
      border-color: var(--game-purple)
      box-shadow: 0 0 22px rgba(184, 108, 255, 0.18), inset 0 0 12px rgba(184, 108, 255, 0.04)

  &.status-done
    opacity: 0.85

  &.status-claimed
    opacity: 0.75

/* corners */
.corner
  position: absolute
  width: 12px
  height: 12px
  border-style: solid
  border-width: 0
  border-color: currentColor
  pointer-events: none

.task-card.ocean .corner
  color: var(--game-cyan)
.task-card.lands .corner
  color: var(--game-orange)
.task-card.forest .corner
  color: var(--game-green)
.task-card.valley .corner
  color: var(--game-purple)

.tl
  top: -1px
  left: -1px
  border-top-width: 2px
  border-left-width: 2px
  border-top-left-radius: 6px
.tr
  top: -1px
  right: -1px
  border-top-width: 2px
  border-right-width: 2px
  border-top-right-radius: 6px
.bl
  bottom: -1px
  left: -1px
  border-bottom-width: 2px
  border-left-width: 2px
  border-bottom-left-radius: 6px
.br
  bottom: -1px
  right: -1px
  border-bottom-width: 2px
  border-right-width: 2px
  border-bottom-right-radius: 6px

/* head */
.head
  display: flex
  align-items: center
  justify-content: space-between
  margin-bottom: 10px

.profile-tag
  display: inline-flex
  align-items: center
  gap: 6px
  padding: 5px 10px
  background: rgba(0, 0, 0, 0.35)
  border: 1px solid var(--game-border)
  border-radius: 6px

  .emoji
    font-size: 13px

  .label
    font-size: 11px
    color: var(--game-text-dim)
    font-weight: 600
    letter-spacing: 0.5px

.xp
  font-family: 'Orbitron', sans-serif
  font-size: 11px
  font-weight: 700
  color: var(--game-gold)
  text-shadow: 0 0 6px rgba(255, 200, 69, 0.4)

h3
  margin: 0 0 6px
  font-family: 'Orbitron', sans-serif
  font-size: 14px
  font-weight: 700
  color: var(--game-text)
  letter-spacing: 0.5px
  line-height: 1.3

.desc
  margin: 0 0 14px
  color: var(--game-text-dim)
  font-size: 12px
  line-height: 1.4

.footer
  display: flex
  align-items: center
  justify-content: space-between
  gap: 10px
  padding-top: 12px
  border-top: 1px solid rgba(255, 255, 255, 0.05)

.status
  display: inline-flex
  align-items: center
  gap: 6px
  font-family: 'Orbitron', sans-serif
  font-size: 10px
  font-weight: 700
  letter-spacing: 1.5px

  .dot
    width: 7px
    height: 7px
    border-radius: 50%

  &.open
    color: var(--game-cyan)
    .dot
      background: var(--game-cyan)
      box-shadow: 0 0 8px var(--game-cyan-glow)
      animation: pulse 1.6s ease infinite

  &.mine
    color: var(--game-gold)
    .dot
      background: var(--game-gold)
      box-shadow: 0 0 8px rgba(255, 200, 69, 0.5)

  &.claimed
    color: var(--game-orange)
    .dot
      background: var(--game-orange)

  &.done
    color: var(--game-green)

@keyframes pulse
  0%, 100%
    opacity: 1
  50%
    opacity: 0.4

.btn-action
  display: inline-flex
  align-items: center
  gap: 8px
  padding: 8px 14px
  background: rgba(0, 0, 0, 0.4)
  border: 1px solid
  border-radius: 6px
  font-family: 'Orbitron', sans-serif
  font-size: 10px
  font-weight: 700
  letter-spacing: 1.5px
  cursor: pointer
  transition: all 0.2s

  &.ocean
    border-color: var(--game-cyan)
    color: var(--game-cyan)
    text-shadow: 0 0 6px var(--game-cyan-glow)

    &:hover
      background: rgba(0, 212, 255, 0.15)
      box-shadow: 0 0 14px rgba(0, 212, 255, 0.4)

  &.lands
    border-color: var(--game-orange)
    color: var(--game-orange)

    &:hover
      background: rgba(255, 138, 61, 0.15)
      box-shadow: 0 0 14px var(--game-orange-glow)

  &.forest
    border-color: var(--game-green)
    color: var(--game-green)

    &:hover
      background: rgba(111, 227, 111, 0.15)
      box-shadow: 0 0 14px var(--game-green-glow)

  &.valley
    border-color: var(--game-purple)
    color: var(--game-purple)

    &:hover
      background: rgba(184, 108, 255, 0.15)
      box-shadow: 0 0 14px var(--game-purple-glow)

.assignee
  display: inline-flex
  align-items: center
  gap: 8px

  .avatar
    width: 28px
    height: 28px
    border-radius: 50%
    background: linear-gradient(135deg, #1a2540, #0a1428)
    border: 1.5px solid var(--game-border-strong)
    overflow: hidden
    flex-shrink: 0

    img
      width: 100%
      height: 100%
      object-fit: cover

    &.done
      border-color: var(--game-green)
      box-shadow: 0 0 8px var(--game-green-glow)

  span
    color: var(--game-text-dim)
    font-size: 12px
</style>
