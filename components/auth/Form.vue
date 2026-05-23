<template>
  <div class="auth-card">
    <!-- frame decorativo -->
    <div class="frame frame-tl"></div>
    <div class="frame frame-tr"></div>
    <div class="frame frame-bl"></div>
    <div class="frame frame-br"></div>

    <div class="logo">
      <div class="logo-icon">
        <svg width="36" height="36" viewBox="0 0 24 24" fill="none">
          <path d="M12 2 L22 7 V17 L12 22 L2 17 V7 Z" stroke="#00D4FF" stroke-width="1.5" fill="rgba(0, 212, 255, 0.1)"/>
          <path d="M12 2 L22 7 L12 12 L2 7 Z" fill="rgba(0, 212, 255, 0.25)" stroke="#00D4FF" stroke-width="1.5"/>
          <text x="12" y="16" text-anchor="middle" font-size="9" font-weight="800" fill="#00D4FF" font-family="Orbitron">DS</text>
        </svg>
      </div>
      <h1>DIAMOND SPARK</h1>
      <p>Sua jornada de aprendizado começa aqui</p>
    </div>

    <div class="tabs">
      <button :class="['tab', { active: mode === 'login' }]" @click="mode = 'login'">
        ENTRAR
      </button>
      <button :class="['tab', { active: mode === 'signup' }]" @click="mode = 'signup'">
        CADASTRAR
      </button>
    </div>

    <form class="form" @submit.prevent="onSubmit">
      <div v-if="mode === 'signup'" class="field">
        <label>NOME</label>
        <div class="input-wrap">
          <svg class="ico" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
            <circle cx="12" cy="7" r="4"/>
          </svg>
          <input v-model="form.nome" type="text" placeholder="Seu nome completo" required />
        </div>
      </div>


      <div class="field">
        <label>E-MAIL</label>
        <div class="input-wrap">
          <svg class="ico" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
            <rect x="3" y="5" width="18" height="14" rx="2"/>
            <path d="m3 7 9 6 9-6"/>
          </svg>
          <input v-model="form.email" type="email" placeholder="seu@email.com" required />
        </div>
      </div>

      <div class="field">
        <label>SENHA</label>
        <div class="input-wrap">
          <svg class="ico" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
            <rect x="4" y="11" width="16" height="10" rx="2"/>
            <path d="M8 11V7a4 4 0 1 1 8 0v4"/>
          </svg>
          <input v-model="form.senha" :type="showPass ? 'text' : 'password'" placeholder="••••••••" required minlength="6" />
          <button type="button" class="eye" @click="showPass = !showPass" aria-label="Mostrar senha">
            <svg v-if="showPass" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
              <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94"/>
              <path d="M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19"/>
              <line x1="1" y1="1" x2="23" y2="23"/>
            </svg>
            <svg v-else width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
              <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
              <circle cx="12" cy="12" r="3"/>
            </svg>
          </button>
        </div>
      </div>

      <div v-if="mode === 'signup'" class="field">
        <label>CONFIRMAR SENHA</label>
        <div class="input-wrap">
          <svg class="ico" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
            <rect x="4" y="11" width="16" height="10" rx="2"/>
            <path d="M8 11V7a4 4 0 1 1 8 0v4"/>
          </svg>
          <input v-model="form.confirmar" type="password" placeholder="••••••••" />
        </div>
      </div>

      <div v-if="mode === 'login'" class="row">
        <label class="check">
          <input type="checkbox" v-model="form.lembrar" />
          <span class="box"></span>
          Lembrar de mim
        </label>
        <a href="#" class="forgot">Esqueci a senha</a>
      </div>

      <p v-if="error" class="error-msg">{{ error }}</p>
      <p v-if="info" class="info-msg">{{ info }}</p>

      <button type="submit" class="submit" :disabled="loading">
        <span v-if="loading">PROCESSANDO...</span>
        <template v-else>
          <span>{{ mode === 'login' ? 'ENTRAR' : 'CRIAR CONTA' }}</span>
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="13 17 18 12 13 7"/>
            <polyline points="6 17 11 12 6 7"/>
          </svg>
        </template>
      </button>

      <div class="divider"><span>ou continue com</span></div>

      <div class="socials">
        <button type="button" class="social" aria-label="Google">
          <svg width="18" height="18" viewBox="0 0 24 24">
            <path fill="#FFC107" d="M21.8 10.2H12v3.8h5.6c-.5 2.4-2.5 3.8-5.6 3.8a6 6 0 0 1 0-12c1.5 0 2.9.5 4 1.5l2.8-2.8A10 10 0 0 0 12 2a10 10 0 1 0 9.8 11.8z"/>
            <path fill="#FF3D00" d="M3.2 7.3 6.4 9.6a6 6 0 0 1 5.6-3.8c1.5 0 2.9.5 4 1.5l2.8-2.8A10 10 0 0 0 3.2 7.3z"/>
            <path fill="#4CAF50" d="M12 22a10 10 0 0 0 6.8-2.6l-3.1-2.6a6 6 0 0 1-9.3-2.6L3.2 16.7A10 10 0 0 0 12 22z"/>
            <path fill="#1976D2" d="M21.8 10.2H12v3.8h5.6a5.7 5.7 0 0 1-2 2.8l3.1 2.6c-.2.2 3.3-2.4 3.3-7.4 0-.6-.1-1.2-.2-1.8z"/>
          </svg>
        </button>
        <button type="button" class="social" aria-label="Apple">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="#FFFFFF">
            <path d="M17.05 12.04c-.03-2.79 2.28-4.13 2.39-4.2-1.3-1.9-3.33-2.16-4.05-2.19-1.73-.17-3.37 1.02-4.25 1.02-.88 0-2.23-1-3.66-.97-1.89.03-3.63 1.1-4.6 2.79-1.96 3.4-.5 8.42 1.4 11.18.93 1.35 2.04 2.86 3.5 2.8 1.4-.06 1.93-.91 3.63-.91 1.7 0 2.17.91 3.66.88 1.51-.03 2.47-1.37 3.4-2.73 1.07-1.56 1.51-3.07 1.54-3.15-.03-.01-2.95-1.13-2.98-4.49zM14.4 4.04c.78-.94 1.3-2.25 1.16-3.55-1.12.04-2.47.74-3.27 1.68-.72.83-1.36 2.16-1.19 3.43 1.24.1 2.51-.63 3.3-1.56z"/>
          </svg>
        </button>
        <button type="button" class="social" aria-label="Facebook">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="#1877F2">
            <path d="M22 12c0-5.5-4.5-10-10-10S2 6.5 2 12c0 5 3.7 9.1 8.4 9.9v-7H7.9V12h2.5V9.8c0-2.5 1.5-3.9 3.8-3.9 1.1 0 2.2.2 2.2.2v2.5h-1.3c-1.2 0-1.6.8-1.6 1.6V12h2.8l-.5 2.9h-2.3v7C18.3 21.1 22 17 22 12z"/>
          </svg>
        </button>
      </div>
    </form>
  </div>
