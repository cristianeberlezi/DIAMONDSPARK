<template>
  <div class="onboarding">
    <video ref="v1" class="bg-video" :class="{ active: vActive === 1 }" autoplay muted playsinline @timeupdate="onTime(1)">
      <source src="/videos/bg.mp4" type="video/mp4" />
    </video>
    <video ref="v2" class="bg-video" :class="{ active: vActive === 2 }" muted playsinline @timeupdate="onTime(2)">
      <source src="/videos/bg.mp4" type="video/mp4" />
    </video>

    <audio ref="audio" src="/Audio/audio.mp4" loop preload="auto"></audio>

    <button class="audio-toggle" @click="toggleAudio" :aria-label="audioPlaying ? 'Pausar áudio' : 'Tocar áudio'">
      <svg v-if="audioPlaying" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <polygon points="11 5 6 9 2 9 2 15 6 15 11 19 11 5"/>
        <path d="M19.07 4.93a10 10 0 0 1 0 14.14M15.54 8.46a5 5 0 0 1 0 7.07"/>
      </svg>
      <svg v-else width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <polygon points="11 5 6 9 2 9 2 15 6 15 11 19 11 5"/>
        <line x1="23" y1="9" x2="17" y2="15"/>
        <line x1="17" y1="9" x2="23" y2="15"/>
      </svg>
    </button>

    <div class="overlay"></div>
    <div class="overlay-grid"></div>

    <div class="stage">
      <Transition name="slide" mode="out-in">
        <OnbWelcome v-if="stage === 'welcome'" key="welcome" @start="start" />

        <OnbStep
          v-else-if="stage === 'step' && currentStep"
          :key="`step-${currentStepIndex}`"
          :step="currentStep"
          :questions="currentStepQuestions"
          :index="currentStepIndex"
          :total="steps.length"
          :initial-answers="answersForStep"
          @next="onStepNext"
          @back="onStepBack"
        />

        <OnbLoading v-else-if="stage === 'loading'" key="loading" @done="onLoadingDone" />

        <OnbResult
          v-else-if="stage === 'result' && winner"
          key="result"
          :profile="winner"
          :compatibility="compatibility"
          @accept="onAccept"
          @redo="onRedo"
        />
      </Transition>
    </div>


    <!-- Overlay de transição para o game -->
    <Transition name="enter">
      <div v-if="entering" class="entering">
        <div class="enter-orb">
          <div class="ring r1"></div>
          <div class="ring r2"></div>
          <div class="ring r3"></div>
          <div class="core" :style="{ '--c': winner?.color || '#00D4FF', '--cg': winner?.glow || 'rgba(0, 212, 255, 0.5)' }">
            <span>{{ winner?.letter }}</span>
          </div>
        </div>
        <h2>INICIANDO JORNADA</h2>
        <p>{{ winner?.name }} · {{ winner?.role }}</p>
      </div>
    </Transition>
  </div>
</template>

<script setup>
import { profiles } from '~/components/onboarding/data.js'

definePageMeta({ layout: 'default', middleware: 'auth' })
useHead({ title: 'Onboarding — Descubra seu personagem' })

const router = useRouter()
const supabase = useSupabaseClient()
const user = useSupabaseUser()

const stage = ref('welcome') // welcome | step | loading | result
const steps = ref([])
const questionsByStep = ref({})       // { stepId: [questions] }
const answers = ref({})               // { questionId: true/false }
const currentStepIndex = ref(0)
const winner = ref(null)
const compatibility = ref(0)
const entering = ref(false)

// Carrega steps + perguntas do banco
async function loadOnboarding() {
  const { data: stepsData } = await supabase
    .from('onboarding_steps')
    .select('*')
    .order('order_num')

  const { data: questionsData } = await supabase
    .from('onboarding_questions')
    .select('*')
    .order('order_num')

  steps.value = stepsData || []

  // agrupa perguntas por step
  const byStep = {}
  for (const q of questionsData || []) {
    if (!byStep[q.step_id]) byStep[q.step_id] = []
    byStep[q.step_id].push(q)
  }
  questionsByStep.value = byStep

  // restaura respostas anteriores se existirem
  if (user.value) {
    const { data: prev } = await supabase
      .from('onboarding_responses')
      .select('question_id, answer')
      .eq('user_id', user.value.id)
    const restored = {}
    for (const r of prev || []) restored[r.question_id] = r.answer
    answers.value = restored
  }
}

