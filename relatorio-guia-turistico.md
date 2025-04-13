# Relatório: Sistema Especialista para Guia Turístico

## 1. Introdução

Este relatório descreve um sistema especialista desenvolvido para funcionar como um guia turístico, utilizando a abordagem de frames e regras de inferência para relacionar três domínios de conhecimento:

1. **Atrações Turísticas**: Locais e atividades disponíveis para visitação
2. **Perfil do Turista**: Características e preferências dos visitantes
3. **Itinerários Recomendados**: Combinações de atrações organizadas em roteiros

O sistema foi implementado utilizando a linguagem CLIPS (C Language Integrated Production System), que é uma ferramenta para a construção de sistemas especialistas baseados em regras e frames.

## 2. Domínios de Conhecimento

### 2.1 Atrações Turísticas

Este domínio representa os pontos turísticos disponíveis para visitação. Cada atração é caracterizada pelos seguintes atributos:

- **Nome**: Identificador único da atração
- **Tipo**: Categoria principal (Praia, Museu, Parque, Monumento, Gastronomia, Cultural, Aventura)
- **Localização**: Região onde a atração está situada
- **Preço**: Custo de visitação (Gratuito, Baixo, Médio, Alto)
- **Duração da Visita**: Tempo médio necessário para aproveitar a atração (Rápida, Médio, Longa)
- **Nível de Popularidade**: Quão conhecida/frequentada é a atração (Baixo, Médio, Alto)
- **Características**: Atributos específicos da atração (como "família", "natureza", "história", etc.)

### 2.2 Perfil do Turista

Este domínio representa os visitantes e suas preferências, caracterizados por:

- **ID**: Identificador único do turista
- **Interesses**: Categorias de atrações que o turista tem interesse (múltiplos valores)
- **Orçamento**: Disponibilidade financeira para o turismo (Baixo, Médio, Alto)
- **Tempo Disponível**: Quantidade de tempo para turismo (Pouco, Médio, Muito)
- **Viajando Com**: Companhia de viagem (Sozinho, Casal, Família, Amigos)
- **Preferência de Movimentação**: Ritmo preferido (Calmo, Moderado, Agitado)

### 2.3 Itinerários Recomendados

Este domínio representa combinações pré-definidas de atrações organizadas em roteiros:

- **ID**: Identificador único do itinerário
- **Nome**: Nome descritivo do itinerário
- **Atrações**: Lista de pontos turísticos incluídos no roteiro
- **Duração**: Tempo necessário para completar o itinerário (Meio-dia, Dia-inteiro, Dois-dias, Semana)
- **Custo Total**: Custo aproximado do itinerário completo (Baixo, Médio, Alto)
- **Tipo de Turista**: Perfil para o qual o itinerário foi desenhado (Aventureiro, Cultural, Relaxamento, Misto)

## 3. Tabelas de Relações entre Domínios

### 3.1 Relação entre Tipo de Atração e Interesses do Turista

| Tipo de Atração | Interesse do Turista | Descrição da Relação                                               |
| --------------- | -------------------- | ------------------------------------------------------------------ |
| PRAIA           | PRAIA                | Turista com interesse em praias visita atrações do tipo praia      |
| MUSEU           | MUSEU, CULTURAL      | Turista com interesse em cultura/museus visita museus              |
| PARQUE          | PARQUE, AVENTURA     | Turista com interesse em parques/aventura visita parques           |
| MONUMENTO       | MONUMENTO, CULTURAL  | Turista com interesse em cultura/história visita monumentos        |
| GASTRONOMIA     | GASTRONOMIA          | Turista com interesse em gastronomia visita atrações gastronômicas |
| CULTURAL        | CULTURAL             | Turista com interesse em cultura visita atrações culturais         |
| AVENTURA        | AVENTURA             | Turista com interesse em aventura visita atrações de aventura      |

### 3.2 Relação entre Orçamento do Turista e Preço das Atrações

| Orçamento do Turista | Preço da Atração             | Recomendação          |
| -------------------- | ---------------------------- | --------------------- |
| BAIXO                | GRATUITO                     | Alta compatibilidade  |
| BAIXO                | BAIXO                        | Compatibilidade média |
| BAIXO                | MEDIO, ALTO                  | Baixa compatibilidade |
| MEDIO                | GRATUITO, BAIXO              | Alta compatibilidade  |
| MEDIO                | MEDIO                        | Compatibilidade média |
| MEDIO                | ALTO                         | Baixa compatibilidade |
| ALTO                 | GRATUITO, BAIXO, MEDIO, ALTO | Alta compatibilidade  |

### 3.3 Relação entre Tipo de Viajante e Características das Atrações

| Viajando Com | Características ideais          | Atrações Recomendadas                               |
| ------------ | ------------------------------- | --------------------------------------------------- |
| FAMILIA      | familiar, natureza, parque      | Parques, praias familiares, atrações educativas     |
| CASAL        | romântico, gastronomia, cultura | Restaurantes, passeios culturais, locais românticos |
| AMIGOS       | baladas, aventura, esportes     | Trilhas, praias com esportes, vida noturna          |
| SOZINHO      | cultura, gastronomia, natureza  | Museus, parques, centros históricos                 |

