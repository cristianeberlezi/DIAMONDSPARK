-- =====================================================
-- ProfessoOnline · Tabela profiles
-- Roles: 'aluno' | 'professor'
-- Cole este SQL no Supabase → SQL Editor → Run
-- =====================================================

-- 1) TABELA PROFILES
create table if not exists public.profiles (
  id uuid references auth.users on delete cascade primary key,
  name text not null,
  email text not null unique,
  role text not null check (role in ('aluno', 'professor')) default 'aluno',
  avatar_url text,
  -- Perfil Holland (RIASEC) descoberto no onboarding
  character_profile char(1) check (character_profile in ('R', 'I', 'A', 'S', 'E', 'C')),
  level int not null default 1,
  xp int not null default 0,
  coins int not null default 0,
  gems int not null default 0,
  energy int not null default 120,
  onboarding_done boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- 2) RLS (Row Level Security)
alter table public.profiles enable row level security;

-- Qualquer pessoa autenticada pode ler perfis (pra ver colegas, ranking, etc.)
drop policy if exists "Profiles visíveis para usuários autenticados" on public.profiles;
create policy "Profiles visíveis para usuários autenticados"
  on public.profiles for select
  using (auth.role() = 'authenticated');

-- O próprio usuário só pode atualizar o próprio profile
drop policy if exists "Usuário atualiza próprio profile" on public.profiles;
create policy "Usuário atualiza próprio profile"
  on public.profiles for update
  using (auth.uid() = id);

-- Professor pode atualizar qualquer profile (pra correções, banimentos, etc.)
drop policy if exists "Professor atualiza qualquer profile" on public.profiles;
create policy "Professor atualiza qualquer profile"
  on public.profiles for update
  using (
    exists (
      select 1 from public.profiles
      where id = auth.uid() and role = 'professor'
    )
  );

-- 3) TRIGGER: cria profile automaticamente ao registrar usuário
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, name, email, role)
  values (
    new.id,
    coalesce(new.raw_user_meta_data->>'name', split_part(new.email, '@', 1)),
    new.email,
    coalesce(new.raw_user_meta_data->>'role', 'aluno')
  );
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

-- 4) TRIGGER: atualiza updated_at automaticamente
create or replace function public.handle_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists profiles_updated_at on public.profiles;
create trigger profiles_updated_at
  before update on public.profiles
  for each row execute procedure public.handle_updated_at();

-- 5) ÍNDICES
create index if not exists profiles_role_idx on public.profiles(role);
create index if not exists profiles_email_idx on public.profiles(email);
