-- =====================================================
-- ProfessoOnline · Onboarding (Steps + Questions + Respostas)
-- 15 steps: 6 Holland (RIASEC) + 9 Inteligências Múltiplas
-- Cole tudo no Supabase → SQL Editor → Run
-- =====================================================

-- 1) TABELA STEPS
create table if not exists public.onboarding_steps (
  id serial primary key,
  order_num int not null unique,
  category text not null check (category in ('holland', 'intelligence')),
  code text not null unique,        -- 'R','I','A','S','E','C','NAT','MUS','LOG','EXI','INT','COR','LIN','INA','ESP'
  title text not null,              -- 'Realista', 'Musical', etc.
  description text,
  color text,
  created_at timestamptz not null default now()
);

-- 2) TABELA QUESTIONS
create table if not exists public.onboarding_questions (
  id serial primary key,
  step_id int not null references public.onboarding_steps(id) on delete cascade,
  order_num int not null,
  text text not null,
  created_at timestamptz not null default now(),
  unique(step_id, order_num)
);

-- 3) TABELA RESPONSES (resposta do aluno)
create table if not exists public.onboarding_responses (
  id serial primary key,
  user_id uuid not null references auth.users on delete cascade,
  question_id int not null references public.onboarding_questions(id) on delete cascade,
  answer boolean not null,           -- sim / não
  created_at timestamptz not null default now(),
  unique(user_id, question_id)       -- 1 resposta por usuário/pergunta
);

-- 4) RLS
alter table public.onboarding_steps enable row level security;
alter table public.onboarding_questions enable row level security;
alter table public.onboarding_responses enable row level security;

-- Steps e questions: qualquer autenticado pode ler
drop policy if exists "Steps públicos para autenticados" on public.onboarding_steps;
create policy "Steps públicos para autenticados"
  on public.onboarding_steps for select
  using (auth.role() = 'authenticated');

drop policy if exists "Questions públicas para autenticados" on public.onboarding_questions;
create policy "Questions públicas para autenticados"
  on public.onboarding_questions for select
  using (auth.role() = 'authenticated');

-- Respostas: usuário só vê e edita as próprias
drop policy if exists "Próprias respostas visíveis" on public.onboarding_responses;
create policy "Próprias respostas visíveis"
  on public.onboarding_responses for select
  using (auth.uid() = user_id);

drop policy if exists "Inserir própria resposta" on public.onboarding_responses;
create policy "Inserir própria resposta"
  on public.onboarding_responses for insert
  with check (auth.uid() = user_id);

drop policy if exists "Atualizar própria resposta" on public.onboarding_responses;
create policy "Atualizar própria resposta"
  on public.onboarding_responses for update
  using (auth.uid() = user_id);

-- Professor pode ler todas as respostas (pra análise pedagógica)
drop policy if exists "Professor lê todas respostas" on public.onboarding_responses;
create policy "Professor lê todas respostas"
  on public.onboarding_responses for select
  using (
    exists (
      select 1 from public.profiles
      where id = auth.uid() and role = 'professor'
    )
  );

-- 5) ÍNDICES
create index if not exists onboarding_questions_step_idx on public.onboarding_questions(step_id);
create index if not exists onboarding_responses_user_idx on public.onboarding_responses(user_id);

