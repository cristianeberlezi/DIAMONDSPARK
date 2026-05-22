<template>
  <div class="bottombar">
    <div class="block reward">
      <div class="chest">
        <svg width="46" height="40" viewBox="0 0 48 40" fill="none">
          <rect x="3" y="14" width="42" height="24" rx="2" fill="#8B5E2C" stroke="#FFC845" stroke-width="1.5"/>
          <rect x="3" y="6" width="42" height="12" rx="3" fill="#A8732F" stroke="#FFC845" stroke-width="1.5"/>
          <rect x="20" y="18" width="8" height="10" fill="#FFC845"/>
          <circle cx="24" cy="22" r="1.5" fill="#7A4500"/>
        </svg>
      </div>
      <div class="reward-text">
        <span class="key">PRÓXIMA RECOMPENSA</span>
        <strong>Baú de Conhecimento</strong>
      </div>
      <div class="reward-progress">
        <span class="frac">6 <small>/ 12</small></span>
        <div class="bar"><div class="fill" style="width: 50%"></div></div>
      </div>
    </div>

    <div class="block series">
      <div class="star-icon">
        <svg width="34" height="34" viewBox="0 0 24 24" fill="none" stroke="#56C8FF" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
          <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/>
        </svg>
      </div>
      <div class="series-text">
        <span class="key">SÉRIE DE MISSÕES</span>
        <strong>Construtor de Futuros</strong>
        <span class="step">Etapa 1 de 4</span>
      </div>
    </div>

    <div class="block quote">
      <p>"O futuro pertence àqueles que<br>acreditam na beleza de seus sonhos."</p>
      <span class="author">— Eleanor Roosevelt</span>
    </div>
  </div>
</template>

<style lang="sass" scoped>
.bottombar
  display: grid
  grid-template-columns: 1.2fr 1fr 1.4fr
  gap: 18px
  padding: 12px 28px 18px
  align-items: center
  font-family: 'Rajdhani', 'Inter', sans-serif

.block
  display: flex
  align-items: center
  gap: 14px
  background: var(--game-panel)
  border: 1px solid var(--game-border)
  border-radius: 8px
  padding: 12px 16px
  backdrop-filter: blur(8px)

.reward
  .reward-text
    display: flex
    flex-direction: column
    flex: 1

    .key
      color: var(--game-text-dim)
      font-size: 10px
      letter-spacing: 1.5px
      font-weight: 600

    strong
      color: var(--game-text)
      font-size: 15px
      font-weight: 600

  .reward-progress
    display: flex
    flex-direction: column
    align-items: flex-end
    gap: 6px
    min-width: 120px

    .frac
      font-family: 'Orbitron', sans-serif
      color: var(--game-text)
      font-size: 18px
      font-weight: 700

      small
        color: var(--game-text-dim)
        font-size: 13px

    .bar
      width: 100%
      height: 5px
      background: rgba(255,255,255,0.06)
      border-radius: 3px
      overflow: hidden
      border: 1px solid var(--game-border)

    .fill
      height: 100%
      background: linear-gradient(90deg, #00D4FF, #56C8FF)
      box-shadow: 0 0 8px var(--game-cyan-glow)

.series
  .star-icon
    filter: drop-shadow(0 0 6px var(--game-cyan-glow))

  .series-text
    display: flex
    flex-direction: column
    line-height: 1.3

    .key
      color: var(--game-text-dim)
      font-size: 10px
      letter-spacing: 1.5px
      font-weight: 600

    strong
      color: var(--game-text)
      font-size: 15px
      font-weight: 600

    .step
      color: var(--game-text-dim)
      font-size: 11px

.quote
  flex-direction: column
  align-items: flex-end
  text-align: right
  gap: 4px

  p
    margin: 0
    color: var(--game-text)
    font-size: 13px
    font-style: italic
    line-height: 1.5

  .author
    color: var(--game-text-dim)
    font-size: 11px
</style>
