<template>
  <aside class="mission-panel">
    <div class="panel mission">
      <div class="panel-head">MISSÃO ATUAL</div>
      <div class="mission-title">
        <span class="code">1-1</span>
        <span class="name">PRIMEIRO PASSO</span>
      </div>
      <p class="desc">
        Todo grande projeto começa<br>com uma primeira ação.
      </p>
      <p class="desc dim">
        Conclua todas as tarefas<br>para desbloquear o próximo nó.
      </p>
      <div class="progress">
        <div class="bar">
          <div class="fill" style="width: 66%"></div>
        </div>
        <span class="frac">2 / 3</span>
      </div>
    </div>

    <div class="panel tasks">
      <div class="panel-head">TAREFAS</div>
      <ul>
        <li v-for="t in tarefas" :key="t.id" :class="{ done: t.done }">
          <span class="diamond" :class="t.done ? 'done' : 'pending'">
            <svg v-if="t.done" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#6FE36F" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
              <polyline points="20 6 9 17 4 12"/>
            </svg>
          </span>
          <span class="text">{{ t.text }}</span>
          <span class="count" :class="{ done: t.done }">{{ t.count }}</span>
          <span class="check" :class="{ done: t.done }">
            <svg v-if="t.done" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#6FE36F" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
              <circle cx="12" cy="12" r="10"/>
              <polyline points="16 9 11 14 8 11"/>
            </svg>
            <svg v-else width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#8AA3CC" stroke-width="1.5">
              <circle cx="12" cy="12" r="10"/>
            </svg>
          </span>
        </li>
      </ul>
    </div>

    <div class="panel rewards">
      <div class="panel-head">RECOMPENSAS</div>
      <div class="rew-grid">
        <div class="rew">
          <div class="rew-icon xp">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="#56C8FF">
              <path d="M3 12 L12 3 L21 12 L12 21 Z"/>
            </svg>
            <span class="xp-label">XP</span>
          </div>
          <span class="rew-val">500 XP</span>
        </div>
        <div class="rew">
          <div class="rew-icon coin">
            <svg width="26" height="26" viewBox="0 0 24 24">
              <circle cx="12" cy="12" r="10" fill="#FFB300" stroke="#FF8A3D" stroke-width="1.5"/>
              <text x="12" y="16" text-anchor="middle" font-size="11" font-weight="700" fill="#7A4500" font-family="Orbitron">B</text>
            </svg>
          </div>
          <span class="rew-val">1.000</span>
        </div>
        <div class="rew">
          <div class="rew-icon gem">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="#56C8FF">
              <path d="M6 3h12l4 6-10 12L2 9z"/>
            </svg>
          </div>
          <span class="rew-val">10</span>
        </div>
      </div>
    </div>

  </aside>
</template>

<script setup>
const tarefas = [
  { id: 1, text: 'Completar 1 lição sobre\nfundamentos de IA', count: '1/1', done: true },
  { id: 2, text: 'Resolver 3 desafios\nde lógica', count: '2/3', done: false },
  { id: 3, text: 'Assistir à palestra:\nO futuro da tecnologia', count: '0/1', done: false }
]
</script>

<style lang="sass" scoped>
.mission-panel
  width: 100%
  display: flex
  flex-direction: column
  gap: 14px
  font-family: 'Rajdhani', 'Inter', sans-serif

.panel
  background: var(--game-panel)
  border: 1px solid var(--game-border)
  border-radius: 8px
  padding: 14px 16px
  backdrop-filter: blur(10px)
  position: relative

.panel-head
  font-family: 'Orbitron', sans-serif
  color: var(--game-text-dim)
  font-size: 11px
  font-weight: 600
  letter-spacing: 2px
  text-align: center
  margin-bottom: 10px

.mission-title
  display: flex
  align-items: baseline
  gap: 10px
  margin-bottom: 8px
  font-family: 'Orbitron', sans-serif

  .code
    color: var(--game-cyan)
    font-size: 22px
    font-weight: 700
    text-shadow: 0 0 8px var(--game-cyan-glow)

  .name
    color: var(--game-text)
    font-size: 16px
    font-weight: 700
    letter-spacing: 1px

.desc
  margin: 0 0 8px
  color: var(--game-text-dim)
  font-size: 12px
  line-height: 1.5

  &.dim
    margin-top: 12px
    color: var(--game-text-dim)
    opacity: 0.8

.progress
  display: flex
  align-items: center
  gap: 10px
  margin-top: 10px

  .bar
    flex: 1
    height: 5px
    background: rgba(255, 255, 255, 0.06)
    border-radius: 3px
    overflow: hidden
    border: 1px solid var(--game-border)

  .fill
    height: 100%
    background: linear-gradient(90deg, #00D4FF, #56C8FF)
    box-shadow: 0 0 8px var(--game-cyan-glow)

  .frac
    font-family: 'Orbitron', sans-serif
    font-size: 11px
    color: var(--game-text)
    font-weight: 600

/* ===== Tasks ===== */
.tasks ul
  list-style: none
  margin: 0
  padding: 0
  display: flex
  flex-direction: column
  gap: 12px

.tasks li
  display: grid
  grid-template-columns: 16px 1fr auto 16px
  align-items: center
  gap: 10px

  .text
    color: var(--game-text)
    font-size: 12px
    line-height: 1.35
    white-space: pre-line

  .count
    font-family: 'Orbitron', sans-serif
    color: var(--game-text-dim)
    font-size: 11px
    font-weight: 600

    &.done
      color: var(--game-green)

.diamond
  width: 14px
  height: 14px
  transform: rotate(45deg)
  display: flex
  align-items: center
  justify-content: center

  &.pending
    border: 1.5px solid var(--game-text-dim)

  &.done
    border: 1.5px solid var(--game-green)
    box-shadow: 0 0 8px var(--game-green-glow)

  svg
    transform: rotate(-45deg)

/* ===== Rewards ===== */
.rew-grid
  display: grid
  grid-template-columns: repeat(3, 1fr)
  gap: 10px

.rew
  display: flex
  flex-direction: column
  align-items: center
  gap: 6px
  padding: 10px 6px
  background: rgba(0, 0, 0, 0.25)
  border: 1px solid var(--game-border)
  border-radius: 8px

.rew-icon
  width: 36px
  height: 36px
  display: flex
  align-items: center
  justify-content: center
  position: relative

  &.xp
    .xp-label
      position: absolute
      font-family: 'Orbitron', sans-serif
      font-size: 9px
      font-weight: 800
      color: #003a55

.rew-val
  font-family: 'Orbitron', sans-serif
  font-size: 12px
  font-weight: 700
  color: var(--game-text)

</style>