-- =====================================================
-- 6) SEED DOS STEPS
-- =====================================================
insert into public.onboarding_steps (order_num, category, code, title, description, color) values
  (1,  'holland',      'R',   'Realista',         'O Construtor — mãos na massa, tecnologia, mundo físico',         '#56C8FF'),
  (2,  'holland',      'I',   'Investigativo',    'O Pesquisador — análise, dados, ciência, problemas complexos',   '#B86CFF'),
  (3,  'holland',      'A',   'Artístico',        'O Criador — expressão, design, originalidade',                   '#E94B8C'),
  (4,  'holland',      'S',   'Social',           'O Conector — pessoas, ensino, impacto coletivo',                 '#6FE36F'),
  (5,  'holland',      'E',   'Empreendedor',     'O Inovador — liderança, vendas, novos negócios',                 '#FFC845'),
  (6,  'holland',      'C',   'Convencional',     'O Organizador — método, processo, precisão',                     '#7AB8FF'),
  (7,  'intelligence', 'NAT', 'Naturalista',      'Conexão com natureza, ecologia, classificação',                  '#6FE36F'),
  (8,  'intelligence', 'MUS', 'Musical',          'Ritmo, melodia, sons, padrões sonoros',                          '#E94B8C'),
  (9,  'intelligence', 'LOG', 'Lógico-Matemática','Raciocínio lógico, padrões, resolução de problemas',             '#00D4FF'),
  (10, 'intelligence', 'EXI', 'Existencial',      'Propósito, ética, impacto no mundo',                             '#FFB347'),
  (11, 'intelligence', 'INT', 'Interpessoal',     'Empatia, colaboração, construção de relações',                   '#9BD17E'),
  (12, 'intelligence', 'COR', 'Corporal-Cinestésica','Coordenação, movimento, interação física',                    '#FF8A3D'),
  (13, 'intelligence', 'LIN', 'Linguística',      'Comunicação, escrita, expressão de ideias',                      '#A8E0FF'),
  (14, 'intelligence', 'INA', 'Intrapessoal',     'Autoconhecimento, foco, inteligência emocional',                 '#B86CFF'),
  (15, 'intelligence', 'ESP', 'Espacial',         'Visualizar, criar e manipular formas e espaços',                 '#C7A0F0')
on conflict (code) do update set
  title = excluded.title,
  description = excluded.description,
  color = excluded.color,
  order_num = excluded.order_num;

-- =====================================================
-- 7) SEED DAS PERGUNTAS
-- (limpa e recria pra ser idempotente)
-- =====================================================
delete from public.onboarding_questions;

-- Step 1 - Realista
insert into public.onboarding_questions (step_id, order_num, text) values
  ((select id from public.onboarding_steps where code='R'), 1, 'Mexer, brincar e ver vídeos sobre carros, motos ou bicicletas.'),
  ((select id from public.onboarding_steps where code='R'), 2, 'Cuidar, tratar e interagir com animais de todos os tipos no dia a dia.'),
  ((select id from public.onboarding_steps where code='R'), 3, 'Aprender a construir coisas e criar estruturas do zero.'),
  ((select id from public.onboarding_steps where code='R'), 4, 'Juntar peças e montar objetos que vêm totalmente desmontados.'),
  ((select id from public.onboarding_steps where code='R'), 5, 'Aprender a cozinhar ou criar novas receitas para o inventário.'),
  ((select id from public.onboarding_steps where code='R'), 6, 'Resolver e fazer as coisas de forma rápida, sem enrolação.'),
  ((select id from public.onboarding_steps where code='R'), 7, 'Passear e fazer atividades ao ar livre, em contato com a natureza.');

-- Step 2 - Investigativo
insert into public.onboarding_questions (step_id, order_num, text) values
  ((select id from public.onboarding_steps where code='I'), 1, 'Resolver quebra-cabeças, desafios de lógica ou mistérios complexos.'),
  ((select id from public.onboarding_steps where code='I'), 2, 'Testar, experimentar e entender como os mecanismos funcionam.'),
  ((select id from public.onboarding_steps where code='I'), 3, 'Estudar e aprender sobre Ciências (Biologia, Química ou Física).'),
  ((select id from public.onboarding_steps where code='I'), 4, 'Abrir equipamentos ou ver vídeos sobre como as máquinas são por dentro.'),
  ((select id from public.onboarding_steps where code='I'), 5, 'Ficar pensando, analisando e imaginando situações e problemas do dia a dia.'),
  ((select id from public.onboarding_steps where code='I'), 6, 'Criar ou aprender sobre números, planilhas, gráficos e estatísticas.'),
  ((select id from public.onboarding_steps where code='I'), 7, 'Dedicar seu tempo para estudar e aprender Matemática.');

-- Step 3 - Artístico
insert into public.onboarding_questions (step_id, order_num, text) values
  ((select id from public.onboarding_steps where code='A'), 1, 'Fazer atividades, jogos e trabalhos da escola totalmente sozinho(a).'),
  ((select id from public.onboarding_steps where code='A'), 2, 'Ler ou ver vídeos sobre bandas, artistas, filmes e músicas.'),
  ((select id from public.onboarding_steps where code='A'), 3, 'Escrever redações, histórias, fanfics ou poemas.'),
  ((select id from public.onboarding_steps where code='A'), 4, 'Pensar em formas diferentes ou totalmente novas de fazer as coisas.'),
  ((select id from public.onboarding_steps where code='A'), 5, 'Assistir, participar ou criar teatro, vídeos, danças ou apresentações.'),
  ((select id from public.onboarding_steps where code='A'), 6, 'Desenhar, pintar e ilustrar no tempo livre ou durante as aulas.'),
  ((select id from public.onboarding_steps where code='A'), 7, 'Tocar instrumentos musicais ou soltar a voz cantando suas músicas favoritas.');

