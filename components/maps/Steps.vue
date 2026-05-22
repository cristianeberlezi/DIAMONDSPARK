<template>
  <div class="steps-wrap">
    <div class="masquer">
      Masquer
      <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <polyline points="6 9 12 15 18 9"/>
      </svg>
    </div>

    <div class="next-step">
      <span class="label">Your Next Step</span>
      <strong>{{ current }} of {{ steps.length }}</strong>
    </div>

    <div class="track">
      <div v-for="step in steps" :key="step.n" class="step" :class="{ active: step.n === current, locked: step.locked }">
        <span class="icon">{{ step.locked ? '🔒' : step.emoji }}</span>
        <span class="num">{{ step.n }}</span>
      </div>
    </div>

    <div class="arrow">
      <svg width="60" height="22" viewBox="0 0 60 22" fill="none">
        <path d="M2 18 Q 20 4, 50 14" stroke="#D85FA8" stroke-width="2" fill="none" stroke-linecap="round"/>
        <path d="M44 10 L50 14 L46 18" stroke="#D85FA8" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"/>
      </svg>
    </div>

    <button class="continue">
      <span>Continue</span>
    </button>
  </div>
</template>

<script setup>
const current = 6

const steps = [
  { n: 1, emoji: '🐱', locked: false },
  { n: 2, emoji: '🐶', locked: false },
  { n: 3, emoji: '🐨', locked: false },
  { n: 4, emoji: '🦊', locked: false },
  { n: 5, emoji: '🐰', locked: false },
  { n: 6, emoji: '🔒', locked: true },
  { n: 7, emoji: '🔒', locked: true },
  { n: 8, emoji: '🔒', locked: true }
]
</script>

<style lang="sass" scoped>
.steps-wrap
  display: flex
  flex-direction: column
  align-items: flex-end
  gap: 8px
  position: relative

.masquer
  display: flex
  align-items: center
  gap: 6px
  color: var(--cor-cinza-escuro)
  font-size: 14px
  cursor: pointer
  margin-bottom: 12px

.next-step
  display: flex
  align-items: center
  gap: 8px
  font-size: 18px
  align-self: flex-start

  .label
    color: var(--cor-cinza-escuro)
    font-weight: 500

  strong
    color: var(--cor-preto)
    font-weight: 700

.track
  display: flex
  background: #5E3FBF
  border-radius: 14px
  padding: 0
  overflow: visible
  align-self: flex-start

.step
  position: relative
  width: 56px
  display: flex
  flex-direction: column
  align-items: center
  padding: 22px 0 12px
  color: #FFFFFF
  background: transparent
  cursor: pointer

  &:first-child
    border-top-left-radius: 14px
    border-bottom-left-radius: 14px

  &:last-child
    border-top-right-radius: 14px
    border-bottom-right-radius: 14px

  &.active
    background: #4A2D8C

  &.locked
    color: #B0A6D6
    background: #9A8DC9

    &.active
      background: #9A8DC9

  .icon
    position: absolute
    top: -18px
    width: 36px
    height: 36px
    background: #FFFFFF
    border-radius: 50%
    display: flex
    align-items: center
    justify-content: center
    font-size: 18px
    box-shadow: 0 2px 6px rgba(0,0,0,0.1)

  .num
    font-size: 15px
    font-weight: 700

.arrow
  align-self: flex-start
  margin-left: 280px
  margin-top: -2px

.continue
  margin-top: 6px
  background: linear-gradient(180deg, #E07AB5 0%, #C955A0 100%)
  border: none
  border-radius: 999px
  padding: 18px 64px
  color: #FFFFFF
  font-size: 22px
  font-weight: 700
  cursor: pointer
  box-shadow: 0 6px 0 #A23F84, 0 10px 18px rgba(192, 70, 152, 0.4)
  transition: transform 0.1s, box-shadow 0.1s
  align-self: stretch

  &:active
    transform: translateY(3px)
    box-shadow: 0 3px 0 #A23F84, 0 6px 12px rgba(192, 70, 152, 0.4)
</style>