onMounted(() => {
  loadOnboarding()
})

const currentStep = computed(() => steps.value[currentStepIndex.value])
const currentStepQuestions = computed(() =>
  currentStep.value ? (questionsByStep.value[currentStep.value.id] || []) : []
)
const answersForStep = computed(() => {
  const out = {}
  for (const q of currentStepQuestions.value) {
    if (answers.value[q.id] !== undefined) out[q.id] = answers.value[q.id]
  }
  return out
})

function start() {
  currentStepIndex.value = 0
  stage.value = 'step'
}

async function onStepNext(stepAnswers) {
  // Mescla respostas do step no estado global
  answers.value = { ...answers.value, ...stepAnswers }

  // Salva no banco (upsert)
  if (user.value) {
    const rows = Object.entries(stepAnswers).map(([qId, ans]) => ({
      user_id: user.value.id,
      question_id: parseInt(qId),
      answer: ans
    }))
    if (rows.length) {
      await supabase
        .from('onboarding_responses')
        .upsert(rows, { onConflict: 'user_id,question_id' })
    }
  }

  if (currentStepIndex.value < steps.value.length - 1) {
    currentStepIndex.value++
  } else {
    stage.value = 'loading'
  }
}

function onStepBack() {
  if (currentStepIndex.value > 0) currentStepIndex.value--
}

async function onLoadingDone() {
  // Pede ao banco o cálculo via função SQL
  if (user.value) {
    const { data: results } = await supabase
      .rpc('calculate_onboarding_results', { p_user_id: user.value.id })

    if (results && results.length) {
      // Top Holland (categoria 'holland' com maior score)
      const holland = results
        .filter(r => r.category === 'holland')
        .sort((a, b) => b.score - a.score)[0]

      const key = holland?.code || 'I'
      winner.value = profiles[key] || profiles['I']
      compatibility.value = Math.round(parseFloat(holland?.percentage || 0))
      if (compatibility.value < 75) compatibility.value = 75 + Math.floor(Math.random() * 15)
      stage.value = 'result'
      return
    }
  }

  // fallback
  winner.value = profiles['I']
  compatibility.value = 85
  stage.value = 'result'
}

async function onAccept() {
  entering.value = true

  if (user.value && winner.value) {
    await supabase.from('profiles').update({
      character_profile: winner.value.letter,
      onboarding_done: true
    }).eq('id', user.value.id)
  }

  setTimeout(() => {
    router.push('/game')
  }, 1800)
}

function onRedo() {
  winner.value = null
  currentStepIndex.value = 0
  stage.value = 'welcome'
}

/* Audio de fundo */
const audio = ref(null)
const audioPlaying = ref(false)

onMounted(async () => {
  if (audio.value) {
    audio.value.volume = 0.4
    try {
      await audio.value.play()
      audioPlaying.value = true
    } catch (e) {
      // browser bloqueou autoplay — espera interação
      audioPlaying.value = false
      const startOnInteract = async () => {
        try {
          await audio.value.play()
          audioPlaying.value = true
        } catch {}
        window.removeEventListener('click', startOnInteract)
        window.removeEventListener('keydown', startOnInteract)
      }
      window.addEventListener('click', startOnInteract, { once: true })
      window.addEventListener('keydown', startOnInteract, { once: true })
    }
  }
})

onBeforeUnmount(() => {
  if (audio.value) {
    audio.value.pause()
  }
})

function toggleAudio() {
  if (!audio.value) return
  if (audioPlaying.value) {
    audio.value.pause()
    audioPlaying.value = false
  } else {
    audio.value.play().then(() => {
      audioPlaying.value = true
    }).catch(() => {})
  }
}

/* Video crossfade loop */
const v1 = ref(null)
const v2 = ref(null)
const vActive = ref(1)
const FADE_THRESHOLD = 0.8

function onTime(num) {
  const cur = num === 1 ? v1.value : v2.value
  const other = num === 1 ? v2.value : v1.value
  if (!cur || !other || !cur.duration) return
  if (vActive.value !== num) return
  if (cur.duration - cur.currentTime < FADE_THRESHOLD) {
    other.currentTime = 0
    other.play().catch(() => {})
    vActive.value = num === 1 ? 2 : 1
  }
}
</script>

<style lang="sass" scoped>
.onboarding
  position: relative
  width: 100vw
  height: 100vh
  overflow: hidden
  background: var(--game-bg)
  font-family: 'Rajdhani', 'Inter', sans-serif

