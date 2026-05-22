<template>
  <header class="admin-header">
    <div class="title-block">
      <span class="breadcrumb">{{ breadcrumb }}</span>
      <h1>{{ title }}</h1>
    </div>

    <div class="actions">
      <div class="search">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="11" cy="11" r="8"/>
          <line x1="21" y1="21" x2="16.65" y2="16.65"/>
        </svg>
        <input type="text" placeholder="Buscar aluno, quest..." v-model="query" />
      </div>

      <button class="icon-btn" aria-label="Notificações">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
          <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/>
          <path d="M13.73 21a2 2 0 0 1-3.46 0"/>
        </svg>
        <span class="dot"></span>
      </button>

      <div class="profile">
        <img src="/images/avatar.png" alt="Professor" />
        <div class="profile-text">
          <strong>Prof. Jorge</strong>
          <span>Coach</span>
        </div>
      </div>
    </div>
  </header>
</template>

<script setup>
defineProps({
  title: { type: String, default: 'Dashboard' },
  breadcrumb: { type: String, default: 'ADMIN' }
})

const query = ref('')
</script>

<style lang="sass" scoped>
.admin-header
  display: flex
  align-items: center
  justify-content: space-between
  gap: 24px
  padding: 18px 28px
  background: rgba(8, 18, 40, 0.5)
  border-bottom: 1px solid var(--game-border)
  font-family: 'Rajdhani', 'Inter', sans-serif

.title-block
  min-width: 0

.breadcrumb
  font-family: 'Orbitron', sans-serif
  font-size: 10px
  letter-spacing: 2px
  color: var(--game-text-dim)
  margin-bottom: 4px
  display: block

h1
  margin: 0
  font-family: 'Orbitron', sans-serif
  font-size: 22px
  font-weight: 700
  letter-spacing: 1px
  color: var(--game-text)

.actions
  display: flex
  align-items: center
  gap: 14px

.search
  display: flex
  align-items: center
  gap: 8px
  width: 280px
  padding: 8px 14px
  background: rgba(0, 0, 0, 0.4)
  border: 1px solid var(--game-border)
  border-radius: 8px
  color: var(--game-text-dim)
  transition: all 0.2s

  &:focus-within
    border-color: var(--game-cyan)
    box-shadow: 0 0 10px var(--game-cyan-glow)

  input
    flex: 1
    background: transparent
    border: none
    outline: none
    color: var(--game-text)
    font-size: 13px
    font-family: inherit

    &::placeholder
      color: var(--game-text-dim)

.icon-btn
  position: relative
  width: 36px
  height: 36px
  border-radius: 8px
  background: rgba(0, 0, 0, 0.4)
  border: 1px solid var(--game-border)
  color: var(--game-text-dim)
  display: flex
  align-items: center
  justify-content: center
  cursor: pointer

  &:hover
    border-color: var(--game-cyan)
    color: var(--game-cyan)

  .dot
    position: absolute
    top: 6px
    right: 6px
    width: 6px
    height: 6px
    border-radius: 50%
    background: #FF6B6B
    box-shadow: 0 0 6px rgba(255, 107, 107, 0.6)

.profile
  display: flex
  align-items: center
  gap: 10px
  padding: 5px 14px 5px 5px
  background: rgba(0, 0, 0, 0.35)
  border: 1px solid var(--game-border)
  border-radius: 999px
  cursor: pointer
  transition: all 0.2s

  &:hover
    border-color: var(--game-cyan)

  img
    width: 30px
    height: 30px
    border-radius: 50%
    border: 1.5px solid var(--game-cyan)
    object-fit: cover

  .profile-text
    display: flex
    flex-direction: column
    line-height: 1.2

    strong
      font-size: 12px
      color: var(--game-text)
      font-weight: 600

    span
      font-size: 10px
      color: var(--game-text-dim)
      letter-spacing: 0.5px
</style>
