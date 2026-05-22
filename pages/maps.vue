<template>
  <div class="maps-page">
    <div class="board-wrap">
      <MapsBoard />
    </div>

    <div class="bottom">
      <MapsPlan class="plan-area" />
      <MapsSteps class="steps-area" />
    </div>
  </div>
</template>

<script setup>
definePageMeta({
  layout: 'default'
})

useHead({
  title: 'Maps — Tu es ici!'
})
</script>

<style lang="sass" scoped>
.maps-page
  min-height: 100vh
  background: #FFFFFF
  padding: 16px 32px 32px
  display: flex
  flex-direction: column
  gap: 28px

.board-wrap
  width: 100%
  height: 520px

.bottom
  display: grid
  grid-template-columns: 1fr auto
  gap: 32px
  align-items: start

.plan-area
  min-width: 0

.steps-area
  min-width: 480px

@media screen and (max-width: 1100px)
  .bottom
    grid-template-columns: 1fr

  .steps-area
    min-width: 0
</style>
