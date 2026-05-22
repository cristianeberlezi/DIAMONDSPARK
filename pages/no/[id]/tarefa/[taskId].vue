<template>
  <div class="submission-page">
    <video class="bg-video" autoplay muted loop playsinline>
      <source src="/videos/bg.mp4" type="video/mp4" />
    </video>
    <div class="overlay"></div>
    <div class="overlay-grid"></div>

    <div class="content">
      <button class="back" @click="back">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="15 18 9 12 15 6"/>
        </svg>
        <span>VOLTAR PARA O NÓ {{ nodeId }}</span>
      </button>

      <div class="title-bar">
        <span class="code">{{ nodeId }}</span>
        <span class="sep">›</span>
        <span class="task-name">{{ task.title }}</span>
      </div>

      <GameTaskSubmission
        :task="task"
        :region="region"
        @submit="onSubmit"
        @cancel="onCancel"
      />

      <div v-if="submitted" class="success-toast">
        ✓ Entrega enviada com sucesso!
      </div>
    </div>
  </div>
</template>

<script setup>
definePageMeta({ layout: 'default' })

const route = useRoute()
const router = useRouter()

const nodeId = computed(() => route.params.id)
const taskId = computed(() => route.params.taskId)

const region = 'ocean'

useHead({ title: () => `Entrega — ${taskId.value}` })

const task = ref({
  id: taskId.value,
  title: 'Documentação técnica',
  description: 'Escrever README completo e guia de instalação do projeto, incluindo dependências, comandos e exemplos de uso.',
  profile: 'documentador',
  xp: 70,
  objective: 'Produzir documentação clara e suficiente para que qualquer pessoa do time consiga rodar o projeto do zero em até 10 minutos.',
  criteria: [
    'README com seções: Sobre, Instalação, Execução, Estrutura',
    'Pelo menos um link para repositório ou documento externo',
    'Capturas de tela ou GIFs de demonstração',
    'Arquivo de exemplo .env.example incluído'
  ]
})

const submitted = ref(false)

function onSubmit(form) {
  console.log('entrega:', form)
  submitted.value = true
  setTimeout(() => router.push(`/no/${nodeId.value}`), 1400)
}

function onCancel() {
  if (confirm('Deseja realmente desistir desta tarefa? Ela voltará para o pool de disponíveis.')) {
    router.push(`/no/${nodeId.value}`)
  }
}

function back() {
  router.push(`/no/${nodeId.value}`)
}
</script>

<style lang="sass" scoped>
.submission-page
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
  width: 100%
  padding: 20px 40px 28px
  display: flex
  flex-direction: column
  gap: 14px

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

.title-bar
  display: flex
  align-items: center
  gap: 12px
  font-family: 'Orbitron', sans-serif

  .code
    color: var(--game-cyan)
    font-size: 22px
    font-weight: 700
    text-shadow: 0 0 10px var(--game-cyan-glow)

  .sep
    color: var(--game-text-dim)
    font-size: 18px

  .task-name
    color: var(--game-text)
    font-size: 16px
    font-weight: 600
    letter-spacing: 0.5px

.success-toast
  position: fixed
  bottom: 32px
  left: 50%
  transform: translateX(-50%)
  z-index: 100
  padding: 14px 24px
  background: rgba(8, 30, 22, 0.9)
  border: 1px solid var(--game-green)
  border-radius: 8px
  color: var(--game-green)
  font-family: 'Orbitron', sans-serif
  font-size: 13px
  font-weight: 700
  letter-spacing: 1px
  box-shadow: 0 0 24px var(--game-green-glow)
</style>
