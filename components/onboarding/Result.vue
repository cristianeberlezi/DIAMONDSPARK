<template>
  <div class="result" :style="{ '--c': profile.color, '--cg': profile.glow }">
    <!-- Lado esquerdo: imagem do personagem em corpo inteiro -->
    <div class="char-area">
      <div class="char-glow"></div>
      <img class="char-img" src="/images/P01user.png" :alt="profile.name" @error="onImgError" />
      <div class="char-badge">
        <span class="letter">{{ profile.letter }}</span>
      </div>
    </div>

    <!-- Lado direito: textos -->
    <div class="info-area">
      <div class="match-pill">
        <span class="label">COMPATIBILIDADE</span>
        <span class="pct">{{ compatibility }}%</span>
      </div>

      <span class="intro">SEU PERSONAGEM É</span>

      <h1>
        <span class="name">{{ profile.name }}</span>
        <span class="role">{{ profile.role }}</span>
      </h1>

      <p class="mission">{{ profile.mission }}</p>

      <div class="two-cols">
        <div class="block">
          <span class="key">ÁREAS DE ATUAÇÃO</span>
          <ul>
            <li v-for="a in profile.areas" :key="a">{{ a }}</li>
          </ul>
        </div>
        <div class="block">
          <span class="key">SKILLS COMPATÍVEIS</span>
          <ul>
            <li v-for="s in profile.skills" :key="s">{{ s }}</li>
          </ul>
        </div>
      </div>
    </div>

    <!-- Canto inferior direito: ações -->
    <div class="cta-wrap">
      <button class="btn-secondary" @click="$emit('redo')">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="1 4 1 10 7 10"/>
          <path d="M3.51 15a9 9 0 1 0 2.13-9.36L1 10"/>
        </svg>
        REFAZER
      </button>
      <button class="btn-primary" @click="$emit('accept')">
        <span>INICIAR JORNADA</span>
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="13 17 18 12 13 7"/>
          <polyline points="6 17 11 12 6 7"/>
        </svg>
      </button>
    </div>
  </div>
</template>

<script setup>
defineProps({
  profile: { type: Object, required: true },
  compatibility: { type: Number, default: 92 }
})

defineEmits(['accept', 'redo'])

function onImgError(e) {
  if (!e.target.src.endsWith('/images/avatar.png')) {
    e.target.src = '/images/avatar.png'
  }
}
</script>

<style lang="sass" scoped>
.result
  position: relative
  width: 100%
  height: 100%
  display: grid
  grid-template-columns: 1.1fr 1fr
  grid-template-rows: 1fr auto
  gap: 40px
  padding: 32px 56px
  align-items: center
  animation: fade-in 0.7s ease

@keyframes fade-in
  from
    opacity: 0
    transform: scale(0.98)
  to
    opacity: 1
    transform: scale(1)

/* ===== Imagem do personagem ===== */
.char-area
  position: relative
  grid-column: 1
  grid-row: 1 / 3
  align-self: stretch
  display: flex
  align-items: flex-end
  justify-content: center
  overflow: hidden
  margin: -32px 0 -32px -56px

.char-glow
  position: absolute
  left: 0
  right: 0
  bottom: 0
  height: 70%
  background: radial-gradient(ellipse at 50% 90%, var(--cg), transparent 65%)
  filter: blur(50px)
  z-index: 0
  animation: pulse-glow 4s ease-in-out infinite
  pointer-events: none

@keyframes pulse-glow
  0%, 100%
    opacity: 0.7
    transform: scale(1)
  50%
    opacity: 1
    transform: scale(1.05)

.char-img
  position: relative
  z-index: 1
  max-width: 100%
  width: auto
  height: 100%
  max-height: 100%
  object-fit: contain
  object-position: center bottom
  margin-bottom: -170px
  mask-image: radial-gradient(ellipse 75% 85% at 50% 75%, black 55%, rgba(0,0,0,0.85) 70%, transparent 100%)
  -webkit-mask-image: radial-gradient(ellipse 75% 85% at 50% 75%, black 55%, rgba(0,0,0,0.85) 70%, transparent 100%)
  filter: drop-shadow(0 -8px 22px var(--cg))
  animation: char-enter 0.9s ease

@keyframes char-enter
  from
    opacity: 0
    transform: translateY(30px) scale(0.97)
  to
    opacity: 1
    transform: translateY(0) scale(1)

.char-badge
  position: absolute
  top: 32px
  left: 32px
  z-index: 2
  width: 64px
  height: 64px
  border-radius: 50%
  background: linear-gradient(135deg, rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.9))
  border: 2.5px solid var(--c)
  display: flex
  align-items: center
  justify-content: center
  box-shadow: 0 0 22px var(--cg), inset 0 0 12px rgba(255, 255, 255, 0.06)
  backdrop-filter: blur(6px)

  .letter
    font-family: 'Orbitron', sans-serif
    font-size: 30px
    font-weight: 800
    color: var(--c)
    text-shadow: 0 0 12px var(--cg)