-- Step 4 - Social
insert into public.onboarding_questions (step_id, order_num, text) values
  ((select id from public.onboarding_steps where code='S'), 1, 'Fazer atividades, jogos e trabalhos da escola em grupos ou equipes.'),
  ((select id from public.onboarding_steps where code='S'), 2, 'Ajudar as pessoas a aprender e compartilhar seus conhecimentos com amigos.'),
  ((select id from public.onboarding_steps where code='S'), 3, 'Ouvir, dar conselhos e ajudar a resolver os problemas de outras pessoas.'),
  ((select id from public.onboarding_steps where code='S'), 4, 'Aprender a cuidar de pessoas e estudar sobre medicina e o corpo humano.'),
  ((select id from public.onboarding_steps where code='S'), 5, 'Saber sobre outros países, idiomas e culturas diferentes.'),
  ((select id from public.onboarding_steps where code='S'), 6, 'Falar e ouvir sobre os assuntos mais variados possíveis.'),
  ((select id from public.onboarding_steps where code='S'), 7, 'Fazer boas ações no dia a dia ou se voluntariar para ajudar quem precisa.');

-- Step 5 - Empreendedor
insert into public.onboarding_questions (step_id, order_num, text) values
  ((select id from public.onboarding_steps where code='E'), 1, 'Definir e ir atrás das suas próprias metas e objetivos pessoais.'),
  ((select id from public.onboarding_steps where code='E'), 2, 'Convencer as pessoas sobre suas ideias ou projetos que quer realizar.'),
  ((select id from public.onboarding_steps where code='E'), 3, 'Ajudar a vender rifas, doces e o que mais for necessário.'),
  ((select id from public.onboarding_steps where code='E'), 4, 'Assumir a liderança de projetos, atividades e trabalhos de aula.'),
  ((select id from public.onboarding_steps where code='E'), 5, 'Imaginar e planejar como seria ter seu próprio negócio, marca ou canal social.'),
  ((select id from public.onboarding_steps where code='E'), 6, 'Ser responsável por organizar prazos e distribuir tarefas nos trabalhos em grupo.'),
  ((select id from public.onboarding_steps where code='E'), 7, 'Falar ou se apresentar para grandes grupos de pessoas.');

-- Step 6 - Convencional
insert into public.onboarding_questions (step_id, order_num, text) values
  ((select id from public.onboarding_steps where code='C'), 1, 'Organizar e manter arrumadas todas as suas coisas (casa ou escola).'),
  ((select id from public.onboarding_steps where code='C'), 2, 'Realizar tarefas quando te dizem exatamente o que e como deve ser feito.'),
  ((select id from public.onboarding_steps where code='C'), 3, 'Ficar bastante tempo em um mesmo ambiente (casa, escola ou trabalho).'),
  ((select id from public.onboarding_steps where code='C'), 4, 'Prestar atenção em cada pequeno detalhe de tudo ao seu redor.'),
  ((select id from public.onboarding_steps where code='C'), 5, 'Digitar ou organizar documentos e arquivos importantes.'),
  ((select id from public.onboarding_steps where code='C'), 6, 'Registrar e anotar todas as coisas que você faz no dia a dia.'),
  ((select id from public.onboarding_steps where code='C'), 7, 'Fazer atividades em lugares calmos, organizados e com seu próprio espaço.');

