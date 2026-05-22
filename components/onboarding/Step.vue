<template>
  <div class="step" :style="{ '--c': step.color, '--cg': hexToGlow(step.color) }">
    <span class="corner tl"></span>
    <span class="corner tr"></span>
    <span class="corner bl"></span>
    <span class="corner br"></span>

    <header>
      <div class="step-info">
        <span class="step-num">STEP {{ String(index + 1).padStart(2, '0') }} / {{ String(total).padStart(2, '0') }}</span>
        <h2>{{ step.title }}</h2>
        <p>{{ step.description }}</p>
      </div>
      <div class="counter">
        <span class="num">{{ answeredCount }}</span>
        <span class="sep">/</span>
        <span class="total-num">{{ questions.length }}</span>
      </div>
    </header>

    <div class="progress-bar">
      <div class="progress-fill" :style="{ width: `${((index + 1) / total) * 100}%` }"></div>
    </div>

    <p class="instruction">Marque <strong>SIM</strong> nas frases que combinam com você. Pule as que não.</p>

    <ul class="q-list">
      <li v-for="(q, i) in questions" :key="q.id" :class="{ answered: answers[q.id] === true }">
        <span class="num">{{ String(i + 1).padStart(2, '0') }}</span>
        <p class="q-text">{{ q.text }}</p>
        <div class="toggle">
          <button :class="['opt no', { active: answers[q.id] === false }]" @click="setAnswer(q.id, false)">NÃO</button>
          <button :class="['opt yes', { active: answers[q.id] === true }]" @click="setAnswer(q.id, true)">SIM</button>
        </div>
      </li>
    </ul>

    <footer>
      <button v-if="index > 0" class="back-btn" @click="$emit('back')">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="15 18 9 12 15 6"/>
        </svg>
        ANTERIOR
      </button>
      <span v-else></span>

      <span class="hint">{{ answeredCount }} de {{ questions.length }} respondidas</span>

      <button class="next-btn" @click="$emit('next', answers)">
        <span>{{ index === total - 1 ? 'CONCLUIR' : 'PRÓXIMO STEP' }}</span>
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="9 18 15 12 9 6"/>
        </svg>
      </button>
    </footer>
  </div>
</template>

<script setup>
const props = defineProps({
  step: { type: Object, required: true },
  questions: { type: Array, required: true },
  index: { type: Number, required: true },
  total: { type: Number, required: true },
  initialAnswers: { type: Object, default: () => ({}) }
})

defineEmits(['next', 'back'])

const answers = ref({ ...props.initialAnswers })

const answeredCount = computed(() =>
  Object.values(answers.value).filter(v => v === true).length
)

function setAnswer(questionId, value) {
  answers.value = { ...answers.value, [questionId]: value }
}

function hexToGlow(hex) {
  // converte #RRGGBB pra rgba semi-transparente
  const h = (hex || '#00D4FF').replace('#', '')
  const r = parseInt(h.substring(0, 2), 16)
  const g = parseInt(h.substring(2, 4), 16)
  const b = parseInt(h.substring(4, 6), 16)
  return `rgba(${r}, ${g}, ${b}, 0.5)`
}
</script>

<style lang="sass" scoped>
.step
  position: relative
  width: 760px
  max-width: calc(100vw - 32px)
  max-height: calc(100vh - 64px)
  padding: 28px 36px
  background: rgba(8, 18, 40, 0.78)
  border: 1px solid var(--game-border)
  border-radius: 16px
  backdrop-filter: blur(20px)
  display: flex
  flex-direction: column
  gap: 14px
  font-family: 'Rajdhani', 'Inter', sans-serif
  box-shadow: 0 0 30px var(--cg)

.corner
  position: absolute
  width: 20px
  height: 20px
  border-color: var(--c)
  border-style: solid
  border-width: 0

.tl
  top: -1px
  left: -1px
  border-top-width: 2px
  border-left-width: 2px
  border-top-left-radius: 8px
.tr
  top: -1px
  right: -1px
  border-top-width: 2px
  border-right-width: 2px
  border-top-right-radius: 8px
.bl
  bottom: -1px
  left: -1px
  border-bottom-width: 2px
  border-left-width: 2px
  border-bottom-left-radius: 8px
.br
  bottom: -1px
  right: -1px
  border-bottom-width: 2px
  border-right-width: 2px
  border-bottom-right-radius: 8px

header
  display: flex
  justify-content: space-between
  align-items: flex-start
  gap: 20px

.step-num
  font-family: 'Orbitron', sans-serif
  font-size: 11px
  letter-spacing: 2.5px
  color: var(--c)
  text-shadow: 0 0 6px var(--cg)

