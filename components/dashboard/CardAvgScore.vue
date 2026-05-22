<template>
  <div class="card">
    <div class="card-header">
      <h3>Avg-Subject Score</h3>
      <button class="more-btn" aria-label="Mais opções">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
          <circle cx="5" cy="12" r="1.7"/>
          <circle cx="12" cy="12" r="1.7"/>
          <circle cx="19" cy="12" r="1.7"/>
        </svg>
      </button>
    </div>

    <div class="bubble-wrap">
      <svg viewBox="0 0 280 280" preserveAspectRatio="xMidYMid meet" class="bubble-chart">
        <!-- circles share the bottom edge (cy = 280 - r) -->
        <circle
          v-for="(item, i) in items"
          :key="item.label"
          :cx="140"
          :cy="280 - item.r"
          :r="item.r"
          :fill="item.color"
        />
        <text
          v-for="(item, i) in items"
          :key="`t-${item.label}`"
          :x="140"
          :y="280 - item.r * 2 + 16"
          text-anchor="middle"
          class="bubble-label"
          :fill="i === items.length - 1 ? '#FFFFFF' : '#180802'"
        >
          {{ item.value.toFixed(2) }}%
        </text>
      </svg>
    </div>

    <div class="legend">
      <span v-for="item in items" :key="`l-${item.label}`">
        <i class="dot" :style="{ background: item.color }"></i>{{ item.label }}
      </span>
    </div>
  </div>
</template>

<script setup>
const items = [
  { label: 'English', value: 89.76, r: 130, color: '#FBEDE5' },
  { label: 'Math', value: 74.37, r: 105, color: '#F8DCC9' },
  { label: 'Arts', value: 81.86, r: 80, color: '#F4C2A4' },
  { label: 'Science', value: 45.05, r: 50, color: '#F16F3C' }
]
</script>

<style lang="sass" scoped>
.card
  background: var(--cor-branco)
  border-radius: var(--r-2xl)
  padding: 10px 14px
  box-shadow: var(--shadow-sm)
  display: flex
  flex-direction: column
  min-height: 0
  height: 100%

.card-header
  display: flex
  align-items: center
  justify-content: space-between
  margin-bottom: 8px

  h3
    font-size: var(--f3)
    font-weight: 600
    color: var(--cor-preto)
    margin: 0

.more-btn
  width: 28px
  height: 28px
  border-radius: var(--r-full)
  border: 1px solid var(--cor-cinza-claro)
  background: var(--cor-branco)
  display: flex
  align-items: center
  justify-content: center
  cursor: pointer
  color: var(--cor-cinza-escuro)

.bubble-wrap
  flex: 1
  min-height: 0
  display: flex
  align-items: center
  justify-content: center

.bubble-chart
  width: 100%
  height: 100%
  max-height: 100%

.bubble-label
  font-size: 11px
  font-weight: 600
  font-family: 'Inter', sans-serif

.legend
  display: flex
  gap: 16px
  flex-wrap: wrap
  font-size: var(--f1)
  color: var(--cor-cinza-escuro)
  margin-top: 8px

  span
    display: flex
    align-items: center
    gap: 6px

  .dot
    width: 8px
    height: 8px
    border-radius: 50%
    display: inline-block
</style>
