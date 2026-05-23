<template>
  <NuxtLayout>
    <NuxtPage />
  </NuxtLayout>
</template>

<script setup>
useHead({
  htmlAttrs: {
    lang: 'pt-BR'
  },
  title: 'Diamond Spark',
  meta: [
    { charset: 'utf-8' },
    { 'http-equiv': 'X-UA-Compatible', content: 'IE=edge' },
    { name: 'viewport', content: 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=yes' },
    { name: 'format-detection', content: 'telephone=no' },
    { name: 'HandheldFriendly', content: 'true' },
    { name: 'theme-color', content: '#00D4FF' },
    { name: 'msapplication-TileColor', content: '#050B1A' },
    { name: 'msapplication-navbutton-color', content: '#050B1A' },
    { name: 'apple-mobile-web-app-capable', content: 'yes' },
    { name: 'apple-mobile-web-app-status-bar-style', content: 'black-translucent' },
    { name: 'mobile-web-app-capable', content: 'yes' },
    { name: 'apple-mobile-web-app-title', content: 'Diamond Spark' },
    { name: 'application-name', content: 'Diamond Spark' },
    { name: 'description', content: 'Plataforma educacional gamificada. Descubra seu perfil, evolua seu personagem e aprenda jogando.' },
    { name: 'keywords', content: 'professor online, diamond spark, educação, gamificação, riasec, holland, aprendizado' },
    { name: 'robots', content: 'index, follow' },
    { name: 'googlebot', content: 'index, follow, max-image-preview:large' },
    { name: 'author', content: 'Diamond Spark' },
    { property: 'og:type', content: 'website' },
    { property: 'og:title', content: 'Diamond Spark' },
    { property: 'og:description', content: 'Plataforma educacional gamificada. Descubra seu perfil, evolua seu personagem e aprenda jogando.' },
    { property: 'og:site_name', content: 'Diamond Spark' },
    { property: 'og:locale', content: 'pt_BR' },
    { property: 'og:url', content: 'https://diamond-spark.vercel.app' },
    { property: 'og:image', content: 'https://diamond-spark.vercel.app/favicon.svg' },
    { property: 'og:image:type', content: 'image/svg+xml' },
    { property: 'og:image:alt', content: 'Diamond Spark' },
    { name: 'twitter:card', content: 'summary' },
    { name: 'twitter:title', content: 'Diamond Spark' },
    { name: 'twitter:description', content: 'Plataforma educacional gamificada. Descubra seu perfil, evolua seu personagem e aprenda jogando.' },
    { name: 'twitter:image', content: 'https://diamond-spark.vercel.app/favicon.svg' }
  ],
  link: [
    { rel: 'canonical', href: 'https://diamond-spark.vercel.app' },
    { rel: 'icon', type: 'image/svg+xml', href: '/favicon.svg' },
    { rel: 'alternate icon', type: 'image/x-icon', href: '/favicons/favicon.ico' },
    { rel: 'apple-touch-icon', href: '/favicon.svg' },
    { rel: 'mask-icon', href: '/favicon.svg', color: '#00D4FF' }
  ]
})

onMounted(() => {
  if (process.client) {
    watch(
      () => useRoute().path,
      () => {
        window.scrollTo(0, 0)
      }
    )
  }
})
</script>
