<template>
  <div class="topbar">
    <div class="resources">
      <div class="res">
        <span class="icon energy">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="#FFC845">
            <path d="M13 2L3 14h7l-1 8 10-12h-7l1-8z"/>
          </svg>
        </span>
        <span class="val">120 <small>/ 120</small></span>
      </div>

      <div class="res">
        <span class="icon coin">
          <svg width="22" height="22" viewBox="0 0 24 24">
            <circle cx="12" cy="12" r="10" fill="#FFB300" stroke="#FF8A3D" stroke-width="1.5"/>
            <text x="12" y="16" text-anchor="middle" font-size="13" font-weight="700" fill="#7A4500" font-family="Orbitron">B</text>
          </svg>
        </span>
        <span class="val">12.450</span>
      </div>

      <div class="res">
        <span class="icon gem">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="#56C8FF">
            <path d="M6 3h12l4 6-10 12L2 9z"/>
            <path d="M6 3h12l4 6-10 12L2 9z" fill="url(#g1)" opacity="0.5"/>
            <defs>
              <linearGradient id="g1" x1="0" y1="0" x2="1" y2="1">
                <stop offset="0" stop-color="#fff" stop-opacity="0.8"/>
                <stop offset="1" stop-color="#fff" stop-opacity="0"/>
              </linearGradient>
            </defs>
          </svg>
        </span>
        <span class="val">350</span>
      </div>
    </div>

  </div>
</template>

<style lang="sass" scoped>
.topbar
  display: flex
  align-items: center
  justify-content: space-between
  padding: 10px 14px
  width: 100%
  background: var(--game-panel)
  border: 1px solid var(--game-border)
  border-radius: 8px
  backdrop-filter: blur(10px)
  z-index: 10

.resources
  display: flex
  gap: 14px
  align-items: center
  width: 100%
  justify-content: space-between

.res
  display: flex
  align-items: center
  gap: 8px

  .icon
    display: flex
    align-items: center
    justify-content: center
    filter: drop-shadow(0 0 4px currentColor)

    &.energy
      color: var(--game-gold)

    &.coin
      color: var(--game-orange-glow)

    &.gem
      color: var(--game-cyan)

  .val
    font-family: 'Orbitron', sans-serif
    font-weight: 700
    font-size: 14px
    color: var(--game-text)
    letter-spacing: 0.3px

    small
      color: var(--game-text-dim)
      font-size: 11px
      font-weight: 500

</style>
