// Middleware: exige usuário com role 'professor'
// Uso: definePageMeta({ middleware: ['auth', 'professor'] })

export default defineNuxtRouteMiddleware(async () => {
  const supabase = useSupabaseClient()

  // Resolve userId via ref ou sessão (mais robusto que confiar só no ref)
  const user = useSupabaseUser()
  let userId = user.value?.id
  if (!userId) {
    const { data } = await supabase.auth.getSession()
    userId = data?.session?.user?.id
  }
  if (!userId) return navigateTo('/')

  const { data: profile } = await supabase
    .from('profiles')
    .select('role')
    .eq('id', userId)
    .single()

  if (profile?.role !== 'professor') {
    return navigateTo('/game')
  }
})
