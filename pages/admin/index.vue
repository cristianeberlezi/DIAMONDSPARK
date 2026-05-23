<template>
  <div class="admin-page">
    <AdminSidebar />

    <main class="main">
      <AdminHeader title="Dashboard" breadcrumb="ADMIN · OVERVIEW" />

      <div class="content">
        <!-- Stat cards -->
        <section class="stats-grid">
          <AdminStatCard
            label="Alunos Ativos"
            :value="stats.alunosAtivos"
            :suffix="`/ ${stats.alunosTotal}`"
            accent="cyan"
            :trend="8"
            sub="Últimos 7 dias"
            :icon="ico.users"
          />
          <AdminStatCard
            label="Quests em Andamento"
            :value="stats.questsAtivas"
            accent="orange"
            :trend="12"
            :sub="`${stats.questsConcluidas} concluídas no total`"
            :icon="ico.quest"
          />
          <AdminStatCard
            label="Tarefas Hoje"
            :value="stats.tarefasHoje"
            accent="green"
            :trend="-3"
            sub="entregas enviadas"
            :icon="ico.check"
          />
          <AdminStatCard
            label="Taxa de Entrega"
            :value="stats.taxaEntrega"
            suffix="%"
            accent="purple"
            :trend="5"
            sub="média da turma"
            :icon="ico.target"
          />
          <AdminStatCard
            label="XP Distribuído"
            :value="(stats.xpDistribuido / 1000).toFixed(1) + 'k'"
            accent="gold"
            :trend="15"
            sub="total acumulado"
            :icon="ico.star"
          />
          <AdminStatCard
            label="Guildas Ativas"
            :value="stats.guildasAtivas"
            accent="cyan"
            :trend="0"
            sub="trabalhando agora"
            :icon="ico.team"
          />
        </section>

        <!-- Quests em andamento + Atividade -->
        <section class="two-cols">
          <div class="panel quests-panel">
            <header>
              <h2>QUESTS EM ANDAMENTO</h2>
              <NuxtLink to="/admin/quests" class="view-all">Ver todas →</NuxtLink>
            </header>

            <div class="quest-list">
              <article v-for="q in activeQuests" :key="q.id" class="quest-row" :class="phaseClass(q.phase)">
                <div class="quest-head">
                  <span class="code">{{ q.code }}</span>
                  <h3>{{ q.title }}</h3>
                  <span class="template">{{ q.template }}</span>
                </div>
                <div class="quest-meta">
                  <div class="meta-item">
                    <span class="meta-key">FASE</span>
                    <span class="meta-val">{{ phaseLabel(q.phase) }}</span>
                  </div>
                  <div class="meta-item">
                    <span class="meta-key">ALUNOS</span>
                    <span class="meta-val">{{ q.students }}</span>
                  </div>
                  <div class="meta-item">
                    <span class="meta-key">DIAS</span>
                    <span class="meta-val">{{ q.days.current }} / {{ q.days.total }}</span>
                  </div>
                  <div class="meta-item progress">
                    <div class="bar">
                      <div class="fill" :style="{ width: `${q.progress}%` }"></div>
                    </div>
                    <span class="pct">{{ q.progress }}%</span>
                  </div>
                </div>
              </article>
            </div>
          </div>

          <div class="panel activity-panel">
            <header>
              <h2>ATIVIDADE RECENTE</h2>
              <span class="live-dot"></span>
            </header>

            <ul class="activity-list">
              <li v-for="a in activity" :key="a.id" :class="`activity-${a.type}`">
                <div class="act-icon">
                  <svg v-if="a.type === 'submission'" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <line x1="22" y1="2" x2="11" y2="13"/>
                    <polygon points="22 2 15 22 11 13 2 9 22 2"/>
                  </svg>
                  <svg v-else-if="a.type === 'claim'" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M4 15s1-1 4-1 5 2 8 2 4-1 4-1V3s-1 1-4 1-5-2-8-2-4 1-4 1z"/>
                    <line x1="4" y1="22" x2="4" y2="15"/>
                  </svg>
                  <svg v-else-if="a.type === 'phase'" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                    <polyline points="20 6 9 17 4 12"/>
                  </svg>
                  <svg v-else width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/>
                  </svg>
                </div>
                <div class="act-content">
                  <p>
                    <strong>{{ a.who }}</strong> {{ a.what }}
                    <span v-if="a.target" class="target">"{{ a.target }}"</span>
                  </p>
                  <time>{{ a.when }}</time>
                </div>
              </li>
            </ul>
          </div>
        </section>

        <!-- Top alunos -->
        <section class="panel students-panel">
          <header>
            <h2>TOP ALUNOS · ATIVIDADE</h2>
            <NuxtLink to="/admin/alunos" class="view-all">Ver todos →</NuxtLink>
          </header>

          <table class="student-table">
            <thead>
              <tr>
                <th>ALUNO</th>
                <th>PERFIL</th>
                <th>NÍVEL</th>
                <th>XP</th>
                <th>QUEST ATUAL</th>
                <th>ATIVIDADE</th>
                <th>STATUS</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="a in topAlunos" :key="a.id" @click="goToStudent(a.id)">
                <td>
                  <div class="aluno-cell">
                    <img src="/images/avatar.png" :alt="a.name" />
                    <div>
                      <strong>{{ a.name }}</strong>
                      <span>{{ a.email }}</span>
                    </div>
                  </div>
                </td>
                <td>
                  <span class="profile-pill" :style="{ '--c': profilesMap[a.profile].color }">
                    {{ a.profile }} · {{ profilesMap[a.profile].name }}
                  </span>
                </td>
                <td class="num">{{ a.level }}</td>
                <td class="num xp">{{ a.xp.toLocaleString('pt-BR') }}</td>
                <td>
                  <strong>{{ a.quest }}</strong>
                  <small>{{ phaseLabel(a.phase) }}</small>
                </td>
                <td>
                  <div class="activity-bar">
                    <div class="ab-fill" :style="{ width: `${a.activity}%` }"></div>
                    <span>{{ a.activity }}%</span>
                  </div>
                </td>
                <td>
                  <span :class="['status-pill', a.status]">{{ a.status === 'active' ? 'ATIVO' : 'INATIVO' }}</span>
                </td>
              </tr>
            </tbody>
          </table>
        </section>
      </div>
    </main>
  </div>
