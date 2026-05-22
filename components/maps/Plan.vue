<template>
  <div class="plan">
    <h2 class="title">Tu es ici!</h2>

    <div class="subtitle">
      <span class="label">Today's Plan</span>
      <strong>Book "In the Forest"</strong>
    </div>

    <div class="grid">
      <div v-for="(item, i) in items" :key="i" class="thumb" :style="{ background: item.bg }">
        <span class="emoji">{{ item.emoji }}</span>
        <span v-if="item.done" class="check">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="20 6 9 17 4 12"/>
          </svg>
        </span>
      </div>
    </div>
  </div>
</template>

<script setup>
const items = [
  { emoji: '🥗', bg: '#A8E6CF', done: true },
  { emoji: '🌊', bg: '#2D5BAA', done: true },
  { emoji: '🦍', bg: '#3D3D3D', done: true },
  { emoji: '🐘', bg: '#F5C66B', done: false },
  { emoji: '🦖', bg: '#FFB69E', done: false },
  { emoji: '🐸', bg: '#8ED96E', done: false },
  { emoji: '🌲', bg: '#9BD17E', done: false },
  { emoji: '🅰️', bg: '#B8E6FF', done: false },
  { emoji: '🌽', bg: '#7CB342', done: false },
  { emoji: '🏝️', bg: '#5BA3CF', done: false },
  { emoji: '🌲', bg: '#9BD17E', done: false },
  { emoji: '🅰️', bg: '#B8E6FF', done: false }
]
</script>

<style lang="sass" scoped>
.plan
  display: flex
  flex-direction: column
  gap: 12px

.title
  margin: 0
  color: #6B4EAA
  font-size: 28px
  font-weight: 800
  letter-spacing: -0.5px

.subtitle
  display: flex
  align-items: center
  gap: 8px
  font-size: 18px

  .label
    color: var(--cor-cinza-escuro)
    font-weight: 500

  strong
    color: var(--cor-preto)
    font-weight: 700

.grid
  display: grid
  grid-template-columns: repeat(6, 1fr)
  gap: 10px
  max-width: 560px

.thumb
  position: relative
  aspect-ratio: 1
  border-radius: 14px
  display: flex
  align-items: center
  justify-content: center
  cursor: pointer
  transition: transform 0.15s
  overflow: hidden

  &:hover
    transform: translateY(-2px)

  .emoji
    font-size: 28px

  .check
    position: absolute
    inset: 0
    background: rgba(72, 200, 132, 0.7)
    display: flex
    align-items: center
    justify-content: center

    svg
      width: 28px
      height: 28px
      stroke-width: 3
</style>