-- Step 7 - Naturalista
insert into public.onboarding_questions (step_id, order_num, text) values
  ((select id from public.onboarding_steps where code='NAT'), 1, 'Eu gosto de categorizar as coisas por traços comuns.'),
  ((select id from public.onboarding_steps where code='NAT'), 2, 'As questões ecológicas são importantes para mim.'),
  ((select id from public.onboarding_steps where code='NAT'), 3, 'A classificação me ajuda a entender os novos dados.'),
  ((select id from public.onboarding_steps where code='NAT'), 4, 'Eu gosto de trabalhar em um jardim (ou com plantas).'),
  ((select id from public.onboarding_steps where code='NAT'), 5, 'Acredito que a preservação dos nossos Parques Naturais é importante.'),
  ((select id from public.onboarding_steps where code='NAT'), 6, 'Colocar as coisas em hierarquias faz sentido para mim.'),
  ((select id from public.onboarding_steps where code='NAT'), 7, 'Os animais são importantes na minha vida.'),
  ((select id from public.onboarding_steps where code='NAT'), 8, 'Minha casa tem instalado um sistema de reciclagem.'),
  ((select id from public.onboarding_steps where code='NAT'), 9, 'Gosto de estudar biologia, botânica e/ou zoologia.'),
  ((select id from public.onboarding_steps where code='NAT'), 10, 'Eu percebo diferenças sutis de significado nos detalhes.');

-- Step 8 - Musical
insert into public.onboarding_questions (step_id, order_num, text) values
  ((select id from public.onboarding_steps where code='MUS'), 1, 'Eu percebo os padrões facilmente.'),
  ((select id from public.onboarding_steps where code='MUS'), 2, 'Eu me concentro muito em ruídos e sons.'),
  ((select id from public.onboarding_steps where code='MUS'), 3, 'Mover-se em uma batida (ritmo) é fácil para mim.'),
  ((select id from public.onboarding_steps where code='MUS'), 4, 'Eu gosto de fazer música.'),
  ((select id from public.onboarding_steps where code='MUS'), 5, 'Eu respondo bem à sequência da poesia.'),
  ((select id from public.onboarding_steps where code='MUS'), 6, 'Lembro-me das coisas colocando-as em uma rima.'),
  ((select id from public.onboarding_steps where code='MUS'), 7, 'A concentração é difícil para mim se houver ruído de fundo.'),
  ((select id from public.onboarding_steps where code='MUS'), 8, 'Ouvir sons na natureza pode ser muito relaxante.'),
  ((select id from public.onboarding_steps where code='MUS'), 9, 'Musicais são mais envolventes para mim do que peças dramáticas.'),
  ((select id from public.onboarding_steps where code='MUS'), 10, 'Lembrar letras de músicas é fácil para mim.');

-- Step 9 - Lógico-Matemática
insert into public.onboarding_questions (step_id, order_num, text) values
  ((select id from public.onboarding_steps where code='LOG'), 1, 'Sou conhecido por ser arrumado e organizado.'),
  ((select id from public.onboarding_steps where code='LOG'), 2, 'Direções passo a passo são de grande ajuda.'),
  ((select id from public.onboarding_steps where code='LOG'), 3, 'A resolução de problemas vem facilmente a mim.'),
  ((select id from public.onboarding_steps where code='LOG'), 4, 'Eu fico facilmente frustrado com pessoas desorganizadas.'),
  ((select id from public.onboarding_steps where code='LOG'), 5, 'Eu posso completar cálculos rapidamente na minha cabeça.'),
  ((select id from public.onboarding_steps where code='LOG'), 6, 'Quebra-cabeças de lógica são divertidos.'),
  ((select id from public.onboarding_steps where code='LOG'), 7, 'Não posso começar uma tarefa até que eu tenha tudo perfeitamente organizado.'),
  ((select id from public.onboarding_steps where code='LOG'), 8, 'Estrutura é uma coisa boa.'),
  ((select id from public.onboarding_steps where code='LOG'), 9, 'Gosto de solucionar problemas de algo que não está funcionando corretamente.'),
  ((select id from public.onboarding_steps where code='LOG'), 10, 'As coisas têm que fazer sentido para mim ou fico insatisfeito.');

-- Step 10 - Existencial
insert into public.onboarding_questions (step_id, order_num, text) values
  ((select id from public.onboarding_steps where code='EXI'), 1, 'É importante ver o meu papel no cenário geral das coisas.'),
  ((select id from public.onboarding_steps where code='EXI'), 2, 'Eu gosto de discutir questões sobre a vida.'),
  ((select id from public.onboarding_steps where code='EXI'), 3, 'Religião ou espiritualidade é importante para mim.'),
  ((select id from public.onboarding_steps where code='EXI'), 4, 'Eu gosto de ver trabalhos de arte.'),
  ((select id from public.onboarding_steps where code='EXI'), 5, 'Relaxamento e exercícios de meditação são recompensadores para mim.'),
  ((select id from public.onboarding_steps where code='EXI'), 6, 'Eu gosto de viajar, visitando lugares inspiradores.'),
  ((select id from public.onboarding_steps where code='EXI'), 7, 'Eu gosto de ler filósofos.'),
  ((select id from public.onboarding_steps where code='EXI'), 8, 'Aprender novas coisas é fácil quando eu vejo sua aplicação no mundo real.'),
  ((select id from public.onboarding_steps where code='EXI'), 9, 'Eu fico pensando se existem outras formas de vida inteligente no universo.'),
  ((select id from public.onboarding_steps where code='EXI'), 10, 'É importante para mim sentir-se conectado com pessoas, ideias e crenças.');