/* ===== Lado direito ===== */
.info-area
  grid-column: 2
  grid-row: 1
  display: flex
  flex-direction: column
  align-items: flex-end
  text-align: right
  gap: 18px
  max-width: 620px
  margin-left: auto

.match-pill
  display: inline-flex
  align-items: center
  gap: 10px
  padding: 8px 18px
  background: rgba(0, 0, 0, 0.45)
  border: 1px solid var(--c)
  border-radius: 999px
  box-shadow: 0 0 14px var(--cg)

  .label
    font-family: 'Orbitron', sans-serif
    font-size: 10px
    letter-spacing: 2px
    color: var(--game-text-dim)

  .pct
    font-family: 'Orbitron', sans-serif
    font-size: 18px
    font-weight: 800
    color: var(--c)
    text-shadow: 0 0 10px var(--cg)

.intro
  font-family: 'Orbitron', sans-serif
  font-size: 12px
  letter-spacing: 3.5px
  color: var(--game-text-dim)
  font-weight: 600

h1
  margin: 0
  display: flex
  flex-direction: column
  align-items: flex-end
  line-height: 1.05
  font-family: 'Orbitron', sans-serif

  .name
    font-size: 56px
    font-weight: 800
    letter-spacing: 2px
    color: var(--game-text)
    text-shadow: 0 0 22px var(--cg)

  .role
    margin-top: 8px
    font-size: 18px
    font-weight: 700
    letter-spacing: 3px
    color: var(--c)
    text-shadow: 0 0 12px var(--cg)

.mission
  margin: 6px 0 0
  max-width: 520px
  color: var(--game-text)
  font-size: 16px
  line-height: 1.5
  font-family: 'Rajdhani', 'Inter', sans-serif

.two-cols
  display: grid
  grid-template-columns: 1fr 1fr
  gap: 28px
  width: 100%
  max-width: 520px
  margin-top: 8px

.block
  text-align: right

  .key
    display: block
    font-family: 'Orbitron', sans-serif
    font-size: 11px
    letter-spacing: 2px
    color: var(--game-text-dim)
    margin-bottom: 8px

  ul
    list-style: none
    margin: 0
    padding: 0
    display: flex
    flex-direction: column
    gap: 5px

    li
      position: relative
      padding-right: 14px
      color: var(--game-text)
      font-size: 14px
      line-height: 1.4
      font-family: 'Rajdhani', 'Inter', sans-serif

      &::after
        content: '◆'
        position: absolute
        right: 0
        top: 0
        color: var(--c)
        font-size: 8px

/* ===== Botões canto inferior direito ===== */
.cta-wrap
  grid-column: 2
  grid-row: 2
  display: flex
  align-items: center
  justify-content: flex-end
  gap: 12px

.btn-secondary
  display: inline-flex
  align-items: center
  gap: 10px
  padding: 16px 26px
  background: transparent
  border: 1px solid var(--game-border)
  border-radius: 10px
  color: var(--game-text-dim)
  font-family: 'Orbitron', sans-serif
  font-size: 12px
  font-weight: 700
  letter-spacing: 1.8px
  cursor: pointer
  transition: all 0.2s

  &:hover
    border-color: var(--game-text)
    color: var(--game-text)

.btn-primary
  display: inline-flex
  align-items: center
  justify-content: center
  gap: 14px
  padding: 18px 44px
  background: linear-gradient(180deg, rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.55))
  border: 1px solid var(--c)
  border-radius: 10px
  color: var(--c)
  font-family: 'Orbitron', sans-serif
  font-size: 15px
  font-weight: 700
  letter-spacing: 2.5px
  cursor: pointer
  text-shadow: 0 0 10px var(--cg)
  box-shadow: 0 0 28px var(--cg), inset 0 0 14px rgba(255, 255, 255, 0.06)
  transition: all 0.2s

  &:hover
    transform: translateY(-2px)
    box-shadow: 0 0 42px var(--cg), inset 0 0 22px rgba(255, 255, 255, 0.1)

@media screen and (max-width: 1100px)
  .result
    grid-template-columns: 1fr
    grid-template-rows: 1fr auto auto
    padding: 24px
    gap: 24px

  .char-area
    grid-column: 1
    grid-row: 1
    height: 280px

  .info-area
    grid-column: 1
    grid-row: 2
    align-items: flex-start
    text-align: left
    margin-left: 0

  .block
    text-align: left

    li
      padding-right: 0
      padding-left: 14px

      &::after
        right: auto
        left: 0

  .cta-wrap
    grid-column: 1
    grid-row: 3

  h1 .name
    font-size: 36px
</style>
