<template>
  <div class="board">
    <!-- biomas como camadas de fundo -->
    <div class="biome biome-ocean"></div>
    <div class="biome biome-beach"></div>
    <div class="biome biome-forest"></div>
    <div class="biome biome-mountain"></div>

    <!-- decorações sutis -->
    <div class="deco deco-waves"></div>
    <div class="deco deco-trees"></div>
    <div class="deco deco-peaks"></div>

    <!-- SVG com os caminhos conectando os nós -->
    <svg class="paths" viewBox="0 0 1200 560" preserveAspectRatio="none">
      <g stroke="rgba(255,255,255,0.9)" stroke-width="3" stroke-dasharray="2 6" fill="none" stroke-linecap="round">
        <!-- oceano -->
        <path d="M60,140 Q120,80 170,130 Q230,170 280,150 Q330,210 240,260 Q160,260 90,280 Q50,330 130,360 Q200,380 230,420" />
        <!-- floresta (centro) -->
        <path d="M460,220 Q540,160 620,200 Q700,150 760,200 Q820,240 870,260 Q900,300 830,330 Q780,360 720,360 Q660,380 700,430 Q780,460 870,430" />
        <!-- montanhas -->
        <path d="M970,180 Q1040,160 1090,210 Q1140,260 1090,330 Q1040,400 1130,440" />
      </g>
    </svg>

    <!-- nós do oceano -->
    <div class="node" v-for="n in oceanNodes" :key="n.label" :style="{ left: n.x + '%', top: n.y + '%', background: n.bg }">
      <span class="emoji">{{ n.emoji }}</span>
    </div>

    <!-- nós da floresta -->
    <div class="node node-forest" v-for="n in forestNodes" :key="n.label" :style="{ left: n.x + '%', top: n.y + '%' }">
      <span class="emoji">{{ n.emoji }}</span>
    </div>

    <!-- nós das montanhas (locked) -->
    <div class="node node-mountain" v-for="n in mountainNodes" :key="n.label" :style="{ left: n.x + '%', top: n.y + '%' }">
      <span class="emoji">{{ n.emoji }}</span>
    </div>

    <!-- cartão "Ma Collection" -->
    <div class="card-collection">
      <div class="card-inner">
        <span class="emoji-lg">🦫</span>
      </div>
      <p>Ma Collection</p>
      <div class="cursor">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="#180802">
          <path d="M5 3l14 8-6 2-2 6z"/>
        </svg>
      </div>
    </div>
  </div>
</template>

<script setup>
const oceanNodes = [
  { label: 'otter', x: 5, y: 16, emoji: '🦦', bg: '#7BC4E8' },
  { label: 'seal', x: 13, y: 18, emoji: '🦭', bg: '#5BA3CF' },
  { label: 'whale', x: 6, y: 38, emoji: '🐋', bg: '#85CEF0' },
  { label: 'dolphin', x: 23, y: 26, emoji: '🐬', bg: '#7AA3FF' },
  { label: 'fish', x: 19, y: 36, emoji: '🐠', bg: '#E94B6B' },
  { label: 'frog', x: 13, y: 44, emoji: '🐸', bg: '#8FE08F' },
  { label: 'jelly', x: 5, y: 58, emoji: '🪼', bg: '#C7A0F0' },
  { label: 'crab', x: 8, y: 73, emoji: '🦀', bg: '#FFB68F' },
  { label: 'star', x: 4, y: 86, emoji: '⭐', bg: '#FFC95E' },
  { label: 'octopus', x: 16, y: 84, emoji: '🐙', bg: '#7A5BCF' }
]

const forestNodes = [
  { label: 'f1', x: 39, y: 22, emoji: '🌳' },
  { label: 'f2', x: 47, y: 30, emoji: '🌲' },
  { label: 'f3', x: 55, y: 26, emoji: '🌳' },
  { label: 'f4', x: 63, y: 30, emoji: '🌲' },
  { label: 'f5', x: 71, y: 36, emoji: '🌳' },
  { label: 'f6', x: 67, y: 50, emoji: '🌲' },
  { label: 'f7', x: 58, y: 58, emoji: '🌳' },
  { label: 'f8', x: 50, y: 50, emoji: '🌲' },
  { label: 'f9', x: 43, y: 60, emoji: '🌳' },
  { label: 'f10', x: 55, y: 72, emoji: '🌲' },
  { label: 'f11', x: 65, y: 76, emoji: '🌳' },
  { label: 'f12', x: 73, y: 70, emoji: '🌲' }
]