-- Step 11 - Interpessoal
insert into public.onboarding_questions (step_id, order_num, text) values
  ((select id from public.onboarding_steps where code='INT'), 1, 'Aprendo melhor interagindo com os outros.'),
  ((select id from public.onboarding_steps where code='INT'), 2, 'Gosto de conversas informais e discussões sérias.'),
  ((select id from public.onboarding_steps where code='INT'), 3, 'Quanto mais gente, melhor.'),
  ((select id from public.onboarding_steps where code='INT'), 4, 'Costumo ser líder entre os pares e colegas.'),
  ((select id from public.onboarding_steps where code='INT'), 5, 'Eu valorizo mais os relacionamentos do que ideias ou realizações.'),
  ((select id from public.onboarding_steps where code='INT'), 6, 'Grupos de estudo são muito produtivos para mim.'),
  ((select id from public.onboarding_steps where code='INT'), 7, 'Eu sou um(a) jogador(a) de equipe (gosto de cooperar).'),
  ((select id from public.onboarding_steps where code='INT'), 8, 'Amigos são importantes para mim.'),
  ((select id from public.onboarding_steps where code='INT'), 9, 'Pertenço a mais de três clubes, grupos ou organizações.'),
  ((select id from public.onboarding_steps where code='INT'), 10, 'Eu não gosto de trabalhar sozinho.');

-- Step 12 - Corporal-Cinestésica
insert into public.onboarding_questions (step_id, order_num, text) values
  ((select id from public.onboarding_steps where code='COR'), 1, 'Eu aprendo fazendo.'),
  ((select id from public.onboarding_steps where code='COR'), 2, 'Eu gosto de fazer coisas com as minhas mãos.'),
  ((select id from public.onboarding_steps where code='COR'), 3, 'Os esportes fazem parte da minha vida.'),
  ((select id from public.onboarding_steps where code='COR'), 4, 'Eu uso gestos e sinais não-verbais quando me comunico.'),
  ((select id from public.onboarding_steps where code='COR'), 5, 'Demonstrar na prática é melhor do que explicar falando.'),
  ((select id from public.onboarding_steps where code='COR'), 6, 'Adoro dançar.'),
  ((select id from public.onboarding_steps where code='COR'), 7, 'Gosto de trabalhar com ferramentas.'),
  ((select id from public.onboarding_steps where code='COR'), 8, 'A inatividade pode me deixar mais cansado do que estar muito ocupado.'),
  ((select id from public.onboarding_steps where code='COR'), 9, 'Atividades práticas são divertidas.'),
  ((select id from public.onboarding_steps where code='COR'), 10, 'Eu vivo um estilo de vida ativo.');

-- Step 13 - Linguística
insert into public.onboarding_questions (step_id, order_num, text) values
  ((select id from public.onboarding_steps where code='LIN'), 1, 'Línguas estrangeiras me interessam.'),
  ((select id from public.onboarding_steps where code='LIN'), 2, 'Gosto de ler livros, revistas e sites.'),
  ((select id from public.onboarding_steps where code='LIN'), 3, 'Eu tenho um diário ou faço anotações pessoais.'),
  ((select id from public.onboarding_steps where code='LIN'), 4, 'Quebra-cabeças de palavras como cruzadas ou caça-palavras são agradáveis.'),
  ((select id from public.onboarding_steps where code='LIN'), 5, 'Anotar me ajuda a lembrar e entender.'),
  ((select id from public.onboarding_steps where code='LIN'), 6, 'Entro em contato fielmente com amigos por meio de mensagens, cartas ou e-mail.'),
  ((select id from public.onboarding_steps where code='LIN'), 7, 'É fácil para mim explicar minhas ideias para os outros.'),
  ((select id from public.onboarding_steps where code='LIN'), 8, 'Escrevo por prazer.'),
  ((select id from public.onboarding_steps where code='LIN'), 9, 'Trocadilhos, anagramas e rimas são divertidos.'),
  ((select id from public.onboarding_steps where code='LIN'), 10, 'Gosto de falar em público e participar de debates.');