</template>

<script setup>
import { stats, quests, alunos, activity, profilesMap } from '~/components/admin/data.js'

definePageMeta({ layout: 'default', middleware: ['auth', 'professor'] })
useHead({ title: 'Admin Dashboard · Diamond Spark' })

const router = useRouter()

const activeQuests = computed(() => quests.filter(q => q.status === 'active'))
const topAlunos = computed(() => [...alunos].sort((a, b) => b.activity - a.activity).slice(0, 7))

const phases = {
  sentir: { label: '🟢 SENTIR', color: '#6FE36F' },
  imaginar: { label: '🔵 IMAGINAR', color: '#00D4FF' },
  fazer: { label: '🟡 FAZER', color: '#FFC845' },
  compartilhar: { label: '🟣 COMPARTILHAR', color: '#B86CFF' }
}

function phaseLabel(key) {
  return phases[key]?.label || '—'
}

function phaseClass(key) {
  return key ? `phase-${key}` : ''
}

function goToStudent(id) {
  router.push(`/admin/aluno/${id}`)
}

const ico = {
  users: '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>',
  quest: '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/></svg>',
  check: '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"/></svg>',
  target: '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><circle cx="12" cy="12" r="6"/><circle cx="12" cy="12" r="2"/></svg>',
  star: '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/></svg>',
  team: '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>'
}
</script>

<style lang="sass" scoped>
.admin-page
  display: grid
  grid-template-columns: 240px 1fr
  min-height: 100vh
  background: var(--game-bg)
  background-image: radial-gradient(ellipse at top left, rgba(0, 100, 180, 0.12), transparent 50%), radial-gradient(ellipse at bottom right, rgba(120, 60, 200, 0.1), transparent 50%)
  color: var(--game-text)
  font-family: 'Rajdhani', 'Inter', sans-serif

.main
  min-width: 0
  display: flex
  flex-direction: column

.content
  flex: 1
  padding: 24px 28px 36px
  display: flex
  flex-direction: column
  gap: 24px

