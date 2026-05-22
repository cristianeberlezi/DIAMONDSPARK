// Middleware: exige usuário autenticado
// Uso: definePageMeta({ middleware: 'auth' })

export default defineNuxtRouteMiddleware((to) => {
  const user = useSupabaseUser()

  if (!user.value) {
    return navigateTo('/login')
  }
})
