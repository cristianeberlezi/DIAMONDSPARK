<template>
  <div :class="['workspace', region]">
    <!-- Briefing compacto do professor (topo) -->
    <section class="brief-strip">
      <button class="brief-toggle" @click="briefOpen = !briefOpen">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <polyline v-if="briefOpen" points="18 15 12 9 6 15"/>
          <polyline v-else points="6 9 12 15 18 9"/>
        </svg>
      </button>
      <div class="brief-head">
        <span class="profile-tag">
          {{ profileMap[task.profile]?.emoji }} {{ profileMap[task.profile]?.label }}
        </span>
        <h2>{{ task.title }}</h2>
        <span class="xp">+{{ task.xp }} XP</span>
      </div>

      <div v-show="briefOpen" class="brief-body">
        <p>{{ task.description }}</p>
        <div class="brief-grid">
          <div>
            <span class="k">OBJETIVO</span>
            <p>{{ task.objective }}</p>
          </div>
          <div>
            <span class="k">CRITÉRIOS DE ACEITAÇÃO</span>
            <ul>
              <li v-for="(c, i) in task.criteria" :key="i">{{ c }}</li>
            </ul>
          </div>
        </div>
      </div>
    </section>

    <!-- Mesa de trabalho do aluno -->
    <section class="desk">
      <!-- Descrição -->
      <div class="card card-description">
        <header>
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
            <polyline points="14 2 14 8 20 8"/>
            <line x1="16" y1="13" x2="8" y2="13"/>
            <line x1="16" y1="17" x2="8" y2="17"/>
            <polyline points="10 9 9 9 8 9"/>
          </svg>
          <h3>DESCRIÇÃO DA ENTREGA</h3>
        </header>
        <textarea
          v-model="form.descricao"
          rows="6"
          placeholder="Conte o que você fez. Suas decisões. Os passos. Como pode ajudar o time…"
        ></textarea>
      </div>

      <!-- Links -->
      <div class="card card-links">
        <header>
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
            <path d="M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71"/>
            <path d="M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71"/>
          </svg>
          <h3>LINKS DA ENTREGA</h3>
          <span class="hint">GitHub, Figma, Drive, vídeo, sites estudados</span>
        </header>

        <div class="link-list">
          <div v-for="(url, i) in form.urls" :key="i" class="link-row">
            <input v-model="form.urls[i]" type="url" placeholder="https://..." />
            <button v-if="form.urls.length > 1" type="button" class="remove" @click="removeUrl(i)" aria-label="Remover">
              <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round">
                <line x1="6" y1="6" x2="18" y2="18"/>
                <line x1="6" y1="18" x2="18" y2="6"/>
              </svg>
            </button>
          </div>
        </div>
        <button type="button" class="add-btn" @click="addUrl">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round">
            <line x1="12" y1="5" x2="12" y2="19"/>
            <line x1="5" y1="12" x2="19" y2="12"/>
          </svg>
          ADICIONAR LINK
        </button>
      </div>

      <!-- Post-its / Notas -->
      <div class="card card-notes">
        <header>
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
            <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/>
          </svg>
          <h3>POST-ITS DE ESTUDO</h3>
          <span class="hint">Anote insights, ideias, referências rápidas</span>
        </header>

        <div class="notes-wall">
          <div
            v-for="(n, i) in form.notes"
            :key="n.id"
            class="post-it"
            :class="`color-${n.color}`"
            :style="{ '--rot': `${n.rot}deg` }"
          >
            <textarea
              v-model="n.text"
              placeholder="Escreva aqui…"
              rows="4"
            ></textarea>
            <button class="trash" @click="removeNote(i)" aria-label="Remover post-it">
              <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round">
                <line x1="6" y1="6" x2="18" y2="18"/>
                <line x1="6" y1="18" x2="18" y2="6"/>
              </svg>
            </button>
          </div>

          <button class="add-note" @click="addNote">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round">
              <line x1="12" y1="5" x2="12" y2="19"/>
              <line x1="5" y1="12" x2="19" y2="12"/>
            </svg>
            <span>NOVO POST-IT</span>
          </button>
        </div>
      </div>

      <!-- Arquivos -->
      <div class="card card-files">
        <header>
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
            <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/>
            <polyline points="17 8 12 3 7 8"/>
            <line x1="12" y1="3" x2="12" y2="15"/>
          </svg>
          <h3>ARQUIVOS</h3>
          <span class="hint">PDFs, prints, documentos, áudios</span>
        </header>

        <label class="dropzone">
          <input type="file" multiple @change="onFiles" />
          <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
            <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/>
            <polyline points="17 8 12 3 7 8"/>
            <line x1="12" y1="3" x2="12" y2="15"/>
          </svg>
          <span>Arraste arquivos ou <strong>clique para selecionar</strong></span>
        </label>

        <ul v-if="form.files.length" class="file-list">
          <li v-for="(f, i) in form.files" :key="i">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
              <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
              <polyline points="14 2 14 8 20 8"/>
            </svg>
            <span>{{ f.name }}</span>
            <button type="button" @click="form.files.splice(i, 1)" aria-label="Remover">×</button>
          </li>
        </ul>
      </div>

      <!-- Referências -->
      <div class="card card-refs">
        <header>
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
            <path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z"/>
            <path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z"/>
          </svg>
          <h3>REFERÊNCIAS DE ESTUDO</h3>
          <span class="hint">Livros, cursos, vídeos, artigos consultados</span>
        </header>

        <div class="refs-list">
          <div v-for="(r, i) in form.refs" :key="i" class="ref-row">
            <input v-model="r.title" type="text" placeholder="Título / autor" class="ref-title" />
            <input v-model="r.url" type="url" placeholder="Link (opcional)" class="ref-url" />
            <button v-if="form.refs.length > 1" type="button" class="remove" @click="removeRef(i)" aria-label="Remover">
              <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round">
                <line x1="6" y1="6" x2="18" y2="18"/>
                <line x1="6" y1="18" x2="18" y2="6"/>
              </svg>
            </button>
          </div>
        </div>
        <button type="button" class="add-btn" @click="addRef">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round">
            <line x1="12" y1="5" x2="12" y2="19"/>
            <line x1="5" y1="12" x2="19" y2="12"/>
          </svg>
          ADICIONAR REFERÊNCIA
        </button>
      </div>
    </section>

    <!-- Barra de ação -->
    <section class="action-bar">
      <button class="btn-secondary" @click="$emit('cancel')">DESISTIR</button>
      <div class="progress-info">
        <span class="dot" :class="region"></span>
        <span class="key">PROGRESSO DA ENTREGA</span>
        <span class="val">{{ progressLabel }}</span>
      </div>
      <button class="btn-primary" :class="region" @click="$emit('submit', form)">
        <span>ENVIAR ENTREGA</span>
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="9 18 15 12 9 6"/>
        </svg>
      </button>
    </section>
  </div>