### 3.4 Relação entre Tipo de Turista e Itinerários Recomendados

| Tipo de Turista | Itinerário Recomendado               | Justificativa                                         |
| --------------- | ------------------------------------ | ----------------------------------------------------- |
| CULTURAL        | Roteiro Cultural                     | Itinerário focado em atrações culturais e históricas  |
| RELAXAMENTO     | Praias do Norte                      | Itinerário focado em praias e relaxamento             |
| AVENTUREIRO     | Natureza e Aventura                  | Itinerário focado em trilhas e atividades ao ar livre |
| MISTO           | Família na Ilha, Gastronomia da Ilha | Itinerários com experiências variadas                 |

## 4. Regras de Inferência em Linguagem Natural

O sistema utiliza as seguintes regras de inferência:

1. **Recomendação por interesse**: Se um turista tem interesse em um determinado tipo de atração (ex: praia), então recomendar atrações desse tipo que sejam compatíveis com seu orçamento.

2. **Recomendação por orçamento**: Se um turista tem orçamento baixo, então recomendar atrações gratuitas com prioridade mais alta.

3. **Recomendação por tempo disponível**: Se um turista tem pouco tempo disponível, então recomendar atrações com duração de visita rápida.

4. **Recomendação para famílias**: Se um turista está viajando com família, então recomendar atrações com características boas para famílias.

5. **Recomendação de atrações populares**: Recomendar atrações de alta popularidade para qualquer perfil de turista, com menor prioridade.

6. **Recomendação de itinerário por tipo**: Se o turista tem interesses que se alinham com um tipo específico de itinerário, então recomendar esse itinerário.

7. **Recomendação de itinerário para família**: Se o turista está viajando com família, então recomendar o itinerário "Família na Ilha".

8. **Recomendação de itinerário gastronômico**: Se o turista tem interesse em gastronomia, então recomendar o itinerário "Gastronomia da Ilha".

## 5. Implementação em CLIPS

O sistema foi implementado usando CLIPS com a seguinte estrutura:

1. **Frames (templates)**: Definem as estruturas de dados para atrações, perfis de turistas, itinerários e recomendações.
2. **Fatos (facts)**: Instâncias específicas de atrações e itinerários pré-definidos.
3. **Regras (rules)**: Implementam a lógica de inferência descrita na seção anterior.
4. **Funções**: Implementam utilitários como exibição de recomendações.

A modelagem utilizando frames permite uma representação estruturada e organizada dos conceitos do domínio, facilitando o estabelecimento de relações entre eles.

## 6. Testes do Sistema

O sistema foi testado com quatro perfis diferentes de turistas:

1. **Turista Cultural**: Interessado em museus, atrações culturais e monumentos
2. **Família com Crianças**: Interessados em praias e parques, viajando em família
3. **Turista Aventureiro**: Interessado em aventura e praias, viajando com amigos e com orçamento limitado
4. **Turista Gastronômico**: Interessado em gastronomia e cultura, com alto orçamento

Os testes mostraram que o sistema consegue fazer recomendações apropriadas para cada perfil, combinando atrações específicas e itinerários completos de acordo com as características e preferências de cada tipo de turista.

## 7. Discussão e Acurácia do Sistema

O sistema demonstra boa capacidade de recomendação quando os perfis dos turistas são bem definidos e quando há clareza nos interesses. A acurácia do sistema pode ser avaliada sob os seguintes aspectos:

### 7.1 Pontos Fortes

- **Integração multidimensional**: O sistema relaciona eficientemente os três domínios (atrações, perfis e itinerários)
- **Regras contextualmente relevantes**: As recomendações consideram múltiplas variáveis (interesses, orçamento, tempo, etc.)
- **Itinerários pré-definidos**: Facilitam recomendações para perfis típicos de turistas

### 7.2 Limitações

- **Base de conhecimento fixa**: O sistema requer atualização manual para inclusão de novas atrações ou itinerários
- **Simplificação de conceitos**: Utiliza categorias simplificadas (baixo, médio, alto) que podem não capturar todas as nuances
- **Ausência de feedback adaptativo**: Não adapta recomendações com base em feedback do usuário

### 7.3 Potenciais Melhorias

- Integrar um mecanismo de aprendizado para refinar recomendações com base em feedback
- Expandir a base de conhecimento para incluir eventos sazonais e temporários
- Implementar um sistema de geração dinâmica de itinerários personalizados
- Adicionar contexto temporal (estações do ano, dias da semana, horários de funcionamento)

## 8. Conclusão

O sistema especialista para guia turístico demonstra como a abordagem baseada em frames pode ser eficaz para a modelagem de conhecimento em domínios interrelacionados. A combinação de representação estruturada (frames) com regras de inferência permite criar um sistema que faz recomendações contextualizadas e relevantes para diferentes perfis de turistas.

Este sistema ilustra o potencial dos sistemas especialistas em tarefas de recomendação personalizada, podendo ser expandido e aprimorado para aplicações comerciais e de serviço ao turista.

---

## Apêndice: Estrutura dos Arquivos

- **turismo-especialista.clp**: Contém a definição dos frames, fatos e regras do sistema
- **turismo-testes.clp**: Contém os casos de teste para avaliar o funcionamento do sistema
