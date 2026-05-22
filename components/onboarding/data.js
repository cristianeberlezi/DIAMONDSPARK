// Perfis Holland (RIASEC)
export const profiles = {
  R: {
    letter: 'R',
    name: 'REALISTA',
    role: 'O CONSTRUTOR',
    color: '#56C8FF',
    glow: 'rgba(86, 200, 255, 0.5)',
    image: '/images/P01.png',
    mission: 'Construir, operar e manter sistemas e tecnologias do mundo real.',
    areas: ['Robótica', 'Hardware', 'Infraestrutura', 'Redes e Sistemas', 'Automação'],
    skills: ['Lógico-Matemática', 'Corporal-Cinestésica', 'Espacial']
  },
  I: {
    letter: 'I',
    name: 'INVESTIGATIVO',
    role: 'O PESQUISADOR',
    color: '#B86CFF',
    glow: 'rgba(184, 108, 255, 0.5)',
    image: '/images/P02.png',
    mission: 'Explorar o desconhecido, analisar dados e resolver problemas complexos com inteligência.',
    areas: ['Programação', 'Ciência de Dados', 'Inteligência Artificial', 'Pesquisa', 'Cibersegurança'],
    skills: ['Lógico-Matemática', 'Intrapessoal', 'Linguística']
  },
  A: {
    letter: 'A',
    name: 'ARTÍSTICO',
    role: 'O CRIADOR',
    color: '#E94B8C',
    glow: 'rgba(233, 75, 140, 0.5)',
    image: '/images/P03.png',
    mission: 'Criar, imaginar e projetar experiências que inspiram e conectam pessoas.',
    areas: ['Design Digital', 'Games', 'Animação e 3D', 'UX / UI', 'Produção Audiovisual'],
    skills: ['Espacial', 'Musical', 'Linguística']
  },
  S: {
    letter: 'S',
    name: 'SOCIAL',
    role: 'O CONECTOR',
    color: '#6FE36F',
    glow: 'rgba(111, 227, 111, 0.5)',
    image: '/images/P04.png',
    mission: 'Ajudar, ensinar e conectar pessoas para gerar impacto positivo na sociedade.',
    areas: ['Educação Tech', 'Comunidades', 'UX Research', 'Recursos Humanos', 'Projetos Sociais'],
    skills: ['Interpessoal', 'Linguística', 'Intrapessoal']
  },
  E: {
    letter: 'E',
    name: 'EMPREENDEDOR',
    role: 'O INOVADOR',
    color: '#FFC845',
    glow: 'rgba(255, 200, 69, 0.5)',
    image: '/images/P05.png',
    mission: 'Liderar, inovar e transformar ideias em soluções que geram valor e mudanças reais.',
    areas: ['Startups', 'Gestão de Projetos', 'Product Design', 'Marketing Digital', 'Liderança e Estratégia'],
    skills: ['Interpessoal', 'Linguística', 'Intrapessoal']
  },
  C: {
    letter: 'C',
    name: 'CONVENCIONAL',
    role: 'O ORGANIZADOR',
    color: '#7AB8FF',
    glow: 'rgba(122, 184, 255, 0.5)',
    image: '/images/P06.png',
    mission: 'Organizar, planejar e garantir que tudo funcione com precisão e eficiência.',
    areas: ['Análise de Sistemas', 'Qualidade (QA)', 'Compliance & Gov', 'Finanças & Dados', 'Documentação'],
    skills: ['Lógico-Matemática', 'Linguística', 'Intrapessoal']
  }
}

export const questions = [
  {
    text: 'Em um projeto em grupo, qual seu papel natural?',
    options: [
      { text: 'Construo a estrutura técnica que sustenta tudo', profile: 'R' },
      { text: 'Pesquiso e analiso os melhores caminhos', profile: 'I' },
      { text: 'Crio a identidade visual e a experiência', profile: 'A' },
      { text: 'Conecto as pessoas e mantenho o time unido', profile: 'S' },
      { text: 'Lidero, motivo e abro novas oportunidades', profile: 'E' },
      { text: 'Organizo processos, prazos e documentação', profile: 'C' }
    ]
  },
  {
    text: 'O que mais te energiza durante o dia?',
    options: [
      { text: 'Colocar a mão na massa e ver algo funcionar', profile: 'R' },
      { text: 'Entender o "porquê" das coisas profundamente', profile: 'I' },
      { text: 'Expressar minha visão em algo criativo', profile: 'A' },
      { text: 'Ajudar alguém a evoluir ou se sentir melhor', profile: 'S' },
      { text: 'Bater meta, vender uma ideia, abrir um caminho', profile: 'E' },
      { text: 'Ver tudo bem organizado e funcionando preciso', profile: 'C' }
    ]
  },
  {
    text: 'Diante de um problema novo, sua reação é:',
    options: [
      { text: 'Testar na prática até encontrar a solução', profile: 'R' },
      { text: 'Analisar os dados antes de qualquer ação', profile: 'I' },
      { text: 'Pensar fora da caixa, buscar inspiração', profile: 'A' },
      { text: 'Conversar com pessoas que já passaram por isso', profile: 'S' },
      { text: 'Montar um plano e mobilizar quem precisa', profile: 'E' },
      { text: 'Documentar tudo e seguir um método', profile: 'C' }
    ]
  },
  {
    text: 'Qual ambiente te faz prosperar?',
    options: [
      { text: 'Oficina, laboratório, hands-on', profile: 'R' },
      { text: 'Quieto, focado, com tempo pra pensar', profile: 'I' },
      { text: 'Estúdio, espaço criativo, liberdade', profile: 'A' },
      { text: 'Junto de pessoas, colaborativo', profile: 'S' },
      { text: 'Dinâmico, com desafios e variedade', profile: 'E' },
      { text: 'Estruturado, com regras claras', profile: 'C' }
    ]
  },
  {
    text: 'Como você prefere aprender?',
    options: [
      { text: 'Construindo um projeto real', profile: 'R' },
      { text: 'Estudando teoria e pesquisando', profile: 'I' },
      { text: 'Criando algo único do meu jeito', profile: 'A' },
      { text: 'Em grupo, trocando experiências', profile: 'S' },
      { text: 'Aplicando para resolver um problema real', profile: 'E' },
      { text: 'Seguindo um curso passo a passo', profile: 'C' }
    ]
  },
  {
    text: 'Qual frase mais combina com você?',
    options: [
      { text: '"Se quebrou, eu conserto."', profile: 'R' },
      { text: '"Por que isso acontece?"', profile: 'I' },
      { text: '"E se a gente fizesse diferente?"', profile: 'A' },
      { text: '"Como posso ajudar?"', profile: 'S' },
      { text: '"Vamos transformar isso em algo grande."', profile: 'E' },
      { text: '"Tem checklist? Vamos seguir."', profile: 'C' }
    ]
  },
  {
    text: 'O que te dá mais orgulho ao final do dia?',
    options: [
      { text: 'Ver algo concreto que funcionou', profile: 'R' },
      { text: 'Ter descoberto uma resposta nova', profile: 'I' },
      { text: 'Ter criado algo bonito e original', profile: 'A' },
      { text: 'Ter ajudado alguém de verdade', profile: 'S' },
      { text: 'Ter aberto uma oportunidade pra equipe', profile: 'E' },
      { text: 'Ter deixado tudo no lugar e rodando bem', profile: 'C' }
    ]
  }
]