-- Step 14 - Intrapessoal
insert into public.onboarding_questions (step_id, order_num, text) values
  ((select id from public.onboarding_steps where code='INA'), 1, 'Minha atitude afeta a forma como aprendo.'),
  ((select id from public.onboarding_steps where code='INA'), 2, 'Gosto de estar envolvido em causas que ajudam os outros.'),
  ((select id from public.onboarding_steps where code='INA'), 3, 'Estou profundamente consciente das minhas crenças morais.'),
  ((select id from public.onboarding_steps where code='INA'), 4, 'Eu aprendo melhor quando tenho um apego emocional ao assunto.'),
  ((select id from public.onboarding_steps where code='INA'), 5, 'A justiça é importante para mim.'),
  ((select id from public.onboarding_steps where code='INA'), 6, 'Questões de justiça social me interessam.'),
  ((select id from public.onboarding_steps where code='INA'), 7, 'Trabalhar sozinho pode ser tão produtivo quanto trabalhar em grupo.'),
  ((select id from public.onboarding_steps where code='INA'), 8, 'Eu preciso saber o porquê eu deveria fazer algo antes de concordar em fazê-lo.'),
  ((select id from public.onboarding_steps where code='INA'), 9, 'Quando eu acredito em algo, eu me esforço muito mais por isso.'),
  ((select id from public.onboarding_steps where code='INA'), 10, 'Estou disposto a protestar ou apoiar uma causa para corrigir um erro.');

-- Step 15 - Espacial
insert into public.onboarding_questions (step_id, order_num, text) values
  ((select id from public.onboarding_steps where code='ESP'), 1, 'Reorganizar um quarto e redecorar é divertido para mim.'),
  ((select id from public.onboarding_steps where code='ESP'), 2, 'Gosto de criar minhas próprias obras de arte ou desenhos.'),
  ((select id from public.onboarding_steps where code='ESP'), 3, 'Lembro-me melhor usando organizadores gráficos (como mapas mentais).'),
  ((select id from public.onboarding_steps where code='ESP'), 4, 'Eu gosto de todos os tipos de mídia de entretenimento visual.'),
  ((select id from public.onboarding_steps where code='ESP'), 5, 'Diagramas, gráficos e tabelas me ajudam a interpretar dados.'),
  ((select id from public.onboarding_steps where code='ESP'), 6, 'Um videoclipe pode me deixar mais interessado em uma música.'),
  ((select id from public.onboarding_steps where code='ESP'), 7, 'Eu posso me lembrar de coisas como imagens mentais.'),
  ((select id from public.onboarding_steps where code='ESP'), 8, 'Eu sou bom em ler mapas e diagramas de locais.'),
  ((select id from public.onboarding_steps where code='ESP'), 9, 'Quebra-cabeças tridimensionais são divertidos.'),
  ((select id from public.onboarding_steps where code='ESP'), 10, 'Eu posso visualizar ideias claramente em minha mente.');

-- =====================================================
-- 8) FUNÇÃO: calcular resultados do aluno
-- Retorna o perfil Holland top + a inteligência top + scores de todos
-- =====================================================
create or replace function public.calculate_onboarding_results(p_user_id uuid)
returns table (
  category text,
  code text,
  title text,
  score int,
  total int,
  percentage numeric
)
language sql
security definer
as $$
  select
    s.category,
    s.code,
    s.title,
    coalesce(sum(case when r.answer then 1 else 0 end), 0)::int as score,
    count(q.id)::int as total,
    round(
      coalesce(sum(case when r.answer then 1 else 0 end), 0)::numeric * 100 / nullif(count(q.id), 0),
      1
    ) as percentage
  from public.onboarding_steps s
  join public.onboarding_questions q on q.step_id = s.id
  left join public.onboarding_responses r on r.question_id = q.id and r.user_id = p_user_id
  group by s.id, s.category, s.code, s.title, s.order_num
  order by s.order_num;
$$;