</template>

<script setup>
const mode = ref('login')
const showPass = ref(false)
const loading = ref(false)
const error = ref('')
const info = ref('')

const form = ref({
  nome: '',
  email: '',
  senha: '',
  confirmar: '',
  lembrar: false
})

const router = useRouter()
const supabase = useSupabaseClient()
const user = useSupabaseUser()

watch(mode, () => {
  error.value = ''
  info.value = ''
})

async function navigate(dest) {
  // Confirma que a sessão está estabelecida antes de navegar.
  // O middleware do destino tem fallback pra getSession(), então não precisamos
  // esperar o ref do useSupabaseUser sincronizar.
  let session = null
  for (let i = 0; i < 20; i++) {
    const { data } = await supabase.auth.getSession()
    if (data?.session) { session = data.session; break }
    await new Promise((r) => setTimeout(r, 100))
  }
  console.log('[auth] navegando · session:', !!session, '· user.value:', !!user.value?.id)

  if (!session) {
    error.value = 'Sessão não foi criada. Verifique sua conexão e tente novamente.'
    return
  }

  await navigateTo(dest)
}

async function onSubmit() {
  error.value = ''
  info.value = ''
  loading.value = true

  try {
    if (mode.value === 'signup') {
      if (form.value.senha !== form.value.confirmar) {
        error.value = 'As senhas não conferem.'
        return
      }
      if (form.value.senha.length < 6) {
        error.value = 'A senha precisa ter ao menos 6 caracteres.'
        return
      }

      const { data, error: err } = await supabase.auth.signUp({
        email: form.value.email,
        password: form.value.senha,
        options: {
          data: {
            name: form.value.nome,
            role: 'aluno'
          }
        }
      })

      if (err) {
        error.value = traduzir(err.message)
        console.error('signUp error:', err)
        return
      }

      console.log('[auth] signUp ok · session:', data.session ? 'sim' : 'não')

      // Se Supabase exige confirmação de email, data.session vem null.
      // Tentamos sign in imediato.
      if (!data.session) {
        const { error: signInErr } = await supabase.auth.signInWithPassword({
          email: form.value.email,
          password: form.value.senha
        })
        if (signInErr) {
          info.value = 'Conta criada! Confirme seu e-mail para continuar.'
          console.warn('Auto sign-in falhou:', signInErr.message)
          return
        }
        console.log('[auth] auto sign-in ok')
      }

      console.log('[auth] redirecionando para /onboarding')
      await navigate('/onboarding')
      return
    }

    // ===== LOGIN =====
    const { data, error: err } = await supabase.auth.signInWithPassword({
      email: form.value.email,
      password: form.value.senha
    })

    if (err) {
      error.value = traduzir(err.message)
      console.error('signIn error:', err)
      return
    }

    console.log('[auth] login ok · user:', data.user?.id)

    // busca role + onboarding_done pra decidir destino
    let dest = '/onboarding'
    if (data.user?.id) {
      const { data: profile, error: profileErr } = await supabase
        .from('profiles')
        .select('role, onboarding_done')
        .eq('id', data.user.id)
        .single()

      if (profileErr) {
        console.warn('Erro ao buscar profile:', profileErr.message)
      }
      if (profile?.role === 'professor') dest = '/admin'
      else if (profile?.onboarding_done) dest = '/game'
    }

    console.log('[auth] redirecionando para', dest)
    await navigate(dest)
  } catch (e) {
    error.value = 'Erro inesperado: ' + (e?.message || 'tente novamente')
    console.error('[auth] erro inesperado:', e)
  } finally {
    loading.value = false
  }
}

