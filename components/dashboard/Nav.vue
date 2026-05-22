<template>
  <nav class="dashboard-nav">
    <div class="logo">
      <div class="logo-icon">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
          <rect x="2" y="2" width="9" height="9" rx="2" fill="#F16F3C"/>
          <rect x="13" y="2" width="9" height="9" rx="2" fill="#F16F3C" opacity="0.6"/>
          <rect x="2" y="13" width="9" height="9" rx="2" fill="#F16F3C" opacity="0.6"/>
          <rect x="13" y="13" width="9" height="9" rx="2" fill="#F16F3C"/>
        </svg>
      </div>
      <div class="logo-text">
        <span class="brand">Bold BI</span>
        <span class="tagline">By Syncfusion</span>
      </div>
    </div>

    <ul class="links">
      <li v-for="item in items" :key="item" :class="{ active: item === active }" @click="active = item">
        {{ item }}
      </li>
    </ul>

    <div class="actions">
      <button class="icon-btn" aria-label="Configurações">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="12" cy="12" r="3"/>
          <path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09a1.65 1.65 0 0 0-1-1.51 1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09a1.65 1.65 0 0 0 1.51-1 1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 2.83-2.83l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z"/>
        </svg>
      </button>
      <button class="icon-btn" aria-label="Notificações">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
          <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/>
          <path d="M13.73 21a2 2 0 0 1-3.46 0"/>
        </svg>
      </button>
      <div class="avatar">
        <span>JT</span>
      </div>
    </div>
  </nav>
</template>

<script setup>
const items = ['Dashboard', 'Session', 'Feedback', 'Performance', 'Outcomes']
const active = ref('Dashboard')
</script>

<style lang="sass" scoped>
.dashboard-nav
  display: flex
  align-items: center
  justify-content: space-between
  padding: 0 60px
  background: var(--cor-branco)
  border-bottom: 1px solid var(--cor-cinza-claro)
  width: 100%
  height: 80px
  flex-shrink: 0

.logo
  display: flex
  align-items: center
  gap: 10px

.logo-icon
  display: flex
  align-items: center
  justify-content: center

.logo-text
  display: flex
  flex-direction: column
  line-height: 1.1

.brand
  font-size: var(--f3)
  font-weight: 700
  color: var(--cor-preto)

.tagline
  font-size: 9px
  color: var(--cor-cinza)
  font-weight: 400

.links
  display: flex
  list-style: none
  gap: 8px
  padding: 0
  margin: 0

  li
    padding: 6px 14px
    border-radius: var(--r-full)
    font-size: var(--f2)
    color: var(--cor-cinza-escuro)
    cursor: pointer
    transition: all 0.2s ease
    font-weight: 500

    &:hover
      background: var(--cor-gelo)

    &.active
      background: var(--cor-laranja)
      color: var(--cor-branco)

.actions
  display: flex
  align-items: center
  gap: 12px

.icon-btn
  width: 32px
  height: 32px
  border-radius: var(--r-full)
  border: 1px solid var(--cor-cinza-claro)
  background: var(--cor-branco)
  display: flex
  align-items: center
  justify-content: center
  cursor: pointer
  color: var(--cor-cinza-escuro)
  transition: all 0.2s

  &:hover
    background: var(--cor-gelo)

.avatar
  width: 32px
  height: 32px
  border-radius: var(--r-full)
  background: linear-gradient(135deg, var(--cor-laranja), var(--cor-roxo))
  display: flex
  align-items: center
  justify-content: center
  color: var(--cor-branco)
  font-weight: 600
  font-size: var(--f2)
  cursor: pointer

@media screen and (max-width: 1000px)
  .links
    display: none
</style>