.bg-video
  position: absolute
  inset: 0
  width: 100%
  height: 100%
  object-fit: cover
  transform: scale(1.18)
  z-index: 0
  opacity: 0
  transition: opacity 0.9s ease-in-out

  &.active
    opacity: 1

.audio-toggle
  position: fixed
  top: 20px
  right: 20px
  z-index: 50
  width: 38px
  height: 38px
  border-radius: 50%
  background: rgba(8, 18, 40, 0.7)
  border: 1px solid var(--game-cyan)
  color: var(--game-cyan)
  display: flex
  align-items: center
  justify-content: center
  cursor: pointer
  backdrop-filter: blur(8px)
  box-shadow: 0 0 12px rgba(0, 212, 255, 0.25)
  transition: all 0.2s

  &:hover
    background: rgba(0, 212, 255, 0.15)
    box-shadow: 0 0 18px rgba(0, 212, 255, 0.5)

.overlay
  position: absolute
  inset: 0
  background: radial-gradient(ellipse at center, rgba(5, 11, 26, 0.65) 0%, rgba(5, 11, 26, 0.92) 80%)
  z-index: 1

.overlay-grid
  position: absolute
  inset: 0
  background-image: linear-gradient(rgba(0, 212, 255, 0.04) 1px, transparent 1px), linear-gradient(90deg, rgba(0, 212, 255, 0.04) 1px, transparent 1px)
  background-size: 60px 60px
  z-index: 2
  pointer-events: none
  mask-image: radial-gradient(ellipse at center, black 30%, transparent 80%)

.stage
  position: relative
  z-index: 3
  width: 100%
  height: 100%
  display: flex
  align-items: center
  justify-content: center
  padding: 32px

/* Transition between stages */
.slide-enter-active, .slide-leave-active
  transition: opacity 0.4s ease, transform 0.4s ease

.slide-enter-from
  opacity: 0
  transform: translateY(20px)

.slide-leave-to
  opacity: 0
  transform: translateY(-20px)

/* Entering /game overlay */
.entering
  position: fixed
  inset: 0
  z-index: 100
  background: radial-gradient(ellipse at center, rgba(0, 30, 60, 0.95), rgba(5, 11, 26, 1))
  display: flex
  flex-direction: column
  align-items: center
  justify-content: center
  gap: 22px
  color: var(--game-text)
  font-family: 'Orbitron', sans-serif

.enter-orb
  position: relative
  width: 180px
  height: 180px

.ring
  position: absolute
  inset: 0
  border-radius: 50%
  border: 2px solid var(--game-cyan)
  animation: ring-pulse 1.4s ease-out infinite

  &.r2
    animation-delay: 0.3s
  &.r3
    animation-delay: 0.6s

@keyframes ring-pulse
  0%
    transform: scale(0.3)
    opacity: 0.9
  100%
    transform: scale(1.4)
    opacity: 0

.core
  position: absolute
  inset: 50px
  border-radius: 50%
  background: radial-gradient(circle at 30% 30%, var(--c, var(--game-cyan)), rgba(0, 0, 0, 0.6))
  border: 2px solid var(--c, var(--game-cyan))
  box-shadow: 0 0 40px var(--cg, var(--game-cyan-glow)), inset 0 0 20px rgba(255, 255, 255, 0.2)
  display: flex
  align-items: center
  justify-content: center
  animation: core-pop 1.2s ease

  span
    font-family: 'Orbitron', sans-serif
    font-size: 36px
    font-weight: 800
    color: #fff
    text-shadow: 0 0 16px var(--cg, var(--game-cyan-glow))

@keyframes core-pop
  0%
    transform: scale(0.5)
    opacity: 0
  50%
    transform: scale(1.1)
  100%
    transform: scale(1)
    opacity: 1

.entering h2
  margin: 0
  font-size: 24px
  letter-spacing: 4px
  text-shadow: 0 0 16px var(--game-cyan-glow)

.entering p
  margin: 0
  font-family: 'Rajdhani', 'Inter', sans-serif
  font-size: 14px
  letter-spacing: 2px
  color: var(--game-text-dim)

.enter-enter-active
  transition: opacity 0.4s ease

.enter-enter-from
  opacity: 0

.enter-leave-active
  transition: opacity 0.6s ease

.enter-leave-to
  opacity: 0
</style>
