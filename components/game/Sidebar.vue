<template>
  <aside class="sidebar">
    <div class="avatar-block">
      <div class="avatar">
        <img src="/images/P01user.png" alt="Personagem" />
      </div>
      <div class="profile">
        <div class="badge-r">R</div>
        <div class="profile-text">
          <strong>REALISTA</strong>
          <span>O CONSTRUTOR</span>
        </div>
      </div>
    </div>

    <nav class="menu">
      <button
        v-for="m in menu"
        :key="m.id"
        :class="['menu-item', { active: m.id === active }]"
        @click="active = m.id"
      >
        <span class="ico" v-html="m.icon"></span>
        <span class="label">{{ m.label }}</span>
      </button>
    </nav>

    <button class="logout-btn" @click="logout">
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
        <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/>
        <polyline points="16 17 21 12 16 7"/>
        <line x1="21" y1="12" x2="9" y2="12"/>
      </svg>
      <span>SAIR</span>
    </button>
  </aside>
</template>

<script setup>
const router = useRouter()
const supabase = useSupabaseClient()
const active = ref('missoes')

async function logout() {
  await supabase.auth.signOut()
  router.push('/login')
}

const menu = [
  { id: 'missoes', label: 'MISSÕES', icon: '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2L2 7l10 5 10-5-10-5z"/><path d="m2 17 10 5 10-5"/><path d="m2 12 10 5 10-5"/></svg>' },
  { id: 'skills', label: 'SKILLS', icon: '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/></svg>' },
  { id: 'inventario', label: 'INVENTÁRIO', icon: '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M20 7H4a2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2z"/><path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"/></svg>' },
  { id: 'conquistas', label: 'CONQUISTAS', icon: '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M6 9H4.5a2.5 2.5 0 0 1 0-5H6"/><path d="M18 9h1.5a2.5 2.5 0 0 0 0-5H18"/><path d="M4 22h16"/><path d="M10 14.66V17c0 .55-.47.98-.97 1.21C7.85 18.75 7 20.24 7 22"/><path d="M14 14.66V17c0 .55.47.98.97 1.21C16.15 18.75 17 20.24 17 22"/><path d="M18 2H6v7a6 6 0 0 0 12 0V2Z"/></svg>' },
  { id: 'ranking', label: 'RANKING', icon: '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="20" x2="18" y2="10"/><line x1="12" y1="20" x2="12" y2="4"/><line x1="6" y1="20" x2="6" y2="14"/></svg>' },
  { id: 'configuracoes', label: 'CONFIGURAÇÕES', icon: '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09a1.65 1.65 0 0 0-1-1.51 1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09a1.65 1.65 0 0 0 1.51-1 1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 2.83-2.83l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z"/></svg>' }
]
</script>

<style lang="sass" scoped>
.sidebar
  width: 240px
  height: 100%
  background: linear-gradient(180deg, rgba(8, 18, 40, 0.85), rgba(5, 11, 26, 0.95))
  border-right: 1px solid var(--game-border)
  backdrop-filter: blur(10px)
  display: flex
  flex-direction: column
  padding: 16px 16px 20px
  gap: 18px

.avatar-block
  display: flex
  flex-direction: column
  gap: 14px

.avatar
  aspect-ratio: 1
  border-radius: 12px
  background: linear-gradient(135deg, #1a2540, #0a1428)
  border: 1px solid var(--game-border)
  display: flex
  align-items: center
  justify-content: center
  position: relative
  overflow: hidden

  &::after
    content: ''
    position: absolute
    inset: 0
    background: radial-gradient(circle at 50% 30%, rgba(0, 212, 255, 0.18), transparent 65%)
    pointer-events: none
    z-index: 2

  img
    position: relative
    width: 100%
    height: 100%
    object-fit: cover
    object-position: center top
    z-index: 1

.profile
  display: flex
  align-items: center
  gap: 10px

.badge-r
  width: 44px
  height: 44px
  border-radius: 50%
  background: linear-gradient(135deg, #0a3d5e, #001a33)
  border: 2px solid var(--game-cyan)
  display: flex
  align-items: center
  justify-content: center
  font-family: 'Orbitron', sans-serif
  font-weight: 800
  font-size: 22px
  color: var(--game-cyan)
  box-shadow: 0 0 12px var(--game-cyan-glow), inset 0 0 8px rgba(0, 212, 255, 0.2)

.profile-text
  display: flex
  flex-direction: column
  line-height: 1.2
  font-family: 'Rajdhani', 'Inter', sans-serif

  strong
    color: var(--game-text)
    font-weight: 700
    font-size: 16px
    letter-spacing: 0.5px

  span
    color: var(--game-text-dim)
    font-size: 11px
    letter-spacing: 1px

.menu
  display: flex
  flex-direction: column
  gap: 6px
  margin-top: 8px

.menu-item
  display: flex
  align-items: center
  gap: 12px
  padding: 11px 14px
  border-radius: 8px
  border: 1px solid transparent
  background: transparent
  color: var(--game-text-dim)
  font-family: 'Rajdhani', 'Inter', sans-serif
  font-weight: 600
  font-size: 13px
  letter-spacing: 1.2px
  cursor: pointer
  transition: all 0.2s

  &:hover
    background: rgba(0, 212, 255, 0.06)
    color: var(--game-text)

  &.active
    background: linear-gradient(90deg, rgba(0, 212, 255, 0.15), transparent)
    border-color: var(--game-cyan)
    color: var(--game-cyan)
    box-shadow: inset 3px 0 0 var(--game-cyan), 0 0 12px rgba(0, 212, 255, 0.15)

  .ico
    display: flex
    align-items: center
    justify-content: center

.logout-btn
  margin-top: auto
  display: flex
  align-items: center
  justify-content: center
  gap: 10px
  padding: 12px
  background: rgba(0, 0, 0, 0.3)
  border: 1px solid var(--game-border)
  border-radius: 8px
  color: var(--game-text-dim)
  font-family: 'Orbitron', sans-serif
  font-size: 12px
  font-weight: 700
  letter-spacing: 2px
  cursor: pointer
  transition: all 0.2s

  &:hover
    border-color: #FF6B6B
    color: #FF6B6B
    background: rgba(255, 107, 107, 0.08)
    box-shadow: 0 0 12px rgba(255, 107, 107, 0.25)
</style>
