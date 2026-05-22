<template>
  <div class="quest-page">
    <video class="bg-video" autoplay muted loop playsinline>
      <source src="/videos/bg.mp4" type="video/mp4" />
    </video>
    <div class="overlay"></div>
    <div class="overlay-grid"></div>

    <div class="content">
      <button class="back" @click="router.push('/game')">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="15 18 9 12 15 6"/>
        </svg>
        <span>VOLTAR AO MAPA</span>
      </button>

      <GameQuestHeader :quest="quest" />

      <div class="layout">
        <main class="phases-area">
          <article
            v-for="phase in quest.phases"
            :key="phase.key"
            :class="['phase-block', `status-${phase.status}`]"
            :style="{ '--c': phase.color, '--cg': phase.glow }"
          >
            <header class="phase-header" @click="togglePhase(phase)">
              <div class="phase-marker">
                <span v-if="phase.status === 'done'" class="check">
                  <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
                    <polyline points="20 6 9 17 4 12"/>
                  </svg>
                </span>
                <span v-else-if="phase.status === 'locked'" class="lock">
                  <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <rect x="3" y="11" width="18" height="11" rx="2"/>
                    <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
                  </svg>
                </span>
                <span v-else class="dot"></span>
              </div>

              <div class="phase-title-block">
                <span class="phase-label">FASE {{ getPhaseIndex(phase) + 1 }} · {{ phase.days }} DIAS</span>
                <h2>{{ phase.title }}</h2>
                <p class="phase-subtitle">{{ phase.subtitle }}</p>
              </div>

              <div class="phase-status-block">
                <span v-if="phase.status === 'active'" class="status-pill active">EM ANDAMENTO</span>
                <span v-else-if="phase.status === 'done'" class="status-pill done">CONCLUÍDA</span>
                <span v-else class="status-pill locked">BLOQUEADA</span>
                <button class="collapse-btn">
                  <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <polyline v-if="openPhases.includes(phase.key)" points="18 15 12 9 6 15"/>
                    <polyline v-else points="6 9 12 15 18 9"/>
                  </svg>
                </button>
              </div>
            </header>

            <div v-show="openPhases.includes(phase.key)" class="phase-body">
              <!-- Sub-tarefas individuais -->
              <section class="individual">
                <div class="section-title">
                  <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
                    <circle cx="12" cy="7" r="4"/>
                  </svg>
                  <h3>SUB-TAREFAS INDIVIDUAIS</h3>
                  <span class="hint">cada aluno pega 1</span>
                </div>

                <div class="task-grid">
                  <GameSubTaskCard
                    v-for="t in phase.individualTasks"
                    :key="t.id"
                    :task="t"
                    :phase-color="phase.color"
                    :phase-glow="phase.glow"
                    @claim="claim(t, phase)"
                    @submit="goSubmit(t, phase)"
                  />
                </div>
              </section>

              <!-- Tarefa coletiva -->
              <section class="collective-section">
                <GameCollectiveCard
                  :task="phase.collectiveTask"
                  :phase-color="phase.color"
                  :phase-glow="phase.glow"
                  @join="joinCollective(phase.collectiveTask, phase)"
                />
              </section>

              <!-- Entregável -->
              <section class="deliverable-section">
                <GameDeliverableCard
                  :deliverable="phase.deliverable"
                  :phase-color="phase.color"
                  :phase-glow="phase.glow"
                  :locked="phase.status === 'locked'"
                />
              </section>
            </div>
          </article>
        </main>

        <aside class="guild-col">
          <div class="legend">
            <span><i class="dot open"></i>Disponível</span>
            <span><i class="dot mine"></i>Você</span>
            <span><i class="dot claimed"></i>Progresso</span>
            <span><i class="dot done"></i>Concluída</span>
          </div>
          <GameTeamPanel :team="guild" />
        </aside>
      </div>
    </div>
  </div>
</template>

<script setup>
import { quest as questData, guild as guildData } from '~/components/game/questData.js'

definePageMeta({ layout: 'default' })

const route = useRoute()
const router = useRouter()

useHead({ title: () => `Quest ${questData.code} — ${questData.title}` })

const quest = ref(questData)
const guild = ref(guildData)

// Por padrão, abre só a fase atual
const openPhases = ref([quest.value.currentPhase])

function getPhaseIndex(phase) {
  return quest.value.phases.findIndex(p => p.key === phase.key)
}

function togglePhase(phase) {
  if (phase.status === 'locked') return
  const i = openPhases.value.indexOf(phase.key)
  if (i >= 0) openPhases.value.splice(i, 1)
  else openPhases.value.push(phase.key)
}

function claim(task, phase) {
  if (phase.status !== 'active') return
  task.status = 'mine'
  task.assignee = 'Você'
  router.push(`/no/${quest.value.id}/tarefa/${task.id}`)
}

function goSubmit(task, phase) {
  if (phase.status !== 'active') return
  router.push(`/no/${quest.value.id}/tarefa/${task.id}`)
}

function joinCollective(task, phase) {
  if (phase.status !== 'active') return
  console.log('Joining collective:', task.id)
}
</script>

<style lang="sass" scoped>
.quest-page
  position: relative
  min-height: 100vh
  background: var(--game-bg)
  color: var(--game-text)
  font-family: 'Rajdhani', 'Inter', sans-serif

.bg-video
  position: fixed
  inset: 0
  width: 100%
  height: 100%
  object-fit: cover
  z-index: 0

.overlay
  position: fixed
  inset: 0
  background: radial-gradient(ellipse at center, rgba(5, 11, 26, 0.78) 0%, rgba(5, 11, 26, 0.95) 100%)
  z-index: 1