</template>

<script setup>
const props = defineProps({
  task: { type: Object, required: true },
  region: { type: String, default: 'ocean' }
})

defineEmits(['submit', 'cancel'])

const profileMap = {
  investigador: { emoji: '🔍', label: 'Investigador' },
  designer: { emoji: '🎨', label: 'Designer' },
  dev: { emoji: '💻', label: 'Dev' },
  lider: { emoji: '🎯', label: 'Líder' },
  comunicador: { emoji: '📢', label: 'Comunicador' },
  estrategista: { emoji: '🧠', label: 'Estrategista' },
  criativo: { emoji: '✨', label: 'Criativo' },
  analista: { emoji: '📊', label: 'Analista' },
  apresentador: { emoji: '🎤', label: 'Apresentador' },
  documentador: { emoji: '📝', label: 'Documentador' }
}

const briefOpen = ref(false)

const noteColors = ['yellow', 'pink', 'blue', 'green', 'orange']

const form = ref({
  descricao: '',
  urls: [''],
  notes: [
    { id: 1, color: 'yellow', text: '', rot: -2 },
    { id: 2, color: 'pink', text: '', rot: 1.5 }
  ],
  files: [],
  refs: [{ title: '', url: '' }]
})

let nextNoteId = 3

const progressLabel = computed(() => {
  let filled = 0
  let total = 5
  if (form.value.descricao.trim().length > 20) filled++
  if (form.value.urls.some(u => u.trim().length > 5)) filled++
  if (form.value.notes.some(n => n.text.trim())) filled++
  if (form.value.files.length > 0) filled++
  if (form.value.refs.some(r => r.title.trim())) filled++
  return `${filled} de ${total} áreas`
})

