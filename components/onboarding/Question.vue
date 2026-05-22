<template>
  <div class="question">
    <span class="corner tl"></span>
    <span class="corner tr"></span>
    <span class="corner bl"></span>
    <span class="corner br"></span>

    <div class="header">
      <span class="step">PERGUNTA {{ String(index + 1).padStart(2, '0') }} / {{ String(total).padStart(2, '0') }}</span>
      <div class="bar">
        <div class="fill" :style="{ width: `${((index + 1) / total) * 100}%` }"></div>
      </div>
    </div>

    <h2>{{ question.text }}</h2>

    <div class="options">
      <button
        v-for="(opt, i) in question.options"
        :key="i"
        :class="['option', { selected: selected === i }]"
        @click="pick(i)"
      >
        <span class="bullet">{{ String.fromCharCode(65 + i) }}</span>
        <span class="opt-text">{{ opt.text }}</span>
        <svg v-if="selected === i" class="check" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="20 6 9 17 4 12"/>
        </svg>
      </button>
    </div>

    <div class="footer">
      <button v-if="index > 0" class="back-btn" @click="$emit('back')">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="15 18 9 12 15 6"/>
        </svg>
        VOLTAR
      </button>
      <span v-else></span>
      <button class="next-btn" :disabled="selected === null" @click="confirm">
        <span>{{ index === total - 1 ? 'CONCLUIR' : 'PRÓXIMA' }}</span>
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="9 18 15 12 9 6"/>
        </svg>
      </button>
    </div>
  </div>
</template>

<script setup>
const props = defineProps({
  question: { type: Object, required: true },
  index: { type: Number, required: true },
  total: { type: Number, required: true }
})

const emit = defineEmits(['answer', 'back'])

const selected = ref(null)

watch(() => props.index, () => {
  selected.value = null
})

function pick(i) {
  selected.value = i
}

function confirm() {
  if (selected.value === null) return
  emit('answer', props.question.options[selected.value])
}
</script>

<style lang="sass" scoped>
.question
  position: relative
  width: 720px
  max-width: calc(100vw - 32px)
  padding: 38px 44px
  background: rgba(8, 18, 40, 0.7)
  border: 1px solid var(--game-border)
  border-radius: 16px
  backdrop-filter: blur(20px)
  font-family: 'Rajdhani', 'Inter', sans-serif
  box-shadow: 0 0 30px rgba(0, 212, 255, 0.1)

.corner
  position: absolute
  width: 18px
  height: 18px
  border-color: var(--game-cyan)
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

.header
  margin-bottom: 22px

.step
  display: block
  font-family: 'Orbitron', sans-serif
  font-size: 13px
  letter-spacing: 2.5px
  color: var(--game-cyan)
  margin-bottom: 10px

.bar
  height: 4px
  background: rgba(255, 255, 255, 0.06)
  border-radius: 2px
  overflow: hidden
  border: 1px solid var(--game-border)

.fill
  height: 100%
  background: linear-gradient(90deg, #00D4FF, #56C8FF)
  box-shadow: 0 0 8px var(--game-cyan-glow)
  transition: width 0.4s ease

h2
  margin: 0 0 26px
  font-family: 'Orbitron', sans-serif
  font-size: 26px
  font-weight: 700
  letter-spacing: 0.5px
  line-height: 1.3
  color: var(--game-text)

.options
  display: flex
  flex-direction: column
  gap: 10px
  margin-bottom: 24px

.option
  display: grid
  grid-template-columns: 36px 1fr 20px
  align-items: center
  gap: 16px
  padding: 16px 18px
  background: rgba(0, 0, 0, 0.35)
  border: 1px solid var(--game-border)
  border-radius: 10px
  color: var(--game-text)
  text-align: left
  font-family: inherit
  font-size: 16px
  cursor: pointer
  transition: all 0.2s

  &:hover
    border-color: var(--game-cyan)
    background: rgba(0, 212, 255, 0.06)

  &.selected
    border-color: var(--game-cyan)
    background: rgba(0, 212, 255, 0.12)
    box-shadow: 0 0 14px rgba(0, 212, 255, 0.25), inset 0 0 8px rgba(0, 212, 255, 0.1)

    .bullet
      background: var(--game-cyan)
      color: #001a33
      box-shadow: 0 0 10px var(--game-cyan-glow)

    .check
      color: var(--game-cyan)
      filter: drop-shadow(0 0 6px var(--game-cyan-glow))

.bullet
  width: 32px
  height: 32px
  border-radius: 6px
  display: flex
  align-items: center
  justify-content: center
  background: rgba(0, 0, 0, 0.4)
  border: 1px solid var(--game-border)
  font-family: 'Orbitron', sans-serif
  font-size: 14px
  font-weight: 700
  color: var(--game-text-dim)
  flex-shrink: 0
  transition: all 0.2s

.opt-text
  line-height: 1.4

.footer
  display: flex
  align-items: center
  justify-content: space-between
  gap: 12px

.back-btn, .next-btn
  display: inline-flex
  align-items: center
  gap: 10px
  padding: 14px 26px
  background: rgba(0, 0, 0, 0.4)
  border: 1px solid var(--game-border)
  border-radius: 8px
  color: var(--game-text-dim)
  font-family: 'Orbitron', sans-serif
  font-size: 13px
  font-weight: 700
  letter-spacing: 1.5px
  cursor: pointer
  transition: all 0.2s

.back-btn:hover
  border-color: var(--game-text)
  color: var(--game-text)

.next-btn
  border-color: var(--game-cyan)
  color: var(--game-cyan)
  text-shadow: 0 0 6px var(--game-cyan-glow)
  box-shadow: 0 0 14px rgba(0, 212, 255, 0.25), inset 0 0 8px rgba(0, 212, 255, 0.1)

  &:hover:not(:disabled)
    background: rgba(0, 212, 255, 0.15)
    box-shadow: 0 0 22px rgba(0, 212, 255, 0.45)

  &:disabled
    opacity: 0.4
    cursor: not-allowed
    box-shadow: none
</style>
