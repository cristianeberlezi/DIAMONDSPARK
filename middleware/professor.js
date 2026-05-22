// Middleware: exige usuário com role 'professor'
// Uso: definePageMeta({ middleware: ['auth', 'professor'] })

export default defineNuxtRouteMiddleware(async () => {
  const user = useSupabaseUser()
  if (!user.value) return navigateTo('/login')

  const supabase = useSupabaseClient()
  const { data: profile } = await supabase
    .from('profiles')
    .select('role')
    .eq('id', user.value.id)
    .single()

  if (profile?.role !== 'professor') {
    return navigateTo('/game')
  }
})
