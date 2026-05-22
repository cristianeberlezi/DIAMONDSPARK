<template>
  <div class="card">
    <div class="card-header">
      <div class="title">
        <h3>Examination Results By Branch</h3>
        <span class="info">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="12" cy="12" r="10"/>
            <line x1="12" y1="16" x2="12" y2="12"/>
            <line x1="12" y1="8" x2="12.01" y2="8"/>
          </svg>
        </span>
      </div>
      <div class="legend">
        <span><i class="dot pass"></i>Pass</span>
        <span><i class="dot fell"></i>Fell</span>
        <span><i class="dot na"></i>Not Attended</span>
      </div>
    </div>

    <div class="chart-wrap">
      <ClientOnly>
        <Apexchart type="bar" height="100%" width="100%" :options="options" :series="series" />
      </ClientOnly>
    </div>
  </div>
</template>

<script setup>
const series = [
  { name: 'Pass', data: [110, 130, 150, 90, 95] },
  { name: 'Fell', data: [50, 40, 35, 50, 50] },
  { name: 'Not Attended', data: [40, 30, 20, 50, 40] }
]

const options = {
  chart: {
    type: 'bar',
    stacked: true,
    toolbar: { show: false },
    fontFamily: "'Inter', sans-serif",
    parentHeightOffset: 0
  },
  plotOptions: {
    bar: {
      horizontal: false,
      columnWidth: '38%',
      borderRadius: 10,
      borderRadiusApplication: 'around',
      borderRadiusWhenStacked: 'all'
    }
  },
  colors: ['#8A5CFF', '#F16F3C', '#E8E8F0'],
  dataLabels: { enabled: false },
  fill: {
    opacity: 1,
    type: ['solid', 'solid', 'pattern'],
    pattern: {
      style: 'slantedLines',
      width: 6,
      height: 6,
      strokeWidth: 2
    }
  },
  stroke: { width: 0 },
  xaxis: {
    categories: ['English', 'Math', 'Arts', 'Science', 'Phys. Ed'],
    labels: {
      style: { colors: '#475274', fontSize: '11px', fontWeight: 500 }
    },
    axisBorder: { show: false },
    axisTicks: { show: false }
  },
  yaxis: {
    tickAmount: 4,
    labels: {
      style: { colors: '#8A92A6', fontSize: '10px' }
    },
    max: 200
  },
  grid: {
    borderColor: '#F0F1F5',
    strokeDashArray: 4,
    yaxis: { lines: { show: true } },
    xaxis: { lines: { show: false } }
  },
  legend: { show: false },
  tooltip: {
    y: { formatter: (v) => `${v} students` }
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

.chart-wrap
  flex: 1
  min-height: 0
  display: flex

  :deep(.apexcharts-canvas), :deep(.vue-apexcharts)
    width: 100% !important
    height: 100% !important

.card-header
  display: flex
  align-items: center
  justify-content: space-between
  margin-bottom: 8px

.title
  display: flex
  align-items: center
  gap: 6px

  h3
    font-size: var(--f3)
    font-weight: 600
    color: var(--cor-preto)
    margin: 0

  .info
    color: var(--cor-cinza)
    display: flex
    align-items: center

.legend
  display: flex
  gap: 16px
  font-size: var(--f1)
  color: var(--cor-cinza-escuro)

  span
    display: flex
    align-items: center
    gap: 6px

  .dot
    width: 8px
    height: 8px
    border-radius: 50%
    display: inline-block

    &.pass
      background: #8A5CFF

    &.fell
      background: #F16F3C

    &.na
      background: #E8E8F0
</style>
