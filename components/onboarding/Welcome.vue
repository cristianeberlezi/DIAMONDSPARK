<template>
  <div class="welcome">
    <!-- Coluna esquerda: 5 personagens com falas -->
    <aside class="char-rail">
      <div v-for="(c, i) in characters" :key="c.letter" class="char-row" :style="{ '--c': c.color, '--cg': c.glow, '--delay': `${i * 0.12}s` }">
        <div class="face">
          <img :src="c.image" :alt="c.name" @error="onImgError" />
          <span class="letter">{{ c.letter }}</span>
        </div>
        <div class="bubble">
          <p class="speech">"{{ c.speech }}"</p>
          <span class="who">{{ c.name }} <span class="dot">·</span> {{ c.role }}</span>
        </div>
      </div>
    </aside>

    <!-- Centro: título -->
    <div class="center-block">
      <span class="badge">PERFIS HOLLAND <span class="amp">×</span> INTELIGÊNCIAS MÚLTIPLAS</span>
      <h1>
        VAMOS DESCOBRIR<br>
        <span class="hl">SEU PERFIL</span><br>
        E SUAS HABILIDADES
      </h1>
      <p class="sub">Responda 7 perguntas rápidas e descubra qual personagem é a sua versão no mundo digital.</p>
    </div>

    <!-- Canto inferior direito: botão -->
    <div class="cta-wrap">
      <button class="start-btn" @click="$emit('start')">
        <span>COMEÇAR JORNADA</span>
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="13 17 18 12 13 7"/>
          <polyline points="6 17 11 12 6 7"/>
        </svg>
      </button>
      <p class="hint">7 perguntas · cerca de 2 minutos</p>
    </div>
  </div>
</template>

<script setup>
defineEmits(['start'])

function onImgError(e) {
  if (!e.target.src.endsWith('/images/avatar.png')) {
    e.target.src = '/images/avatar.png'
  }
}

const characters = [
  {
    letter: 'R',
    name: 'REALISTA',
    role: 'O CONSTRUTOR',
    color: '#56C8FF',
    glow: 'rgba(86, 200, 255, 0.55)',
    image: '/images/P01.png',
    speech: 'Se quebrou, eu conserto. Se não existe, eu construo.'
  },
  {
    letter: 'I',
    name: 'INVESTIGATIVO',
    role: 'O PESQUISADOR',
    color: '#B86CFF',
    glow: 'rgba(184, 108, 255, 0.55)',
    image: '/images/P02.png',
    speech: 'Cada dado guarda uma resposta. Eu vou encontrá-la.'
  },
  {
    letter: 'A',
    name: 'ARTÍSTICO',
    role: 'O CRIADOR',
    color: '#E94B8C',
    glow: 'rgba(233, 75, 140, 0.55)',
    image: '/images/P03.png',
    speech: 'Vejo o que ninguém viu. Crio o que ninguém imaginou.'
  },
  {
    letter: 'S',
    name: 'SOCIAL',
    role: 'O CONECTOR',
    color: '#6FE36F',
    glow: 'rgba(111, 227, 111, 0.55)',
    image: '/images/P04.png',
    speech: 'Pessoas no centro. Sempre. O futuro é coletivo.'
  },
  {
    letter: 'E',
    name: 'EMPREENDEDOR',
    role: 'O INOVADOR',
    color: '#FFC845',
    glow: 'rgba(255, 200, 69, 0.55)',
    image: '/images/P05.png',
    speech: 'Onde os outros veem risco, eu vejo oportunidade.'
  },
  {
    letter: 'C',
    name: 'CONVENCIONAL',
    role: 'O ORGANIZADOR',
    color: '#7AB8FF',
    glow: 'rgba(122, 184, 255, 0.55)',
    image: '/images/P06.png',
    speech: 'Ordem, processo e precisão. É assim que se constrói.'
  }
]
</script>

<style lang="sass" scoped>
.welcome
  position: relative
  width: 100%
  height: 100%
  display: grid
  grid-template-columns: 540px 1fr
  grid-template-rows: 1fr auto
  gap: 40px
  padding: 20px 48px
  align-items: center

/* ===== Personagens à esquerda ===== */
.char-rail
  grid-column: 1
  grid-row: 1 / 3
  display: flex
  flex-direction: column
  gap: 14px
  justify-content: center
  align-self: stretch
  padding: 8px 0

.char-row
  display: grid
  grid-template-columns: 110px 1fr
  gap: 16px
  align-items: center
  opacity: 0
  transform: translateX(-30px)
  animation: slide-in 0.7s ease forwards
  animation-delay: var(--delay)

@keyframes slide-in
  to
    opacity: 1
    transform: translateX(0)