function traduzir(msg) {
  const dict = {
    'Invalid login credentials': 'E-mail ou senha incorretos.',
    'User already registered': 'Este e-mail já está cadastrado.',
    'Email not confirmed': 'Confirme seu e-mail antes de entrar.',
    'Password should be at least 6 characters': 'A senha precisa ter ao menos 6 caracteres.'
  }
  return dict[msg] || msg
}
</script>

<style lang="sass" scoped>
.auth-card
  position: relative
  width: 440px
  max-width: calc(100vw - 32px)
  background: rgba(8, 18, 40, 0.65)
  border: 1px solid var(--game-border)
  border-radius: 16px
  padding: 32px 36px
  backdrop-filter: blur(18px)
  box-shadow: 0 0 40px rgba(0, 212, 255, 0.15), inset 0 0 30px rgba(0, 212, 255, 0.04)
  font-family: 'Rajdhani', 'Inter', sans-serif

/* Cantos decorativos sci-fi */
.frame
  position: absolute
  width: 22px
  height: 22px
  border-color: var(--game-cyan)
  border-style: solid
  border-width: 0

.frame-tl
  top: -1px
  left: -1px
  border-top-width: 2px
  border-left-width: 2px
  border-top-left-radius: 8px

.frame-tr
  top: -1px
  right: -1px
  border-top-width: 2px
  border-right-width: 2px
  border-top-right-radius: 8px