h2
  margin: 6px 0 4px
  font-family: 'Orbitron', sans-serif
  font-size: 26px
  font-weight: 800
  letter-spacing: 1.5px
  color: var(--game-text)
  text-shadow: 0 0 12px var(--cg)

.step-info p
  margin: 0
  color: var(--game-text-dim)
  font-size: 13px

.counter
  display: flex
  align-items: baseline
  gap: 4px
  padding: 10px 14px
  background: rgba(0, 0, 0, 0.4)
  border: 1px solid var(--c)
  border-radius: 10px

  .num
    font-family: 'Orbitron', sans-serif
    font-size: 22px
    font-weight: 800
    color: var(--c)
    text-shadow: 0 0 8px var(--cg)

  .sep
    color: var(--game-text-dim)
    font-size: 16px

  .total-num
    font-family: 'Orbitron', sans-serif
    font-size: 14px
    color: var(--game-text-dim)

.progress-bar
  height: 4px
  background: rgba(255, 255, 255, 0.05)
  border-radius: 2px
  overflow: hidden
  border: 1px solid var(--game-border)

.progress-fill
  height: 100%
  background: var(--c)
  box-shadow: 0 0 6px var(--cg)
  transition: width 0.4s ease

.instruction
  margin: 0
  font-size: 13px
  color: var(--game-text-dim)
  font-style: italic

  strong
    color: var(--game-text)
    font-style: normal

.q-list
  list-style: none
  margin: 0
  padding: 0 4px 0 0
  flex: 1
  overflow-y: auto
  display: flex
  flex-direction: column
  gap: 6px

  &::-webkit-scrollbar
    width: 4px

  &::-webkit-scrollbar-thumb
    background: var(--game-border)
    border-radius: 2px

  li
    display: grid
    grid-template-columns: 30px 1fr auto
    align-items: center
    gap: 12px
    padding: 10px 12px
    background: rgba(0, 0, 0, 0.25)
    border: 1px solid var(--game-border)
    border-radius: 8px
    transition: all 0.2s

    &.answered
      border-color: var(--c)
      background: rgba(0, 0, 0, 0.35)
      box-shadow: 0 0 8px var(--cg)

.q-list .num
  font-family: 'Orbitron', sans-serif
  font-size: 11px
  font-weight: 700
  color: var(--game-text-dim)

.q-text
  margin: 0
  font-size: 13px
  line-height: 1.4
  color: var(--game-text)

.toggle
  display: flex
  gap: 4px

.opt
  padding: 6px 14px
  background: transparent
  border: 1px solid var(--game-border)
  border-radius: 6px
  color: var(--game-text-dim)
  font-family: 'Orbitron', sans-serif
  font-size: 10px
  font-weight: 700
  letter-spacing: 1.5px
  cursor: pointer
  transition: all 0.2s

  &:hover
    border-color: var(--game-text-dim)
    color: var(--game-text)

  &.yes.active
    border-color: var(--c)
    background: var(--c)
    color: #001a33
    box-shadow: 0 0 10px var(--cg)

  &.no.active
    border-color: #FF6B6B
    color: #FF6B6B
    background: rgba(255, 107, 107, 0.08)

footer
  display: grid
  grid-template-columns: 1fr auto 1fr
  align-items: center
  gap: 12px
  padding-top: 8px
  border-top: 1px solid rgba(255, 255, 255, 0.05)

.back-btn
  justify-self: start
  display: inline-flex
  align-items: center
  gap: 6px
  padding: 10px 18px
  background: transparent
  border: 1px solid var(--game-border)
  border-radius: 8px
  color: var(--game-text-dim)
  font-family: 'Orbitron', sans-serif
  font-size: 11px
  font-weight: 700
  letter-spacing: 1.5px
  cursor: pointer

  &:hover
    border-color: var(--game-text)
    color: var(--game-text)

.hint
  font-size: 11px
  color: var(--game-text-dim)
  text-align: center
  font-family: 'Orbitron', sans-serif
  letter-spacing: 1px

.next-btn
  justify-self: end
  display: inline-flex
  align-items: center
  gap: 8px
  padding: 12px 22px
  background: rgba(0, 0, 0, 0.4)
  border: 1px solid var(--c)
  border-radius: 8px
  color: var(--c)
  font-family: 'Orbitron', sans-serif
  font-size: 12px
  font-weight: 700
  letter-spacing: 1.5px
  cursor: pointer
  text-shadow: 0 0 6px var(--cg)
  box-shadow: 0 0 14px var(--cg), inset 0 0 8px rgba(255, 255, 255, 0.04)
  transition: all 0.2s

  &:hover
    background: rgba(255, 255, 255, 0.05)
    box-shadow: 0 0 22px var(--cg)
    transform: translateY(-1px)
</style>
