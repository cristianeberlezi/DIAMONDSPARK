// Quest: Analisar V4
// Estrutura: 4 fases sequenciais (Duplo Diamante)
// Total: ~18 dias úteis

export const quest = {
  id: '1-1',
  code: '1-1',
  title: 'Analisar a V4',
  subtitle: 'Como a V4 se posiciona no mercado e constrói autoridade',
  objective:
    'Analisar como a V4 se posiciona no mercado, qual sua identidade, linguagem, público e mecanismos de construção de autoridade.',
  finalDeliverable: 'PDF + apresentação de 10 min cobrindo posicionamento, identidade visual, linguagem nas redes, público-alvo, diferenciais e autoridade.',
  template: 'Análise de Empresa / Marca',
  reward: { xp: 1500, coins: 2000, gems: 25 },
  totalDays: 18,
  currentPhase: 'sentir',
  currentPhaseDay: 3,

  phases: [
    {
      key: 'sentir',
      title: 'SENTIR',
      subtitle: 'Coletar evidências cruas, sem julgamento',
      icon: 'eye',
      color: '#6FE36F',
      glow: 'rgba(111, 227, 111, 0.55)',
      days: 5,
      status: 'active', // locked | active | done
      deliverable: {
        title: 'Dossier de evidências',
        description: 'Pasta digital com prints, links, anotações cruas. Não precisa estar bonito, precisa estar completo.'
      },
      individualTasks: [
        { id: 's1', title: 'Visitar o site da V4 e anotar 5 percepções iniciais', est: 20, status: 'done', assignee: 'Você', profile: 'investigador' },
        { id: 's2', title: 'Coletar 5 prints das redes sociais (IG, LinkedIn, YT)', est: 25, status: 'mine', assignee: 'Você', profile: 'investigador' },
        { id: 's3', title: 'Identificar 3 concorrentes diretos', est: 15, status: 'claimed', assignee: 'Ana Souza', profile: 'analista' },
        { id: 's4', title: 'Listar vocabulário/expressões nas comunicações', est: 20, status: 'open', profile: 'comunicador' },
        { id: 's5', title: 'Documentar cores, tipografia e elementos visuais', est: 30, status: 'open', profile: 'designer' },
        { id: 's6', title: 'Mapear o público aparente nas postagens', est: 25, status: 'open', profile: 'analista' }
      ],
      collectiveTask: {
        id: 'sc1',
        title: 'Compartilhar material no chat da guilda + discutir primeiras impressões',
        description: 'Toda a guilda reúne o que coletou e troca impressões iniciais. Sem síntese ainda.',
        est: 60,
        status: 'in_progress',
        participants: 3,
        total: 5
      }
    },
    {
      key: 'imaginar',
      title: 'IMAGINAR',
      subtitle: 'Transformar evidências em insights estruturados',
      icon: 'brain',
      color: '#00D4FF',
      glow: 'rgba(0, 212, 255, 0.55)',
      days: 4,
      status: 'locked',
      deliverable: {
        title: 'Mapa de insights da guilda',
        description: 'Documento estruturado com análise consolidada. Rascunho de conteúdo, ainda sem design final.'
      },
      individualTasks: [
        { id: 'i1', title: 'Definir em 1 frase: "a V4 é..."', est: 15, status: 'locked', profile: 'estrategista' },
        { id: 'i2', title: 'Mapear 3 diferenciais reais da marca', est: 25, status: 'locked', profile: 'analista' },
        { id: 'i3', title: 'Identificar 3 mecanismos de autoridade', est: 25, status: 'locked', profile: 'analista' },
        { id: 'i4', title: 'Montar tabela comparativa V4 vs concorrente', est: 35, status: 'locked', profile: 'analista' },
        { id: 'i5', title: 'Identificar o tom de voz dominante', est: 20, status: 'locked', profile: 'comunicador' },
        { id: 'i6', title: 'Caracterizar o público-alvo descoberto', est: 25, status: 'locked', profile: 'analista' }
      ],
      collectiveTask: {
        id: 'ic1',
        title: 'Consolidar insights individuais + definir narrativa da entrega',
        description: 'Cruzar todos os insights individuais e decidir o ângulo da análise final.',
        est: 90,
        status: 'locked'
      }
    },
    {
      key: 'fazer',
      title: 'FAZER',
      subtitle: 'Construir o entregável final',
      icon: 'hammer',
      color: '#FFC845',
      glow: 'rgba(255, 200, 69, 0.55)',
      days: 6,
      status: 'locked',
      deliverable: {
        title: 'PDF ou apresentação final',
        description: 'O produto que o professor pediu, pronto para ser apresentado.'
      },
      individualTasks: [
        { id: 'f1', title: 'Aluno A: posicionamento + público-alvo', est: 120, status: 'locked', profile: 'estrategista' },
        { id: 'f2', title: 'Aluno B: identidade visual + linguagem', est: 120, status: 'locked', profile: 'designer' },
        { id: 'f3', title: 'Aluno C: diferenciais + comparação concorrentes', est: 120, status: 'locked', profile: 'analista' },
        { id: 'f4', title: 'Aluno D: autoridade + conclusões', est: 120, status: 'locked', profile: 'comunicador' },
        { id: 'f5', title: 'Criar comparações visuais, gráficos, prints lado a lado', est: 60, status: 'locked', profile: 'designer' }
      ],
      collectiveTask: {
        id: 'fc1',
        title: 'Review cruzado + identidade visual + unificar tudo',
        description: 'Cada aluno revisa o trabalho de outro. Define cores, fonte, capa. Unifica no documento final.',
        est: 180,
        status: 'locked'
      }
    },
    {
      key: 'compartilhar',
      title: 'COMPARTILHAR',
      subtitle: 'Apresentar, receber feedback, refletir',
      icon: 'broadcast',
      color: '#B86CFF',
      glow: 'rgba(184, 108, 255, 0.55)',
      days: 3,
      status: 'locked',
      deliverable: {
        title: 'Apresentação final + reflexões + peer reviews',
        description: 'Material que vai pro portfólio do aluno.'
      },
      individualTasks: [
        { id: 'c1', title: 'Preparar sua parte da apresentação (script + treino)', est: 60, status: 'locked', profile: 'apresentador' },
        { id: 'c2', title: 'Gravar/apresentar seu trecho', est: 30, status: 'locked', profile: 'apresentador' },
        { id: 'c3', title: 'Escrever reflexão pessoal: "o que aprendi"', est: 30, status: 'locked', profile: 'documentador' }
      ],
      collectiveTask: {
        id: 'cc1',
        title: 'Apresentação síncrona + feedback + avaliar outras guildas',
        description: 'Apresentação pra turma/professor. Peer review entre guildas.',
        est: 120,
        status: 'locked'
      }
    }
  ]
}

export const guild = [
  { id: 1, name: 'Ana Souza', task: 'Identificar 3 concorrentes', status: 'claimed' },
  { id: 2, name: 'Bruno Lima', task: null, status: 'idle' },
  { id: 3, name: 'Você', task: 'Coletar 5 prints', status: 'mine' },
  { id: 4, name: 'Diego Rocha', task: null, status: 'idle' },
  { id: 5, name: 'Eduarda Silva', task: null, status: 'idle' }
]
