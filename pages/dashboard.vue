<template>
  <div class="dashboard">
    <DashboardNav />

    <div class="content">
      <DashboardHeader />

      <div class="grid">
        <div class="row row-top">
          <DashboardCardExamResults class="card-area" />
          <DashboardCardAvgScore class="card-area" />
        </div>
        <div class="row row-bottom">
          <DashboardCardGradeGender class="card-area" />
          <DashboardCardParticipation class="card-area" />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
definePageMeta({
  layout: 'default'
})

useHead({
  title: 'Dashboard — Student Counseling Effectiveness'
})
</script>

<style lang="sass" scoped>
.dashboard
  height: 100vh
  background: var(--cor-fundo)
  width: 100%
  display: flex
  flex-direction: column
  overflow: hidden

.content
  flex: 1
  display: flex
  flex-direction: column
  min-height: 0

.grid
  flex: 1
  display: grid
  grid-template-rows: 1fr 1fr
  gap: 12px
  padding: 0 60px 14px
  min-height: 0

.row
  display: grid
  gap: 12px
  min-height: 0

  &.row-top
    grid-template-columns: 2fr 1fr

  &.row-bottom
    grid-template-columns: 1fr 1fr

.card-area
  min-height: 0
  min-width: 0

@media screen and (max-width: 1100px)
  .dashboard
    height: auto
    overflow: auto

  .grid
    grid-template-rows: auto

  .row
    &.row-top, &.row-bottom
      grid-template-columns: 1fr
</style>
