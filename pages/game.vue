<template>
  <div class="game-page">
    <div :class="['layout', { 'sidebar-hidden': !sidebarOpen }]">
      <!-- Sidebar esquerda -->
      <div class="col col-sidebar">
        <GameSidebar v-show="sidebarOpen" class="sidebar-area" />
        <button class="toggle toggle-left" @click="sidebarOpen = !sidebarOpen" :aria-label="sidebarOpen ? 'Esconder menu' : 'Mostrar menu'">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
            <polyline v-if="sidebarOpen" points="15 18 9 12 15 6"/>
            <polyline v-else points="9 18 15 12 9 6"/>
          </svg>
        </button>
      </div>

      <!-- Coluna central: mapa FULL -->
      <div class="col col-main">
        <GameMapBoard class="board-area" />
      </div>
    </div>
  </div>
</template>

<script setup>
definePageMeta({
  layout: 'default',
  middleware: 'auth'
})

useHead({
  title: 'Game — Mapa de Missões'
})

const sidebarOpen = ref(true)
</script>

<style lang="sass" scoped>
.game-page
  height: 100vh
  width: 100vw
  background: var(--game-bg)
  color: var(--game-text)
  font-family: 'Rajdhani', 'Inter', sans-serif
  overflow: hidden

.layout
  display: grid
  grid-template-columns: 240px 1fr
  height: 100vh
  width: 100vw
  transition: grid-template-columns 0.3s ease

  &.sidebar-hidden
    grid-template-columns: 28px 1fr

.col
  position: relative
  min-width: 0
  min-height: 0

.col-sidebar
  display: flex

  .sidebar-area
    flex: 1
    min-width: 0
    overflow: hidden

.col-main
  display: flex
  align-items: stretch
  height: 100%
  width: 100%
  min-width: 0
  min-height: 0

  .board-area
    flex: 1
    width: 100%
    height: 100%
    align-self: stretch

/* Toggle */
.toggle
  position: absolute
  top: 50%
  transform: translateY(-50%)
  width: 22px
  height: 56px
  background: var(--game-panel-solid)
  border: 1px solid var(--game-border)
  color: var(--game-cyan)
  display: flex
  align-items: center
  justify-content: center
  cursor: pointer
  z-index: 20
  transition: all 0.2s

  &:hover
    background: rgba(0, 212, 255, 0.15)
    box-shadow: 0 0 12px var(--game-cyan-glow)

.toggle-left
  right: -11px
  border-radius: 0 6px 6px 0

@media screen and (max-width: 1200px)
  .layout
    grid-template-columns: 200px 1fr

    &.sidebar-hidden
      grid-template-columns: 28px 1fr
</style>
