// Mock data do painel admin

export const stats = {
  alunosAtivos: 142,
  alunosTotal: 168,
  questsAtivas: 8,
  questsConcluidas: 24,
  tarefasHoje: 47,
  taxaEntrega: 87,
  xpDistribuido: 124500,
  guildasAtivas: 12
}

export const alunos = [
  { id: 1, name: 'Ana Souza', email: 'ana.souza@v4.edu', profile: 'I', level: 12, xp: 4520, quest: 'Analisar V4', phase: 'sentir', activity: 92, status: 'active' },
  { id: 2, name: 'Bruno Lima', email: 'bruno.lima@v4.edu', profile: 'A', level: 9, xp: 3210, quest: 'Analisar V4', phase: 'sentir', activity: 78, status: 'active' },
  { id: 3, name: 'Carla Dias', email: 'carla.dias@v4.edu', profile: 'S', level: 14, xp: 5180, quest: 'Analisar V4', phase: 'sentir', activity: 95, status: 'active' },
  { id: 4, name: 'Diego Rocha', email: 'diego.rocha@v4.edu', profile: 'E', level: 11, xp: 4010, quest: 'Analisar V4', phase: 'sentir', activity: 64, status: 'active' },
  { id: 5, name: 'Eduarda Silva', email: 'eduarda.silva@v4.edu', profile: 'R', level: 13, xp: 4880, quest: 'Analisar V4', phase: 'sentir', activity: 88, status: 'active' },
  { id: 6, name: 'Felipe Cardoso', email: 'felipe.c@v4.edu', profile: 'I', level: 10, xp: 3650, quest: 'Pesquisa Mercado', phase: 'imaginar', activity: 71, status: 'active' },
  { id: 7, name: 'Helena Costa', email: 'helena.c@v4.edu', profile: 'A', level: 15, xp: 5720, quest: 'Pesquisa Mercado', phase: 'imaginar', activity: 100, status: 'active' },
  { id: 8, name: 'Ivan Mendes', email: 'ivan.m@v4.edu', profile: 'C', level: 8, xp: 2940, quest: 'Pesquisa Mercado', phase: 'imaginar', activity: 45, status: 'idle' },
  { id: 9, name: 'Júlia Pereira', email: 'julia.p@v4.edu', profile: 'S', level: 12, xp: 4380, quest: 'Pesquisa Mercado', phase: 'imaginar', activity: 82, status: 'active' },
  { id: 10, name: 'Lucas Martins', email: 'lucas.m@v4.edu', profile: 'E', level: 9, xp: 3320, quest: 'Pesquisa Mercado', phase: 'imaginar', activity: 56, status: 'idle' }
]

export const quests = [
  { id: 'q1', code: '1-1', title: 'Analisar a V4', template: 'Análise de Empresa', students: 5, phase: 'sentir', progress: 35, days: { current: 3, total: 18 }, status: 'active' },
  { id: 'q2', code: '1-2', title: 'Pesquisa de Mercado', template: 'Pesquisa', students: 5, phase: 'imaginar', progress: 58, days: { current: 11, total: 16 }, status: 'active' },
  { id: 'q3', code: '2-1', title: 'Proposta App de Educação', template: 'Produto Digital', students: 4, phase: 'fazer', progress: 72, days: { current: 14, total: 20 }, status: 'active' },
  { id: 'q4', code: '3-1', title: 'Estudo de Caso Histórico', template: 'Estudo de Caso', students: 6, phase: 'compartilhar', progress: 95, days: { current: 17, total: 18 }, status: 'active' },
  { id: 'q5', code: 'X-1', title: 'Branding & Posicionamento', template: 'Análise de Empresa', students: 4, phase: null, progress: 100, days: { current: 18, total: 18 }, status: 'done' }
]

export const activity = [
  { id: 1, type: 'submission', who: 'Ana Souza', what: 'enviou entrega', target: 'Visitar site V4', when: 'há 3 min', icon: 'send' },
  { id: 2, type: 'claim', who: 'Bruno Lima', what: 'pegou tarefa', target: 'Coletar prints redes sociais', when: 'há 12 min', icon: 'flag' },
  { id: 3, type: 'phase', who: 'Guilda Alpha', what: 'completou fase', target: 'SENTIR · Pesquisa Mercado', when: 'há 28 min', icon: 'check' },
  { id: 4, type: 'level', who: 'Helena Costa', what: 'subiu para nível 15', target: '', when: 'há 1h', icon: 'star' },
  { id: 5, type: 'submission', who: 'Carla Dias', what: 'enviou entrega', target: 'Mapear público-alvo', when: 'há 1h 24min', icon: 'send' },
  { id: 6, type: 'claim', who: 'Diego Rocha', what: 'pegou tarefa', target: 'Identificar concorrentes', when: 'há 2h', icon: 'flag' },
  { id: 7, type: 'submission', who: 'Eduarda Silva', what: 'enviou entrega', target: 'Documentar elementos visuais', when: 'há 3h', icon: 'send' },
  { id: 8, type: 'phase', who: 'Guilda Beta', what: 'completou fase', target: 'IMAGINAR · Analisar V4', when: 'há 5h', icon: 'check' }
]

export const profilesMap = {
  R: { name: 'Realista', color: '#56C8FF' },
  I: { name: 'Investigativo', color: '#B86CFF' },
  A: { name: 'Artístico', color: '#E94B8C' },
  S: { name: 'Social', color: '#6FE36F' },
  E: { name: 'Empreendedor', color: '#FFC845' },
  C: { name: 'Convencional', color: '#56C8FF' }
}