/* ===== Stat grid ===== */
.stats-grid
  display: grid
  grid-template-columns: repeat(6, 1fr)
  gap: 14px

/* ===== Panels ===== */
.panel
  background: rgba(8, 18, 40, 0.55)
  border: 1px solid var(--game-border)
  border-radius: 12px
  padding: 18px 20px
  backdrop-filter: blur(8px)

  > header
    display: flex
    align-items: center
    justify-content: space-between
    margin-bottom: 16px

    h2
      margin: 0
      font-family: 'Orbitron', sans-serif
      font-size: 13px
      font-weight: 700
      letter-spacing: 2px
      color: var(--game-text)

    .view-all
      font-family: 'Orbitron', sans-serif
      font-size: 10px
      letter-spacing: 1px
      color: var(--game-cyan)
      text-decoration: none

      &:hover
        text-shadow: 0 0 6px var(--game-cyan-glow)

.two-cols
  display: grid
  grid-template-columns: 1.4fr 1fr
  gap: 18px

/* ===== Quest list ===== */
.quest-list
  display: flex
  flex-direction: column
  gap: 10px

.quest-row
  padding: 12px 14px
  background: rgba(0, 0, 0, 0.3)
  border: 1px solid var(--game-border)
  border-radius: 10px
  display: grid
  grid-template-columns: 1.4fr 1.6fr
  gap: 16px
  align-items: center
  transition: all 0.2s

  &:hover
    border-color: var(--game-cyan)
    background: rgba(0, 212, 255, 0.04)

  &.phase-sentir
    border-left: 3px solid #6FE36F
  &.phase-imaginar
    border-left: 3px solid #00D4FF
  &.phase-fazer
    border-left: 3px solid #FFC845
  &.phase-compartilhar
    border-left: 3px solid #B86CFF

.quest-head
  display: flex
  align-items: center
  gap: 10px
  min-width: 0
  flex-wrap: wrap

  .code
    font-family: 'Orbitron', sans-serif
    font-size: 11px
    font-weight: 700
    padding: 3px 8px
    border-radius: 4px
    background: rgba(0, 212, 255, 0.12)
    color: var(--game-cyan)
    border: 1px solid var(--game-cyan)

  h3
    margin: 0
    font-size: 14px
    font-weight: 600
    color: var(--game-text)
    flex: 1
    min-width: 0
    overflow: hidden
    text-overflow: ellipsis
    white-space: nowrap

  .template
    font-size: 10px
    color: var(--game-text-dim)
    padding: 2px 8px
    background: rgba(255, 255, 255, 0.04)
    border-radius: 4px

.quest-meta
  display: grid
  grid-template-columns: auto auto auto 1fr
  gap: 14px
  align-items: center

