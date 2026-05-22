# Design System — ProfessoOnline

Referência visual base do projeto. Cores, tipografia e ícones extraídos do guia de marca.

---

## 🎨 Cores

| Token            | Nome         | Hex       | Preview                                                       |
| ---------------- | ------------ | --------- | ------------------------------------------------------------- |
| `--cor-laranja`  | Orange       | `#F16F3C` | ![](https://placehold.co/24x24/F16F3C/F16F3C.png)             |
| `--cor-gelo`     | Bright gray  | `#F2F2F2` | ![](https://placehold.co/24x24/F2F2F2/F2F2F2.png)             |
| `--cor-preto`    | Black        | `#180802` | ![](https://placehold.co/24x24/180802/180802.png)             |
| `--cor-verde`    | Green        | `#48C884` | ![](https://placehold.co/24x24/48C884/48C884.png)             |
| `--cor-amarelo`  | Yellow       | `#FFD027` | ![](https://placehold.co/24x24/FFD027/FFD027.png)             |
| `--cor-roxo`     | Purple       | `#8A5CFF` | ![](https://placehold.co/24x24/8A5CFF/8A5CFF.png)             |
| `--cor-branco`   | White        | `#FFFFFF` | ![](https://placehold.co/24x24/FFFFFF/FFFFFF.png)             |

### Aplicação semântica sugerida

| Uso                  | Cor                         |
| -------------------- | --------------------------- |
| Primária / CTA       | `--cor-laranja` (#F16F3C)   |
| Secundária / destaque| `--cor-roxo` (#8A5CFF)      |
| Sucesso              | `--cor-verde` (#48C884)     |
| Atenção / alerta     | `--cor-amarelo` (#FFD027)   |
| Texto principal      | `--cor-preto` (#180802)     |
| Fundo / superfícies  | `--cor-gelo` (#F2F2F2)      |
| Fundo base           | `--cor-branco` (#FFFFFF)    |

---

## 🔤 Tipografia

**Família principal:** `Neue Montreal`

```
Aa
AaBbCcDdEeFfGgHhIiJjKkLlMmNnOo
PpQqRrSsTtUuVvWwXxYyZz
0123456789
```

### Pesos

| Token         | Peso        | Uso                                |
| ------------- | ----------- | ---------------------------------- |
| `--light`     | 300         | Textos auxiliares, legendas        |
| `--regular`   | 400         | Texto corrido, parágrafos          |
| `--semibold`  | 600         | Subtítulos, links, ênfase          |
| `--bold`      | 700         | Títulos, headings, CTAs            |

### Escala (já definida em [assets/css/variaveis.sass](assets/css/variaveis.sass))

| Token | Tamanho                          | Uso                       |
| ----- | -------------------------------- | ------------------------- |
| `--f0`| `clamp(0.5rem, 1vw, 0.7rem)`     | Micro labels              |
| `--f1`| `clamp(0.7rem, 1vw, 0.9rem)`     | Caption / overline        |
| `--f2`| `clamp(0.9rem, 1vw, 1.1rem)`     | Body / texto base         |
| `--f3`| `clamp(1.1rem, 1vw, 1.3rem)`     | Body grande / lead        |
| `--f4`| `clamp(1.3rem, 1vw, 1.5rem)`     | Subtítulo H5/H6           |
| `--f5`| `clamp(1.5rem, 1vw, 1.8rem)`     | Subtítulo H4              |
| `--f6`| `clamp(1.8rem, 1vw, 2.2rem)`     | Heading H3                |
| `--f7`| `clamp(2.2rem, 1vw, 2.5rem)`     | Heading H2                |
| `--f8`| `clamp(3rem, 1vw, 4rem)`         | Heading H1                |
| `--f9`| `clamp(5rem, 15vw, 11rem)`       | Display / hero            |

---

## 🔘 Ícones

**Estilo:** Outline (1.5px stroke), traços arredondados, container circular com fundo `--cor-gelo` (#F2F2F2) e ícone em `--cor-preto` (#180802).

### Conjunto base

| Ícone           | Nome técnico   | Uso                                   |
| --------------- | -------------- | ------------------------------------- |
| 🔍              | `search`       | Busca, pesquisa                       |
| ⚙️              | `settings`     | Configurações, preferências           |
| 🔔              | `bell`         | Notificações, alertas                 |
| ⌄               | `chevron-down` | Dropdowns, expansão de seções         |
| ⇅               | `filters`      | Filtros, ordenação                    |
| ⋯               | `more`         | Menu de ações secundárias             |
| 🎓              | `user-student` | Perfil do aluno / professor           |
| ⓘ              | `info`         | Tooltip, informações adicionais       |
| ⓘ              | `info-alt`     | Variação de informação / ajuda        |

### Especificações

| Propriedade     | Valor                                        |
| --------------- | -------------------------------------------- |
| Tamanho ícone   | 20px (padrão) — 16px (compacto), 24px (largo)|
| Container       | Círculo 40px de diâmetro                     |
| Stroke          | 1.5px                                        |
| Cor stroke      | `var(--cor-preto)`                           |
| Fundo container | `var(--cor-gelo)`                            |
| Hover           | Fundo escurece para `#E5E5E5`                |
| Disabled        | `opacity: 0.4`                               |

**Biblioteca recomendada:** [Lucide](https://lucide.dev) ou [Phosphor Icons](https://phosphoricons.com) — ambas seguem o estilo outline arredondado das imagens.

---

## 📐 Layout

| Token              | Valor    | Uso                       |
| ------------------ | -------- | ------------------------- |
| `--padding-lateral`| `80px`   | Espaçamento lateral base  |
| `--max-width`      | `1920px` | Largura máxima do conteúdo|

### Border-radius

| Token       | Valor   | Uso                         |
| ----------- | ------- | --------------------------- |
| `--r-sm`    | `8px`   | Inputs, badges              |
| `--r-md`    | `16px`  | Botões, pills               |
| `--r-lg`    | `24px`  | Cards                       |
| `--r-xl`    | `32px`  | Containers grandes          |
| `--r-full`  | `9999px`| Avatares, ícones circulares |

---

## ✅ Próximos passos

- [ ] Atualizar [assets/css/variaveis.sass](assets/css/variaveis.sass) com a nova paleta
- [ ] Adicionar fonte `Neue Montreal` em [assets/css/fonts.sass](assets/css/fonts.sass)
- [ ] Criar componente `<Icone>` global em [components/global/](components/global/)
- [ ] Definir tokens de `box-shadow` e estados (hover/active/focus)
