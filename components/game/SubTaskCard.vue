<template>
  <div :class="['subtask', `status-${task.status}`]" :style="{ '--c': phaseColor, '--cg': phaseGlow }">
    <header>
      <span class="profile-tag" v-if="task.profile">
        <span class="emoji">{{ profileIcons[task.profile]?.emoji || '⚡' }}</span>
        <span class="label">{{ profileIcons[task.profile]?.label || 'Geral' }}</span>
      </span>
      <span class="est">
        <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="12" cy="12" r="10"/>
          <polyline points="12 6 12 12 16 14"/>
        </svg>
        ~{{ task.est }} min
      </span>
    </header>

    <h4>{{ task.title }}</h4>

    <footer>
      <template v-if="task.status === 'open'">
        <span class="status open"><i class="dot"></i>DISPONÍVEL</span>
        <button class="btn-claim" @click="$emit('claim', task)">
          <span>FAZER</span>
          <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="9 18 15 12 9 6"/>
          </svg>
        </button>
      </template>

      <template v-else-if="task.status === 'mine'">
        <span class="status mine"><i class="dot"></i>VOCÊ PEGOU</span>
        <button class="btn-submit" @click="$emit('submit', task)">
          <span>ENVIAR</span>
          <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="9 18 15 12 9 6"/>
          </svg>
        </button>
      </template>

      <template v-else-if="task.status === 'claimed'">
        <span class="status claimed"><i class="dot"></i>EM PROGRESSO</span>
        <span class="assignee">
          <img :src="'/images/avatar.png'" :alt="task.assignee" />
          {{ task.assignee }}
        </span>
      </template>

      <template v-else-if="task.status === 'done'">
        <span class="status done">
          <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="20 6 9 17 4 12"/>
          </svg>
          CONCLUÍDA
        </span>
        <span class="assignee">
          <img :src="'/images/avatar.png'" :alt="task.assignee" />
          {{ task.assignee }}
        </span>
      </template>

      <template v-else-if="task.status === 'locked'">
        <span class="status locked">
          <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <rect x="3" y="11" width="18" height="11" rx="2"/>
            <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
          </svg>
          BLOQUEADA
        </span>
      </template>
    </footer>
  </div>
</template>

<script setup>
defineProps({
  task: { type: Object, required: true },
  phaseColor: { type: String, default: '#00D4FF' },
  phaseGlow: { type: String, default: 'rgba(0, 212, 255, 0.5)' }
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
</script>

<style lang="sass" scoped>
.subtask
  display: flex
  flex-direction: column
  padding: 14px
  background: rgba(8, 18, 40, 0.55)
  border: 1px solid var(--game-border)
  border-radius: 10px
  backdrop-filter: blur(6px)
  transition: all 0.2s
  font-family: 'Rajdhani', 'Inter', sans-serif

  &:hover:not(.status-locked)
    border-color: var(--c)
    box-shadow: 0 0 14px var(--cg)
    transform: translateY(-1px)

  &.status-locked
    opacity: 0.4

  &.status-done
    opacity: 0.85

header
  display: flex
  align-items: center
  justify-content: space-between
  margin-bottom: 10px
  gap: 8px

.profile-tag
  display: inline-flex
  align-items: center
  gap: 5px
  padding: 4px 8px
  background: rgba(0, 0, 0, 0.35)
  border: 1px solid var(--game-border)
  border-radius: 5px

  .emoji
    font-size: 11px

  .label
    font-size: 10px
    color: var(--game-text-dim)
    font-weight: 600

.est
  display: inline-flex
  align-items: center
  gap: 4px
  font-family: 'Orbitron', sans-serif
  font-size: 10px
  color: var(--game-text-dim)
  font-weight: 600

h4
  margin: 0 0 12px
  font-size: 13px
  font-weight: 600
  color: var(--game-text)
  line-height: 1.4
  flex: 1

footer
  display: flex
  align-items: center
  justify-content: space-between
  gap: 8px
  padding-top: 10px
  border-top: 1px solid rgba(255, 255, 255, 0.05)

.status
  display: inline-flex
  align-items: center
  gap: 5px
  font-family: 'Orbitron', sans-serif
  font-size: 9px
  font-weight: 700
  letter-spacing: 1px

  .dot
    width: 6px
    height: 6px
    border-radius: 50%

  &.open
    color: var(--c)
    .dot
      background: var(--c)
      box-shadow: 0 0 6px var(--cg)
      animation: pulse 1.6s ease infinite

  &.mine
    color: var(--game-gold)
    .dot
      background: var(--game-gold)
      box-shadow: 0 0 6px rgba(255, 200, 69, 0.5)

  &.claimed
    color: var(--game-orange)
    .dot
      background: var(--game-orange)

  &.done
    color: var(--game-green)

  &.locked
    color: var(--game-text-dim)

@keyframes pulse
  0%, 100%
    opacity: 1
  50%
    opacity: 0.4

.btn-claim, .btn-submit
  display: inline-flex
  align-items: center
  gap: 6px
  padding: 6px 12px
  background: rgba(0, 0, 0, 0.4)
  border: 1px solid var(--c)
  border-radius: 6px
  color: var(--c)
  font-family: 'Orbitron', sans-serif
  font-size: 9px
  font-weight: 700
  letter-spacing: 1.2px
  cursor: pointer
  text-shadow: 0 0 4px var(--cg)
  transition: all 0.2s

  &:hover
    background: rgba(255, 255, 255, 0.06)
    box-shadow: 0 0 10px var(--cg)

.btn-submit
  border-color: var(--game-gold)
  color: var(--game-gold)
  text-shadow: 0 0 4px rgba(255, 200, 69, 0.4)

  &:hover
    box-shadow: 0 0 10px rgba(255, 200, 69, 0.4)

.assignee
  display: inline-flex
  align-items: center
  gap: 6px
  color: var(--game-text-dim)
  font-size: 11px

  img
    width: 20px
    height: 20px
    border-radius: 50%
    border: 1.5px solid var(--game-border)
    object-fit: cover
</style>