const mountainNodes = [
  { label: 'm1', x: 80, y: 28, emoji: '⛰️' },
  { label: 'm2', x: 87, y: 34, emoji: '⛰️' },
  { label: 'm3', x: 93, y: 44, emoji: '🔒' },
  { label: 'm4', x: 87, y: 56, emoji: '🔒' },
  { label: 'm5', x: 82, y: 68, emoji: '🔒' },
  { label: 'm6', x: 90, y: 78, emoji: '🔒' }
]
</script>

<style lang="sass" scoped>
.board
  position: relative
  width: 100%
  height: 100%
  border-radius: 20px
  overflow: hidden
  background: #1a1f3a

.biome
  position: absolute
  top: 0
  bottom: 0

.biome-ocean
  left: 0
  width: 28%
  background: linear-gradient(180deg, #4DB3D9 0%, #2E7AB8 50%, #1F5C9C 100%)

.biome-beach
  left: 25%
  width: 18%
  background: linear-gradient(135deg, #F4D169 0%, #E8A95C 60%, #D88A4A 100%)
  clip-path: polygon(15% 0, 85% 0, 100% 100%, 0 100%)

.biome-forest
  left: 38%
  width: 42%
  background: radial-gradient(ellipse at 50% 60%, #6FBE5E 0%, #3F9846 50%, #2A6B33 100%)

.biome-mountain
  right: 0
  width: 26%
  background: linear-gradient(180deg, #6B4EAA 0%, #4A2D8C 60%, #2F1B66 100%)

.deco
  position: absolute
  inset: 0
  pointer-events: none
  opacity: 0.35

.deco-waves
  background: repeating-radial-gradient(circle at 12% 30%, transparent 0, transparent 14px, rgba(255,255,255,0.08) 14px, rgba(255,255,255,0.08) 16px)
  width: 28%

.deco-trees
  left: 38%
  width: 42%
  background-image: radial-gradient(circle at 20% 20%, rgba(0,40,0,0.25) 0 6px, transparent 7px), radial-gradient(circle at 40% 30%, rgba(0,40,0,0.25) 0 8px, transparent 9px), radial-gradient(circle at 60% 50%, rgba(0,40,0,0.25) 0 5px, transparent 6px), radial-gradient(circle at 80% 40%, rgba(0,40,0,0.25) 0 7px, transparent 8px)

.deco-peaks
  right: 0
  width: 26%
  background-image: linear-gradient(135deg, transparent 60%, rgba(255,255,255,0.08) 60%, rgba(255,255,255,0.08) 64%, transparent 64%)

.paths
  position: absolute
  inset: 0
  width: 100%
  height: 100%

.node
  position: absolute
  width: 56px
  height: 56px
  border-radius: 50%
  background: #FFFFFF
  border: 4px solid #FFFFFF
  box-shadow: 0 4px 10px rgba(0,0,0,0.2)
  display: flex
  align-items: center
  justify-content: center
  transform: translate(-50%, -50%)
  cursor: pointer
  transition: transform 0.15s

  &:hover
    transform: translate(-50%, -50%) scale(1.06)

  .emoji
    font-size: 28px
    line-height: 1

.node-forest
  width: 38px
  height: 38px
  background: #6FBE5E
  border: 3px solid #FFFFFF

  .emoji
    font-size: 18px

.node-mountain
  width: 44px
  height: 44px
  background: #C7B8E8
  border: 3px solid #FFFFFF

  .emoji
    font-size: 20px
    filter: grayscale(0.2)

.card-collection
  position: absolute
  left: 28%
  top: 36%
  transform: translate(-50%, -50%)
  background: #D9E2FB
  border-radius: 16px
  padding: 12px 12px 8px
  width: 140px
  text-align: center
  box-shadow: 0 8px 20px rgba(0,0,0,0.25)

  .card-inner
    background: #FFFFFF
    border-radius: 12px
    padding: 16px
    margin-bottom: 8px
    display: flex
    align-items: center
    justify-content: center

  .emoji-lg
    font-size: 44px
    line-height: 1

  p
    margin: 0
    color: #180802
    font-weight: 700
    font-size: 13px

.cursor
  position: absolute
  bottom: -8px
  right: -2px
</style>
