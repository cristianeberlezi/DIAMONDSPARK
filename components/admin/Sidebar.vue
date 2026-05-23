<template>
  <aside class="admin-sidebar">
    <div class="brand">
      <div class="logo">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none">
          <path d="M12 2 L22 7 V17 L12 22 L2 17 V7 Z" stroke="#00D4FF" stroke-width="1.5" fill="rgba(0, 212, 255, 0.15)"/>
          <text x="12" y="16" text-anchor="middle" font-size="9" font-weight="800" fill="#00D4FF" font-family="Orbitron">DS</text>
        </svg>
      </div>
      <div class="brand-text">
        <strong>DIAMOND SPARK</strong>
        <span>Painel do Coach</span>
      </div>
    </div>

    <nav class="menu">
      <NuxtLink
        v-for="m in menu"
        :key="m.to"
        :to="m.to"
        :class="['menu-item', { active: isActive(m.to) }]"
      >
        <span class="ico" v-html="m.icon"></span>
        <span class="label">{{ m.label }}</span>
        <span v-if="m.badge" class="badge">{{ m.badge }}</span>
      </NuxtLink>
    </nav>

    <div class="quick-action">
      <NuxtLink to="/admin/quest/criar" class="create-btn">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
          <line x1="12" y1="5" x2="12" y2="19"/>
          <line x1="5" y1="12" x2="19" y2="12"/>
        </svg>
        CRIAR QUEST
      </NuxtLink>
    </div>

    <button class="logout-btn" @click="logout">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
        <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/>
        <polyline points="16 17 21 12 16 7"/>
        <line x1="21" y1="12" x2="9" y2="12"/>
      </svg>
      <span>SAIR</span>
    </button>
  </aside>
</template>

<script setup>
const route = useRoute()
const router = useRouter()
const supabase = useSupabaseClient()

const menu = [
  { to: '/admin', label: 'DASHBOARD', icon: '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="7" height="9" rx="1"/><rect x="14" y="3" width="7" height="5" rx="1"/><rect x="14" y="12" width="7" height="9" rx="1"/><rect x="3" y="16" width="7" height="5" rx="1"/></svg>' },
  { to: '/admin/alunos', label: 'ALUNOS', icon: '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>', badge: 142 },
  { to: '/admin/quests', label: 'QUESTS', icon: '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/></svg>', badge: 8 },
  { to: '/admin/estatisticas', label: 'ESTATÍSTICAS', icon: '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="20" x2="18" y2="10"/><line x1="12" y1="20" x2="12" y2="4"/><line x1="6" y1="20" x2="6" y2="14"/></svg>' },
  { to: '/admin/templates', label: 'TEMPLATES', icon: '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="18" height="18" rx="2"/><line x1="3" y1="9" x2="21" y2="9"/><line x1="9" y1="21" x2="9" y2="9"/></svg>' },
  { to: '/admin/configuracoes', label: 'CONFIGURAÇÕES', icon: '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09a1.65 1.65 0 0 0-1-1.51 1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09a1.65 1.65 0 0 0 1.51-1 1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 2.83-2.83l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z"/></svg>' }
]

function isActive(to) {
  if (to === '/admin') return route.path === '/admin'
  return route.path.startsWith(to)
}

async function logout() {
  await supabase.auth.signOut()
  router.push('/')
}
</script>

<style lang="sass" scoped>
.admin-sidebar
  width: 240px
  height: 100vh
  background: linear-gradient(180deg, rgba(8, 18, 40, 0.95), rgba(5, 11, 26, 1))
  border-right: 1px solid var(--game-border)
  padding: 18px 14px 16px
  display: flex
  flex-direction: column
  gap: 18px
  font-family: 'Rajdhani', 'Inter', sans-serif

.brand
  display: flex
  align-items: center
  gap: 10px
  padding: 4px 6px 16px
  border-bottom: 1px solid var(--game-border)

.logo
  width: 36px
  height: 36px
  display: flex
  align-items: center
  justify-content: center
  filter: drop-shadow(0 0 6px var(--game-cyan-glow))

.brand-text
  display: flex
  flex-direction: column
  line-height: 1.1

  strong
    font-family: 'Orbitron', sans-serif
    font-size: 12px
    font-weight: 800
    letter-spacing: 1.5px
    color: var(--game-text)

  span
    font-size: 10px
    color: var(--game-text-dim)
    letter-spacing: 0.5px

.menu
  display: flex
  flex-direction: column
  gap: 4px

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
  text-decoration: none
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

  .label
    flex: 1

  .badge
    padding: 2px 7px
    border-radius: 999px
    background: rgba(0, 212, 255, 0.15)
    border: 1px solid var(--game-cyan)
    font-family: 'Orbitron', sans-serif
    font-size: 9px
    font-weight: 700
    color: var(--game-cyan)

.quick-action
  margin-top: auto

.create-btn
  display: flex
  align-items: center
  justify-content: center
  gap: 8px
  padding: 12px
  background: linear-gradient(180deg, rgba(0, 130, 200, 0.55), rgba(0, 80, 150, 0.75))
  border: 1px solid var(--game-cyan)
  border-radius: 8px
  color: var(--game-cyan)
  font-family: 'Orbitron', sans-serif
  font-size: 11px
  font-weight: 700
  letter-spacing: 1.5px
  cursor: pointer
  text-decoration: none
  text-shadow: 0 0 6px var(--game-cyan-glow)
  box-shadow: 0 0 14px rgba(0, 212, 255, 0.25), inset 0 0 10px rgba(0, 212, 255, 0.1)
  transition: all 0.2s

  &:hover
    transform: translateY(-1px)
    box-shadow: 0 0 22px rgba(0, 212, 255, 0.5)

.logout-btn
  display: flex
  align-items: center
  justify-content: center
  gap: 8px
  padding: 10px
  background: rgba(0, 0, 0, 0.3)
  border: 1px solid var(--game-border)
  border-radius: 8px
  color: var(--game-text-dim)
  font-family: 'Orbitron', sans-serif
  font-size: 11px
  font-weight: 700
  letter-spacing: 1.5px
  cursor: pointer
  transition: all 0.2s

  &:hover
    border-color: #FF6B6B
    color: #FF6B6B
    background: rgba(255, 107, 107, 0.08)
</style>