function addUrl() {
  form.value.urls.push('')
}
function removeUrl(i) {
  form.value.urls.splice(i, 1)
}

function addNote() {
  form.value.notes.push({
    id: nextNoteId++,
    color: noteColors[form.value.notes.length % noteColors.length],
    text: '',
    rot: (Math.random() - 0.5) * 4
  })
}
function removeNote(i) {
  form.value.notes.splice(i, 1)
}

function addRef() {
  form.value.refs.push({ title: '', url: '' })
}
function removeRef(i) {
  form.value.refs.splice(i, 1)
}

function onFiles(e) {
  for (const f of e.target.files) {
    form.value.files.push(f)
  }
}
</script>

<style lang="sass" scoped>
.workspace
  width: 100%
  min-height: calc(100vh - 110px)
  font-family: 'Rajdhani', 'Inter', sans-serif
  display: flex
  flex-direction: column
  gap: 16px

  /* Cor dinâmica baseada na região */
  --rc: var(--game-cyan)
  --rg: var(--game-cyan-glow)

  &.lands
    --rc: var(--game-orange)
    --rg: var(--game-orange-glow)
  &.forest
    --rc: var(--game-green)
    --rg: var(--game-green-glow)
  &.valley
    --rc: var(--game-purple)
    --rg: var(--game-purple-glow)

/* ===== Brief strip ===== */
.brief-strip
  position: relative
  background: rgba(8, 18, 40, 0.7)
  border: 1px solid var(--game-border)
  border-radius: 10px
  padding: 14px 18px
  backdrop-filter: blur(10px)

.brief-toggle
  position: absolute
  top: 14px
  right: 14px
  width: 28px
  height: 28px
  background: rgba(0, 0, 0, 0.4)
  border: 1px solid var(--game-border)
  border-radius: 6px
  color: var(--game-text-dim)
  cursor: pointer
  display: flex
  align-items: center
  justify-content: center

  &:hover
    border-color: var(--rc)
    color: var(--rc)

.brief-head
  display: flex
  align-items: center
  gap: 16px
  padding-right: 40px

  h2
    margin: 0
    flex: 1
    font-family: 'Orbitron', sans-serif
    font-size: 18px
    font-weight: 700
    letter-spacing: 0.5px
    color: var(--game-text)

.profile-tag
  padding: 6px 12px
  background: rgba(0, 0, 0, 0.35)
  border: 1px solid var(--game-border)
  border-radius: 6px
  font-size: 12px
  color: var(--game-text-dim)
  white-space: nowrap

.xp
  font-family: 'Orbitron', sans-serif
  font-size: 12px
  font-weight: 700
  color: var(--game-gold)
  text-shadow: 0 0 6px rgba(255, 200, 69, 0.4)
  white-space: nowrap

.brief-body
  margin-top: 14px
  padding-top: 14px
  border-top: 1px solid rgba(255, 255, 255, 0.06)

  > p
    margin: 0 0 14px
    font-size: 13px
    color: var(--game-text-dim)
    line-height: 1.5

.brief-grid
  display: grid
  grid-template-columns: 1fr 1.2fr
  gap: 24px

  .k
    display: block
    font-family: 'Orbitron', sans-serif
    font-size: 10px
    letter-spacing: 2px
    color: var(--game-text-dim)
    margin-bottom: 6px

  p
    margin: 0
    color: var(--game-text)
    font-size: 13px
    line-height: 1.5

  ul
    margin: 0
    padding: 0
    list-style: none
    display: flex
    flex-direction: column
    gap: 4px

    li
      position: relative
      padding-left: 16px
      color: var(--game-text)
      font-size: 13px
      line-height: 1.4

      &::before
        content: '◆'
        position: absolute
        left: 0
        color: var(--rc)
        font-size: 8px
        top: 4px

/* ===== Desk (workspace) ===== */
.desk
  flex: 1
  display: grid
  grid-template-columns: repeat(6, 1fr)
  grid-auto-rows: minmax(220px, auto)
  gap: 18px