.meta-item
  display: flex
  flex-direction: column

  .meta-key
    font-family: 'Orbitron', sans-serif
    font-size: 9px
    letter-spacing: 1.5px
    color: var(--game-text-dim)

  .meta-val
    font-family: 'Orbitron', sans-serif
    font-size: 12px
    font-weight: 700
    color: var(--game-text)
    margin-top: 2px

  &.progress
    flex-direction: row
    align-items: center
    gap: 8px

    .bar
      flex: 1
      height: 5px
      background: rgba(255, 255, 255, 0.06)
      border-radius: 3px
      overflow: hidden
      border: 1px solid var(--game-border)

    .fill
      height: 100%
      background: linear-gradient(90deg, var(--game-cyan), #56C8FF)
      box-shadow: 0 0 8px var(--game-cyan-glow)

    .pct
      font-family: 'Orbitron', sans-serif
      font-size: 11px
      font-weight: 700
      color: var(--game-cyan)
      min-width: 36px
      text-align: right

/* ===== Activity ===== */
.activity-panel header
  position: relative

.live-dot
  position: relative
  width: 8px
  height: 8px
  border-radius: 50%
  background: #6FE36F
  box-shadow: 0 0 8px rgba(111, 227, 111, 0.6)
  animation: pulse 1.6s ease infinite

@keyframes pulse
  0%, 100%
    opacity: 1
  50%
    opacity: 0.4

.activity-list
  list-style: none
  margin: 0
  padding: 0
  display: flex
  flex-direction: column
  gap: 12px

  li
    display: grid
    grid-template-columns: 28px 1fr
    gap: 10px
    align-items: start

.act-icon
  width: 28px
  height: 28px
  border-radius: 6px
  background: rgba(0, 0, 0, 0.4)
  border: 1px solid var(--game-border)
  display: flex
  align-items: center
  justify-content: center
  color: var(--game-cyan)

.activity-submission .act-icon
  border-color: var(--game-cyan)
  color: var(--game-cyan)

.activity-claim .act-icon
  border-color: var(--game-orange)
  color: var(--game-orange)

.activity-phase .act-icon
  border-color: var(--game-green)
  color: var(--game-green)

.activity-level .act-icon
  border-color: var(--game-gold)
  color: var(--game-gold)

.act-content
  min-width: 0

  p
    margin: 0
    font-size: 13px
    color: var(--game-text)
    line-height: 1.4

    strong
      font-weight: 700

    .target
      color: var(--game-text-dim)
      font-style: italic

  time
    display: block
    margin-top: 2px
    font-size: 10px
    color: var(--game-text-dim)
    font-family: 'Orbitron', sans-serif
    letter-spacing: 0.5px

/* ===== Students table ===== */
.student-table
  width: 100%
  border-collapse: collapse
  font-family: 'Rajdhani', 'Inter', sans-serif

  th
    text-align: left
    padding: 10px 12px
    font-family: 'Orbitron', sans-serif
    font-size: 10px
    letter-spacing: 1.5px
    color: var(--game-text-dim)
    border-bottom: 1px solid var(--game-border)
    font-weight: 600

  td
    padding: 12px
    border-bottom: 1px solid rgba(255, 255, 255, 0.04)
    color: var(--game-text)
    font-size: 13px
    vertical-align: middle

  tbody tr
    cursor: pointer
    transition: background 0.15s

    &:hover
      background: rgba(0, 212, 255, 0.04)

.aluno-cell
  display: flex
  align-items: center
  gap: 10px

  img
    width: 32px
    height: 32px
    border-radius: 50%
    border: 1.5px solid var(--game-border)
    object-fit: cover

  div
    display: flex
    flex-direction: column

  strong
    font-size: 13px
    color: var(--game-text)
    font-weight: 600

  span
    font-size: 11px
    color: var(--game-text-dim)

.profile-pill
  display: inline-block
  padding: 3px 10px
  background: rgba(0, 0, 0, 0.4)
  border: 1px solid var(--c)
  border-radius: 999px
  font-family: 'Orbitron', sans-serif
  font-size: 10px
  font-weight: 700
  color: var(--c)
  text-shadow: 0 0 4px var(--c)
  letter-spacing: 0.5px

.num
  font-family: 'Orbitron', sans-serif
  font-weight: 700

.xp
  color: var(--game-gold)
  text-shadow: 0 0 4px rgba(255, 200, 69, 0.3)

td small
  display: block
  font-size: 10px
  color: var(--game-text-dim)
  margin-top: 2px

.activity-bar
  display: flex
  align-items: center
  gap: 8px

  .ab-fill
    flex: 1
    height: 5px
    background: linear-gradient(90deg, var(--game-cyan), var(--game-green))
    border-radius: 3px
    box-shadow: 0 0 6px var(--game-cyan-glow)
    max-width: 100px

  span
    font-family: 'Orbitron', sans-serif
    font-size: 11px
    font-weight: 700
    color: var(--game-text)

.status-pill
  padding: 3px 10px
  border-radius: 999px
  font-family: 'Orbitron', sans-serif
  font-size: 9px
  font-weight: 700
  letter-spacing: 1px

  &.active
    background: rgba(111, 227, 111, 0.15)
    border: 1px solid var(--game-green)
    color: var(--game-green)

  &.idle
    background: rgba(255, 200, 69, 0.12)
    border: 1px solid var(--game-gold)
    color: var(--game-gold)

@media screen and (max-width: 1400px)
  .stats-grid
    grid-template-columns: repeat(3, 1fr)

  .two-cols
    grid-template-columns: 1fr

@media screen and (max-width: 1100px)
  .admin-page
    grid-template-columns: 1fr

  .stats-grid
    grid-template-columns: repeat(2, 1fr)

  .student-table
    font-size: 12px
</style>
