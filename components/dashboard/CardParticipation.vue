<template>
  <div class="card">
    <div class="card-header">
      <h3>Student participation Rate by Branch</h3>
    </div>

    <ul class="bars">
      <li v-for="item in items" :key="item.label">
        <div class="row">
          <span class="label">{{ item.label }}</span>
          <span class="value">{{ item.value }}%</span>
        </div>
        <div class="track">
          <div class="fill" :style="{ width: `${item.value}%` }"></div>
        </div>
      </li>
    </ul>
  </div>
</template>

<script setup>
const items = [
  { label: 'English', value: 89 },
  { label: 'Arts', value: 87.67 },
  { label: 'Maths', value: 87.33 },
  { label: 'Phys.Ed', value: 85.33 },
  { label: 'Science', value: 82.33 }
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
  margin-bottom: 10px
  flex-shrink: 0

  h3
    font-size: var(--f3)
    font-weight: 600
    color: var(--cor-preto)
    margin: 0

.bars
  list-style: none
  padding: 0
  margin: 0
  display: flex
  flex-direction: column
  justify-content: space-around
  flex: 1
  gap: 8px
  min-height: 0

.row
  display: flex
  align-items: center
  justify-content: space-between
  margin-bottom: 4px

.label
  font-size: var(--f1)
  color: var(--cor-cinza-escuro)
  font-weight: 500

.value
  font-size: var(--f1)
  color: var(--cor-preto)
  font-weight: 600

.track
  height: 7px
  background: var(--cor-gelo)
  border-radius: var(--r-full)
  overflow: hidden

.fill
  height: 100%
  background: var(--cor-laranja)
  border-radius: var(--r-full)
  transition: width 0.6s ease
</style>
