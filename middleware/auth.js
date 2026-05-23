// Middleware: exige usuário autenticado
// Uso: definePageMeta({ middleware: 'auth' })

export default defineNuxtRouteMiddleware(async () => {
  const user = useSupabaseUser()
  if (user.value?.id) return

  // Fallback: o ref do @nuxtjs/supabase pode não ter sincronizado ainda.
  // Checa a sessão direto no client antes de bouncer.
  const supabase = useSupabaseClient()
  const { data } = await supabase.auth.getSession()
  if (data?.session?.user?.id) return

  return navigateTo('/')
})
