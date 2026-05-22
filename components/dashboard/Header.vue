<template>
  <header class="dashboard-header">
    <div class="title-block">
      <h1>Student Counseling Effectiveness</h1>
      <p>Let's see students performance</p>
    </div>

    <div class="controls">
      <div class="search">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="11" cy="11" r="8"/>
          <line x1="21" y1="21" x2="16.65" y2="16.65"/>
        </svg>
        <input type="text" placeholder="Search now..." />
      </div>

      <div class="select">
        <span>{{ grade }}</span>
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="6 9 12 15 18 9"/>
        </svg>
      </div>

      <button class="filter-btn" aria-label="Filtros">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <line x1="4" y1="6" x2="14" y2="6"/>
          <circle cx="17" cy="6" r="2"/>
          <line x1="4" y1="12" x2="8" y2="12"/>
          <circle cx="11" cy="12" r="2"/>
          <line x1="14" y1="12" x2="20" y2="12"/>
          <line x1="4" y1="18" x2="16" y2="18"/>
          <circle cx="19" cy="18" r="2"/>
        </svg>
      </button>
    </div>
  </header>
</template>

<script setup>
const grade = ref('Select Grade')
</script>

<style lang="sass" scoped>
.dashboard-header
  display: flex
  align-items: center
  justify-content: space-between
  padding: 10px 60px 8px
  gap: 16px
  flex-wrap: wrap
  flex-shrink: 0

.title-block
  h1
    font-size: var(--f5)
    font-weight: 700
    color: var(--cor-preto)
    margin: 0 0 2px

  p
    font-size: var(--f1)
    color: var(--cor-cinza)
    margin: 0
    font-weight: 400

.controls
  display: flex
  align-items: center
  gap: 12px

.search
  display: flex
  align-items: center
  gap: 8px
  background: var(--cor-branco)
  border: 1px solid var(--cor-cinza-claro)
  border-radius: var(--r-full)
  padding: 6px 12px
  width: 180px
  color: var(--cor-cinza)

  input
    border: none
    outline: none
    background: transparent
    font-size: var(--f3)
    width: 100%
    color: var(--cor-preto)
    font-family: inherit

    &::placeholder
      color: var(--cor-cinza)

.select
  display: flex
  align-items: center
  justify-content: space-between
  gap: 12px
  background: var(--cor-branco)
  border: 1px solid var(--cor-cinza-claro)
  border-radius: var(--r-full)
  padding: 6px 12px
  font-size: var(--f2)
  color: var(--cor-preto)
  cursor: pointer
  min-width: 120px

.filter-btn
  width: 32px
  height: 32px
  border-radius: var(--r-md)
  border: 1px solid var(--cor-cinza-claro)
  background: var(--cor-branco)
  display: flex
  align-items: center
  justify-content: center
  cursor: pointer
  color: var(--cor-preto)
</style>