.card
  background: rgba(8, 18, 40, 0.55)
  border: 1px solid var(--game-border)
  border-radius: 12px
  padding: 14px 16px
  backdrop-filter: blur(8px)
  display: flex
  flex-direction: column
  gap: 10px
  transition: border-color 0.2s, box-shadow 0.2s

  &:hover
    border-color: var(--rc)
    box-shadow: 0 0 18px var(--rg)

  header
    display: flex
    align-items: center
    gap: 8px
    color: var(--rc)

    h3
      margin: 0
      font-family: 'Orbitron', sans-serif
      font-size: 12px
      font-weight: 700
      letter-spacing: 1.5px
      color: var(--game-text)

    .hint
      margin-left: auto
      font-size: 11px
      color: var(--game-text-dim)
      font-style: italic

.card-description
  grid-column: span 3

  textarea
    flex: 1
    min-height: 130px

.card-links
  grid-column: span 3

.card-notes
  grid-column: span 6

.card-files
  grid-column: span 3

.card-refs
  grid-column: span 3

/* ===== Inputs ===== */
textarea, input[type="text"], input[type="url"]
  background: rgba(0, 0, 0, 0.4)
  border: 1px solid var(--game-border)
  border-radius: 8px
  padding: 10px 12px
  color: var(--game-text)
  font-family: inherit
  font-size: 13px
  outline: none
  transition: border-color 0.2s, box-shadow 0.2s
  width: 100%

  &:focus
    border-color: var(--rc)
    box-shadow: 0 0 10px var(--rg)

  &::placeholder
    color: var(--game-text-dim)

textarea
  resize: vertical
  line-height: 1.5

/* ===== Links list ===== */
.link-list, .refs-list
  display: flex
  flex-direction: column
  gap: 8px

.link-row, .ref-row
  display: flex
  align-items: center
  gap: 8px

.ref-row
  display: grid
  grid-template-columns: 1.2fr 1.4fr 30px
  gap: 8px

.remove
  width: 30px
  height: 30px
  background: rgba(0, 0, 0, 0.4)
  border: 1px solid var(--game-border)
  border-radius: 6px
  color: var(--game-text-dim)
  cursor: pointer
  display: flex
  align-items: center
  justify-content: center
  flex-shrink: 0

  &:hover
    border-color: var(--game-orange)
    color: var(--game-orange)

.add-btn
  margin-top: 4px
  display: inline-flex
  align-items: center
  gap: 6px
  padding: 8px 12px
  background: transparent
  border: 1px dashed var(--game-border)
  border-radius: 6px
  color: var(--game-text-dim)
  font-family: 'Orbitron', sans-serif
  font-size: 10px
  font-weight: 600
  letter-spacing: 1px
  cursor: pointer
  align-self: flex-start
  transition: all 0.2s

  &:hover
    border-color: var(--rc)
    color: var(--rc)

/* ===== Post-its ===== */
.notes-wall
  display: flex
  flex-wrap: wrap
  gap: 14px
  padding: 8px 4px

