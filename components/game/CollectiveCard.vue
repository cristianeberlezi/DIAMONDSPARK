<template>
  <div :class="['collective', `status-${task.status}`]" :style="{ '--c': phaseColor, '--cg': phaseGlow }">
    <span class="corner tl"></span>
    <span class="corner tr"></span>
    <span class="corner bl"></span>
    <span class="corner br"></span>

    <header>
      <div class="badge">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
          <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
          <circle cx="9" cy="7" r="4"/>
          <path d="M23 21v-2a4 4 0 0 0-3-3.87"/>
          <path d="M16 3.13a4 4 0 0 1 0 7.75"/>
        </svg>
        TAREFA COLETIVA DA GUILDA
      </div>
      <div class="est" v-if="task.est">
        <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="12" cy="12" r="10"/>
          <polyline points="12 6 12 12 16 14"/>
        </svg>
        ~{{ task.est }} min
      </div>
    </header>

    <h3>{{ task.title }}</h3>
    <p v-if="task.description" class="desc">{{ task.description }}</p>

    <footer v-if="task.status !== 'locked'">
      <div class="participants">
        <div class="avatars">
          <img v-for="i in Math.min(task.participants || 0, 4)" :key="i" :src="'/images/avatar.png'" alt="avatar" />
          <span v-if="(task.participants || 0) > 4" class="more">+{{ (task.participants || 0) - 4 }}</span>
        </div>
        <span class="count">
          <strong>{{ task.participants || 0 }}</strong> / {{ task.total || 5 }} participando
        </span>
      </div>

      <button class="btn-join" @click="$emit('join', task)">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
          <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/>
          <polyline points="22 4 12 14.01 9 11.01"/>
        </svg>
        <span>PARTICIPAR</span>
      </button>
    </footer>

    <footer v-else class="locked-footer">
      <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <rect x="3" y="11" width="18" height="11" rx="2"/>
        <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
      </svg>
      <span>DISPONÍVEL APÓS DESBLOQUEIO DA FASE</span>
    </footer>
  </div>
</template>

<script setup>
defineProps({
  task: { type: Object, required: true },
  phaseColor: { type: String, default: '#00D4FF' },
  phaseGlow: { type: String, default: 'rgba(0, 212, 255, 0.5)' }
})

defineEmits(['join'])
</script>

<style lang="sass" scoped>
.collective
  position: relative
  padding: 18px 20px
  background: linear-gradient(180deg, rgba(8, 18, 40, 0.7), rgba(8, 18, 40, 0.5))
  border: 1px solid var(--c)
  border-radius: 12px
  backdrop-filter: blur(10px)
  box-shadow: 0 0 18px var(--cg), inset 0 0 14px rgba(255, 255, 255, 0.02)
  font-family: 'Rajdhani', 'Inter', sans-serif

  &.status-locked
    border-color: var(--game-border)
    box-shadow: none
    opacity: 0.55

.corner
  position: absolute
  width: 14px
  height: 14px
  border-color: var(--c)
  border-style: solid
  border-width: 0

.collective.status-locked .corner
  border-color: var(--game-border)

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

header
  display: flex
  align-items: center
  justify-content: space-between
  margin-bottom: 12px

.badge
  display: inline-flex
  align-items: center
  gap: 6px
  font-family: 'Orbitron', sans-serif
  font-size: 10px
  letter-spacing: 1.5px
  color: var(--c)
  text-shadow: 0 0 6px var(--cg)
  font-weight: 700

.collective.status-locked .badge
  color: var(--game-text-dim)
  text-shadow: none

.est
  display: inline-flex
  align-items: center
  gap: 4px
  font-family: 'Orbitron', sans-serif
  font-size: 10px
  color: var(--game-text-dim)
  font-weight: 600

h3
  margin: 0 0 6px
  font-family: 'Orbitron', sans-serif
  font-size: 15px
  font-weight: 700
  color: var(--game-text)
  letter-spacing: 0.5px

.desc
  margin: 0 0 14px
  color: var(--game-text-dim)
  font-size: 13px
  line-height: 1.5

footer
  display: flex
  align-items: center
  justify-content: space-between
  gap: 14px
  padding-top: 12px
  border-top: 1px solid rgba(255, 255, 255, 0.06)

.participants
  display: flex
  align-items: center
  gap: 10px

.avatars
  display: flex

  img
    width: 28px
    height: 28px
    border-radius: 50%
    border: 2px solid var(--game-bg)
    object-fit: cover
    margin-left: -8px

    &:first-child
      margin-left: 0

  .more
    margin-left: -8px
    width: 28px
    height: 28px
    border-radius: 50%
    border: 2px solid var(--game-bg)
    background: rgba(0, 0, 0, 0.6)
    display: flex
    align-items: center
    justify-content: center
    font-size: 10px
    color: var(--game-text-dim)
    font-family: 'Orbitron', sans-serif
    font-weight: 700

.count
  color: var(--game-text-dim)
  font-size: 12px

  strong
    color: var(--c)
    font-family: 'Orbitron', sans-serif
    font-size: 14px

.btn-join
  display: inline-flex
  align-items: center
  gap: 8px
  padding: 10px 18px
  background: rgba(0, 0, 0, 0.4)
  border: 1px solid var(--c)
  border-radius: 8px
  color: var(--c)
  font-family: 'Orbitron', sans-serif
  font-size: 11px
  font-weight: 700
  letter-spacing: 1.5px
  cursor: pointer
  text-shadow: 0 0 6px var(--cg)
  box-shadow: inset 0 0 10px rgba(255, 255, 255, 0.04)
  transition: all 0.2s

  &:hover
    background: rgba(255, 255, 255, 0.06)
    box-shadow: 0 0 14px var(--cg)

.locked-footer
  display: flex
  align-items: center
  justify-content: center
  gap: 8px
  padding: 8px
  background: rgba(0, 0, 0, 0.3)
  border-radius: 6px
  font-family: 'Orbitron', sans-serif
  font-size: 10px
  letter-spacing: 1.5px
  color: var(--game-text-dim)
</style>
