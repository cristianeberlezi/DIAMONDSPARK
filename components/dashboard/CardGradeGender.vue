<template>
  <div class="card">
    <div class="card-header">
      <h3>Student by Grade and Gender</h3>
      <button class="more-btn" aria-label="Mais opções">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
          <circle cx="5" cy="12" r="1.7"/>
          <circle cx="12" cy="12" r="1.7"/>
          <circle cx="19" cy="12" r="1.7"/>
        </svg>
      </button>
    </div>

    <div class="content">
      <div class="chart-wrap">
        <ClientOnly>
          <Apexchart type="donut" height="100%" width="100%" :options="options" :series="series" />
        </ClientOnly>
      </div>

      <div class="info">
        <div class="icon-block">
          <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#F16F3C" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
            <path d="M22 10v6M2 10l10-5 10 5-10 5z"/>
            <path d="M6 12v5c3 3 9 3 12 0v-5"/>
          </svg>
        </div>
        <p>The number of students by gender.</p>

        <ul class="grades">
          <li v-for="g in grades" :key="g.label">
            <i class="dot" :style="{ background: g.color }"></i>
            <span class="label">{{ g.label }}</span>
            <span class="pct">{{ g.value.toFixed(2) }}%</span>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script setup>
const grades = [
  { label: 'Grenade 1', value: 25.33, color: '#F16F3C' },
  { label: 'Grenade 2', value: 22.67, color: '#8A5CFF' },
  { label: 'Grenade 3', value: 30.67, color: '#48C884' },
  { label: 'Grenade 4', value: 21.33, color: '#FFD027' }
]

const series = grades.map((g) => g.value)

const options = {
  chart: {
    type: 'donut',
    fontFamily: "'Inter', sans-serif",
    parentHeightOffset: 0
  },
  labels: grades.map((g) => g.label),
  colors: grades.map((g) => g.color),
  stroke: { width: 4, colors: ['#FFFFFF'] },
  dataLabels: { enabled: false },
  legend: { show: false },
  plotOptions: {
    pie: {
      donut: {
        size: '72%',
        labels: {
          show: true,
          name: {
            show: true,
            offsetY: 14,
            color: '#8A92A6',
            fontSize: '11px',
            fontWeight: 400
          },
          value: {
            show: true,
            offsetY: -8,
            color: '#180802',
            fontSize: '22px',
            fontWeight: 700,
            formatter: () => '300'
          },
          total: {
            show: true,
            label: 'Students',
            color: '#8A92A6',
            fontSize: '12px',
            fontWeight: 400,
            formatter: () => '300'
          }
        }
      }
    }
  },
  tooltip: {
    y: { formatter: (v) => `${v}%` }
  }
}
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
  flex-shrink: 0

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

.content
  flex: 1
  display: grid
  grid-template-columns: minmax(140px, 1fr) 1fr
  gap: 16px
  align-items: center
  min-height: 0

.chart-wrap
  display: flex
  align-items: center
  justify-content: center
  height: 100%
  min-height: 0

  :deep(.apexcharts-canvas), :deep(.vue-apexcharts)
    width: 100% !important
    height: 100% !important

.info
  display: flex
  flex-direction: column
  gap: 12px

.icon-block
  width: 36px
  height: 36px
  background: var(--cor-laranja-suave)
  border-radius: var(--r-md)
  display: flex
  align-items: center
  justify-content: center

.info p
  font-size: var(--f1)
  color: var(--cor-cinza-escuro)
  margin: 0

.grades
  list-style: none
  padding: 0
  margin: 0
  display: grid
  grid-template-columns: 1fr 1fr
  gap: 8px 16px

  li
    display: grid
    grid-template-columns: auto 1fr
    align-items: center
    gap: 6px
    font-size: var(--f1)

  .dot
    width: 8px
    height: 8px
    border-radius: 50%
    grid-row: span 2

  .label
    color: var(--cor-cinza-escuro)
    font-size: var(--f1)

  .pct
    color: var(--cor-preto)
    font-size: var(--f1)
    font-weight: 600
    grid-column: 2

@media screen and (max-width: 640px)
  .content
    grid-template-columns: 1fr
</style>