.overlay-grid
  position: fixed
  inset: 0
  background-image: linear-gradient(rgba(0, 212, 255, 0.03) 1px, transparent 1px), linear-gradient(90deg, rgba(0, 212, 255, 0.03) 1px, transparent 1px)
  background-size: 60px 60px
  z-index: 2
  pointer-events: none

.content
  position: relative
  z-index: 3
  padding: 20px 40px 32px
  display: flex
  flex-direction: column
  gap: 16px

.back
  align-self: flex-start
  display: inline-flex
  align-items: center
  gap: 8px
  background: transparent
  border: none
  color: var(--game-text-dim)
  font-family: 'Orbitron', sans-serif
  font-size: 11px
  font-weight: 600
  letter-spacing: 1.5px
  cursor: pointer
  transition: color 0.2s

  &:hover
    color: var(--game-cyan)

.layout
  display: grid
  grid-template-columns: 1fr 320px
  gap: 20px
  align-items: start

.phases-area
  display: flex
  flex-direction: column
  gap: 14px

/* ===== Phase block ===== */
.phase-block
  background: rgba(8, 18, 40, 0.55)
  border: 1px solid var(--game-border)
  border-radius: 12px
  backdrop-filter: blur(8px)
  overflow: hidden
  transition: border-color 0.2s, box-shadow 0.2s

  &.status-active
    border-color: var(--c)
    box-shadow: 0 0 18px var(--cg)

  &.status-done
    border-color: var(--c)
    opacity: 0.85

  &.status-locked
    opacity: 0.55

.phase-header
  display: grid
  grid-template-columns: 40px 1fr auto
  align-items: center
  gap: 16px
  padding: 16px 20px
  cursor: pointer
  transition: background 0.2s

  &:hover
    background: rgba(255, 255, 255, 0.02)

.phase-marker
  width: 36px
  height: 36px
  border-radius: 50%
  background: rgba(0, 0, 0, 0.4)
  border: 2px solid var(--c)
  display: flex
  align-items: center
  justify-content: center
  color: var(--c)
  box-shadow: 0 0 12px var(--cg)

.phase-block.status-locked .phase-marker
  border-color: var(--game-border)
  color: var(--game-text-dim)
  box-shadow: none

.phase-block.status-done .phase-marker
  background: var(--c)
  color: #001a33

  .check
    color: #001a33

.dot
  width: 10px
  height: 10px
  border-radius: 50%
  background: var(--c)
  box-shadow: 0 0 8px var(--cg)
  animation: pulse 1.6s ease infinite

@keyframes pulse
  0%, 100%
    opacity: 1
  50%
    opacity: 0.4

.phase-title-block
  min-width: 0

.phase-label
  display: block
  font-family: 'Orbitron', sans-serif
  font-size: 10px
  letter-spacing: 2px
  color: var(--c)
  text-shadow: 0 0 6px var(--cg)
  margin-bottom: 4px

.phase-block.status-locked .phase-label
  color: var(--game-text-dim)
  text-shadow: none

h2
  margin: 0
  font-family: 'Orbitron', sans-serif
  font-size: 20px
  font-weight: 800
  letter-spacing: 1.5px
  color: var(--game-text)

.phase-subtitle
  margin: 2px 0 0
  color: var(--game-text-dim)
  font-size: 13px

.phase-status-block
  display: flex
  align-items: center
  gap: 10px

.status-pill
  padding: 5px 12px
  border-radius: 999px
  font-family: 'Orbitron', sans-serif
  font-size: 9px
  font-weight: 700
  letter-spacing: 1.5px

  &.active
    background: rgba(0, 0, 0, 0.4)
    border: 1px solid var(--c)
    color: var(--c)
    text-shadow: 0 0 4px var(--cg)

  &.done
    background: rgba(111, 227, 111, 0.15)
    border: 1px solid var(--game-green)
    color: var(--game-green)

  &.locked
    background: rgba(0, 0, 0, 0.4)
    border: 1px solid var(--game-border)
    color: var(--game-text-dim)

.collapse-btn
  width: 28px
  height: 28px
  background: rgba(0, 0, 0, 0.4)
  border: 1px solid var(--game-border)
  border-radius: 6px
  color: var(--game-text-dim)
  cursor: pointer
  display: flex
  align-items: center
  justify-content: center

  &:hover
    border-color: var(--c)
    color: var(--c)

/* ===== Phase body ===== */
.phase-body
  padding: 0 20px 20px
  display: flex
  flex-direction: column
  gap: 16px

.section-title
  display: flex
  align-items: center
  gap: 8px
  margin-bottom: 10px
  color: var(--c)

  h3
    margin: 0
    font-family: 'Orbitron', sans-serif
    font-size: 12px
    font-weight: 700
    letter-spacing: 2px
    color: var(--game-text)

  .hint
    font-size: 11px
    color: var(--game-text-dim)
    font-style: italic

.task-grid
  display: grid
  grid-template-columns: repeat(2, 1fr)
  gap: 10px

/* ===== Guild column ===== */
.guild-col
  display: flex
  flex-direction: column
  gap: 14px
  position: sticky
  top: 20px

.legend
  display: flex
  flex-wrap: wrap
  gap: 10px 14px
  height: 32px
  align-items: center
  font-size: 11px
  color: var(--game-text-dim)

  span
    display: inline-flex
    align-items: center
    gap: 6px

  .dot
    width: 8px
    height: 8px
    border-radius: 50%
    animation: none
    box-shadow: none

    &.open
      background: var(--game-cyan)
      box-shadow: 0 0 6px var(--game-cyan-glow)
    &.mine
      background: var(--game-gold)
    &.claimed
      background: var(--game-orange)
    &.done
      background: var(--game-green)

@media screen and (max-width: 1200px)
  .layout
    grid-template-columns: 1fr

  .task-grid
    grid-template-columns: 1fr
</style>