.frame-bl
  bottom: -1px
  left: -1px
  border-bottom-width: 2px
  border-left-width: 2px
  border-bottom-left-radius: 8px

.frame-br
  bottom: -1px
  right: -1px
  border-bottom-width: 2px
  border-right-width: 2px
  border-bottom-right-radius: 8px

/* Logo */
.logo
  text-align: center
  margin-bottom: 24px

  .logo-icon
    display: inline-flex
    margin-bottom: 12px
    filter: drop-shadow(0 0 12px var(--game-cyan-glow))

  h1
    margin: 0 0 6px
    font-family: 'Orbitron', sans-serif
    font-weight: 800
    font-size: 22px
    letter-spacing: 3px
    color: var(--game-text)
    text-shadow: 0 0 12px var(--game-cyan-glow)

  p
    margin: 0
    color: var(--game-text-dim)
    font-size: 13px
    letter-spacing: 0.5px

/* Tabs */
.tabs
  display: grid
  grid-template-columns: 1fr 1fr
  gap: 0
  margin-bottom: 24px
  border: 1px solid var(--game-border)
  border-radius: 8px
  padding: 4px
  background: rgba(0, 0, 0, 0.3)

.tab
  padding: 10px
  background: transparent
  border: none
  color: var(--game-text-dim)
  font-family: 'Orbitron', sans-serif
  font-size: 11px
  font-weight: 700
  letter-spacing: 2px
  cursor: pointer
  border-radius: 6px
  transition: all 0.25s

  &.active
    background: linear-gradient(180deg, rgba(0, 130, 200, 0.4), rgba(0, 80, 150, 0.5))
    color: var(--game-cyan)
    box-shadow: 0 0 14px rgba(0, 212, 255, 0.3), inset 0 0 10px rgba(0, 212, 255, 0.15)
    text-shadow: 0 0 6px var(--game-cyan-glow)

/* Form */
.form
  display: flex
  flex-direction: column
  gap: 16px

.field
  display: flex
  flex-direction: column
  gap: 6px

  label
    font-family: 'Orbitron', sans-serif
    font-size: 10px
    font-weight: 600
    letter-spacing: 2px
    color: var(--game-text-dim)

.input-wrap
  display: flex
  align-items: center
  gap: 10px
  background: rgba(0, 0, 0, 0.4)
  border: 1px solid var(--game-border)
  border-radius: 8px
  padding: 0 14px
  transition: all 0.2s

  &:focus-within
    border-color: var(--game-cyan)
    box-shadow: 0 0 14px rgba(0, 212, 255, 0.25), inset 0 0 8px rgba(0, 212, 255, 0.08)

  .ico
    color: var(--game-text-dim)
    flex-shrink: 0

  input
    flex: 1
    background: transparent
    border: none
    outline: none
    padding: 12px 0
    color: var(--game-text)
    font-family: inherit
    font-size: 14px

    &::placeholder
      color: var(--game-text-dim)

  .eye
    background: transparent
    border: none
    color: var(--game-text-dim)
    cursor: pointer
    display: flex
    align-items: center
    padding: 4px

    &:hover
      color: var(--game-cyan)

.row
  display: flex
  align-items: center
  justify-content: space-between
  margin-top: -4px

.check
  display: inline-flex
  align-items: center
  gap: 8px
  color: var(--game-text-dim)
  font-size: 12px
  cursor: pointer
  user-select: none

  input
    position: absolute
    opacity: 0
    pointer-events: none

  .box
    width: 14px
    height: 14px
    border: 1.5px solid var(--game-border)
    border-radius: 3px
    display: inline-block
    position: relative
    transition: all 0.2s

  input:checked + .box
    background: var(--game-cyan)
    border-color: var(--game-cyan)
    box-shadow: 0 0 8px var(--game-cyan-glow)

    &::after
      content: ''
      position: absolute
      left: 3px
      top: 0px
      width: 4px
      height: 8px
      border: solid #001a33
      border-width: 0 2px 2px 0
      transform: rotate(45deg)