.post-it
  position: relative
  width: 180px
  height: 180px
  padding: 14px 12px 12px
  border-radius: 4px
  transform: rotate(var(--rot, 0))
  box-shadow: 0 6px 14px rgba(0, 0, 0, 0.35), 0 1px 2px rgba(0, 0, 0, 0.2)
  transition: transform 0.2s, box-shadow 0.2s
  font-family: 'Caveat', 'Rajdhani', cursive

  &:hover
    transform: rotate(0) translateY(-4px)
    box-shadow: 0 12px 22px rgba(0, 0, 0, 0.4)
    z-index: 2

  &.color-yellow
    background: linear-gradient(180deg, #FFE57A, #FFD93D)
  &.color-pink
    background: linear-gradient(180deg, #FFB7D5, #FF8FBE)
  &.color-blue
    background: linear-gradient(180deg, #A8E0FF, #6BC5F0)
  &.color-green
    background: linear-gradient(180deg, #B4F0A8, #7FD96B)
  &.color-orange
    background: linear-gradient(180deg, #FFCB91, #FFA959)

  textarea
    width: 100%
    height: 100%
    background: transparent
    border: none
    color: #2b1a00
    font-family: inherit
    font-size: 15px
    line-height: 1.35
    padding: 0
    resize: none
    outline: none

    &::placeholder
      color: rgba(43, 26, 0, 0.45)
      font-style: italic

    &:focus
      box-shadow: none

  .trash
    position: absolute
    top: 4px
    right: 4px
    width: 22px
    height: 22px
    background: rgba(0, 0, 0, 0.12)
    border: none
    border-radius: 4px
    color: rgba(43, 26, 0, 0.7)
    cursor: pointer
    display: flex
    align-items: center
    justify-content: center
    opacity: 0
    transition: opacity 0.2s

  &:hover .trash
    opacity: 1

.add-note
  display: flex
  flex-direction: column
  align-items: center
  justify-content: center
  gap: 6px
  width: 180px
  height: 180px
  background: rgba(255, 255, 255, 0.03)
  border: 2px dashed var(--game-border)
  border-radius: 4px
  color: var(--game-text-dim)
  font-family: 'Orbitron', sans-serif
  font-size: 10px
  font-weight: 600
  letter-spacing: 1px
  cursor: pointer
  transition: all 0.2s

  &:hover
    border-color: var(--rc)
    color: var(--rc)
    background: rgba(0, 212, 255, 0.04)

/* ===== Dropzone ===== */
.dropzone
  display: flex
  flex-direction: column
  align-items: center
  justify-content: center
  gap: 8px
  padding: 18px
  background: rgba(0, 0, 0, 0.25)
  border: 1.5px dashed var(--game-border)
  border-radius: 8px
  color: var(--game-text-dim)
  font-size: 13px
  text-align: center
  cursor: pointer
  transition: all 0.2s

  &:hover
    border-color: var(--rc)
    background: rgba(0, 212, 255, 0.04)

  input
    display: none

  strong
    color: var(--rc)

.file-list
  list-style: none
  margin: 0
  padding: 0
  display: flex
  flex-direction: column
  gap: 4px

  li
    display: flex
    align-items: center
    gap: 8px
    padding: 6px 10px
    background: rgba(0, 0, 0, 0.3)
    border: 1px solid var(--game-border)
    border-radius: 6px
    color: var(--game-text)
    font-size: 12px

    button
      margin-left: auto
      background: transparent
      border: none
      color: var(--game-text-dim)
      cursor: pointer
      font-size: 18px

      &:hover
        color: var(--game-orange)

/* ===== Action bar ===== */
.action-bar
  display: grid
  grid-template-columns: auto 1fr auto
  align-items: center
  gap: 16px
  padding: 14px 18px
  background: rgba(8, 18, 40, 0.7)
  border: 1px solid var(--game-border)
  border-radius: 10px
  backdrop-filter: blur(10px)

.progress-info
  display: flex
  align-items: center
  gap: 8px
  justify-self: center

  .dot
    width: 8px
    height: 8px
    border-radius: 50%
    background: var(--rc)
    box-shadow: 0 0 8px var(--rg)

  .key
    font-family: 'Orbitron', sans-serif
    font-size: 10px
    letter-spacing: 2px
    color: var(--game-text-dim)

  .val
    font-family: 'Orbitron', sans-serif
    font-size: 12px
    font-weight: 700
    color: var(--rc)

.btn-secondary
  padding: 12px 22px
  background: transparent
  border: 1px solid var(--game-border)
  border-radius: 8px
  color: var(--game-text-dim)
  font-family: 'Orbitron', sans-serif
  font-size: 11px
  font-weight: 700
  letter-spacing: 1.5px
  cursor: pointer
  transition: all 0.2s

  &:hover
    border-color: var(--game-orange)
    color: var(--game-orange)

.btn-primary
  display: inline-flex
  align-items: center
  gap: 10px
  padding: 12px 22px
  background: rgba(0, 0, 0, 0.4)
  border: 1px solid var(--rc)
  border-radius: 8px
  color: var(--rc)
  font-family: 'Orbitron', sans-serif
  font-size: 12px
  font-weight: 700
  letter-spacing: 1.5px
  cursor: pointer
  text-shadow: 0 0 6px var(--rg)
  box-shadow: 0 0 14px var(--rg), inset 0 0 8px rgba(255, 255, 255, 0.05)
  transition: all 0.2s

  &:hover
    background: rgba(255, 255, 255, 0.05)
    box-shadow: 0 0 24px var(--rg)
    transform: translateY(-1px)

@media screen and (max-width: 1200px)
  .desk
    grid-template-columns: repeat(2, 1fr)

    .card-description, .card-links, .card-files, .card-refs
      grid-column: span 1

    .card-notes
      grid-column: span 2

@media screen and (max-width: 720px)
  .desk
    grid-template-columns: 1fr

    .card-description, .card-links, .card-files, .card-refs, .card-notes
      grid-column: span 1
</style>