.face
  position: relative
  width: 110px
  height: 110px
  border-radius: 50%
  background: linear-gradient(135deg, rgba(8, 18, 40, 0.9), rgba(5, 11, 26, 1))
  border: 3px solid var(--c)
  overflow: hidden
  box-shadow: 0 0 24px var(--cg), inset 0 0 12px rgba(255, 255, 255, 0.05)
  flex-shrink: 0

  img
    width: 100%
    height: 100%
    object-fit: cover

  .letter
    position: absolute
    bottom: -3px
    right: -3px
    width: 34px
    height: 34px
    border-radius: 50%
    background: var(--game-bg)
    border: 3px solid var(--c)
    display: flex
    align-items: center
    justify-content: center
    font-family: 'Orbitron', sans-serif
    font-size: 14px
    font-weight: 800
    color: var(--c)
    text-shadow: 0 0 8px var(--cg)
    box-shadow: 0 0 10px var(--cg)

.bubble
  position: relative
  padding: 14px 18px
  background: rgba(8, 18, 40, 0.7)
  border: 1px solid var(--c)
  border-radius: 14px
  backdrop-filter: blur(8px)
  box-shadow: 0 0 16px var(--cg)

  &::before
    content: ''
    position: absolute
    left: -8px
    top: 50%
    margin-top: -7px
    width: 14px
    height: 14px
    background: rgba(8, 18, 40, 0.7)
    border-left: 1px solid var(--c)
    border-bottom: 1px solid var(--c)
    transform: rotate(45deg)

  .speech
    margin: 0 0 6px
    color: var(--game-text)
    font-size: 14px
    line-height: 1.4
    font-style: italic
    font-family: 'Rajdhani', 'Inter', sans-serif

  .who
    display: block
    font-family: 'Orbitron', sans-serif
    font-size: 11px
    letter-spacing: 1.5px
    color: var(--c)
    text-shadow: 0 0 6px var(--cg)

    .dot
      opacity: 0.5
      margin: 0 4px

/* ===== Centro ===== */
.center-block
  grid-column: 2
  grid-row: 1
  display: flex
  flex-direction: column
  align-items: flex-end
  text-align: right
  gap: 20px

.badge
  display: inline-block
  font-family: 'Orbitron', sans-serif
  font-size: 11px
  letter-spacing: 3px
  color: var(--game-cyan)
  padding: 7px 16px
  border: 1px solid var(--game-cyan)
  border-radius: 999px
  text-shadow: 0 0 6px var(--game-cyan-glow)

  .amp
    margin: 0 4px
    opacity: 0.6

h1
  margin: 0
  font-family: 'Orbitron', sans-serif
  font-weight: 800
  font-size: 52px
  line-height: 1.05
  letter-spacing: 2px
  color: var(--game-text)
  text-shadow: 0 0 18px var(--game-cyan-glow)

  .hl
    color: var(--game-cyan)
    text-shadow: 0 0 22px var(--game-cyan-glow)

.sub
  margin: 0
  max-width: 520px
  color: var(--game-text-dim)
  font-size: 15px
  line-height: 1.5
  font-family: 'Rajdhani', 'Inter', sans-serif

/* ===== Botão canto inferior direito ===== */
.cta-wrap
  grid-column: 2
  grid-row: 2
  display: flex
  flex-direction: column
  align-items: flex-end
  gap: 8px

.start-btn
  display: inline-flex
  align-items: center
  justify-content: center
  gap: 14px
  padding: 18px 42px
  background: linear-gradient(180deg, rgba(0, 130, 200, 0.55), rgba(0, 80, 150, 0.75))
  border: 1px solid var(--game-cyan)
  border-radius: 10px
  color: var(--game-cyan)
  font-family: 'Orbitron', sans-serif
  font-weight: 700
  font-size: 15px
  letter-spacing: 2.5px
  cursor: pointer
  text-shadow: 0 0 8px var(--game-cyan-glow)
  box-shadow: 0 0 28px rgba(0, 212, 255, 0.35), inset 0 0 14px rgba(0, 212, 255, 0.15)
  transition: all 0.2s

  &:hover
    background: linear-gradient(180deg, rgba(0, 170, 240, 0.7), rgba(0, 110, 180, 0.9))
    box-shadow: 0 0 40px rgba(0, 212, 255, 0.6), inset 0 0 22px rgba(0, 212, 255, 0.25)
    transform: translateY(-1px)

.hint
  margin: 0
  font-size: 11px
  color: var(--game-text-dim)
  letter-spacing: 1px
  font-family: 'Rajdhani', 'Inter', sans-serif

@media screen and (max-width: 1100px)
  .welcome
    grid-template-columns: 1fr
    grid-template-rows: auto auto auto
    padding: 24px

  .char-rail
    grid-column: 1
    grid-row: 1

  .center-block
    grid-column: 1
    grid-row: 2
    align-items: flex-start
    text-align: left

  .cta-wrap
    grid-column: 1
    grid-row: 3
    align-items: stretch

  h1
    font-size: 32px
</style>
