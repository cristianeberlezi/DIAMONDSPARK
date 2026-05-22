import { defineNuxtConfig } from 'nuxt/config'

export default defineNuxtConfig({
  devtools: { enabled: false },
  ssr: true,
  debug: false,
  css: ['~/assets/css/index.sass'],
  components: {
    dirs: [
      '~/components/global',
      '~/components/pages',
      { path: '~/components/dashboard', prefix: 'Dashboard' },
      { path: '~/components/maps', prefix: 'Maps' },
      { path: '~/components/game', prefix: 'Game' },
      { path: '~/components/auth', prefix: 'Auth' },
      { path: '~/components/onboarding', prefix: 'Onb' },
      { path: '~/components/admin', prefix: 'Admin' }
    ]
  },
  build: {
    transpile: ['vue3-apexcharts']
  },
  experimental: {
    payloadExtraction: false,
    viewTransition: true
  },
  modules: ['@pinia/nuxt', '@nuxt/image', '@nuxtjs/supabase'],
  supabase: {
    url: process.env.SUPABASE_URL,
    key: process.env.SUPABASE_KEY,
    redirect: false  // controlamos os redirects manualmente
  },
  image: {
    quality: 80,
    format: ['webp', 'avif', 'png', 'jpg'],
    densities: [1, 2]
  },
  nitro: {
    compressPublicAssets: true,
    minify: true,
    storage: {
      memory: {
        driver: 'memory'
      }
    }
  },
  compatibilityDate: '2025-04-03'
})