.forgot
  color: var(--game-cyan)
  font-size: 12px
  text-decoration: none

  &:hover
    text-shadow: 0 0 6px var(--game-cyan-glow)

.role-toggle
  display: grid
  grid-template-columns: 1fr 1fr
  gap: 6px
  background: rgba(0, 0, 0, 0.4)
  border: 1px solid var(--game-border)
  border-radius: 8px
  padding: 4px

.role-opt
  display: inline-flex
  align-items: center
  justify-content: center
  gap: 6px
  padding: 10px
  background: transparent
  border: none
  border-radius: 6px
  color: var(--game-text-dim)
  font-family: 'Orbitron', sans-serif
  font-size: 11px
  font-weight: 700
  letter-spacing: 1.5px
  cursor: pointer
  transition: all 0.2s

  &.active
    background: linear-gradient(180deg, rgba(0, 130, 200, 0.4), rgba(0, 80, 150, 0.5))
    color: var(--game-cyan)
    box-shadow: 0 0 10px rgba(0, 212, 255, 0.25), inset 0 0 8px rgba(0, 212, 255, 0.1)
    text-shadow: 0 0 6px var(--game-cyan-glow)

.error-msg
  margin: -4px 0 0
  padding: 8px 12px
  background: rgba(229, 57, 53, 0.1)
  border: 1px solid rgba(229, 57, 53, 0.4)
  border-radius: 6px
  color: #FF6B6B
  font-size: 12px
  text-align: center

.info-msg
  margin: -4px 0 0
  padding: 8px 12px
  background: rgba(0, 212, 255, 0.08)
  border: 1px solid var(--game-cyan)
  border-radius: 6px
  color: var(--game-cyan)
  font-size: 12px
  text-align: center

.submit
  display: flex
  align-items: center
  justify-content: center
  gap: 12px
  padding: 14px
  margin-top: 8px

  &:disabled
    opacity: 0.6
    cursor: not-allowed
  background: linear-gradient(180deg, rgba(0, 130, 200, 0.5), rgba(0, 80, 150, 0.7))
  border: 1px solid var(--game-cyan)
  border-radius: 8px
  color: var(--game-cyan)
  font-family: 'Orbitron', sans-serif
  font-weight: 700
  font-size: 13px
  letter-spacing: 2px
  cursor: pointer
  text-shadow: 0 0 8px var(--game-cyan-glow)
  box-shadow: 0 0 18px rgba(0, 212, 255, 0.3), inset 0 0 12px rgba(0, 212, 255, 0.15)
  transition: all 0.2s

  &:hover
    background: linear-gradient(180deg, rgba(0, 170, 240, 0.6), rgba(0, 110, 180, 0.8))
    box-shadow: 0 0 30px rgba(0, 212, 255, 0.55), inset 0 0 18px rgba(0, 212, 255, 0.25)
    transform: translateY(-1px)

.divider
  display: flex
  align-items: center
  gap: 12px
  margin: 8px 0 4px
  color: var(--game-text-dim)
  font-size: 11px
  letter-spacing: 1px

  &::before, &::after
    content: ''
    flex: 1
    height: 1px
    background: var(--game-border)

.socials
  display: grid
  grid-template-columns: repeat(3, 1fr)
  gap: 10px

.social
  display: flex
  align-items: center
  justify-content: center
  padding: 11px
  background: rgba(0, 0, 0, 0.4)
  border: 1px solid var(--game-border)
  border-radius: 8px
  cursor: pointer
  transition: all 0.2s

  &:hover
    border-color: var(--game-cyan)
    box-shadow: 0 0 12px rgba(0, 212, 255, 0.25)
    transform: translateY(-1px)

@media screen and (max-width: 500px)
  .auth-card
    padding: 24px 22px

    h1
      font-size: 18px
</style>
