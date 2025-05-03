# Algoritmo Genético para o Problema do Caixeiro Viajante

Este projeto implementa um Algoritmo Genético (AG) para resolver o Problema do Caixeiro Viajante (TSP - Traveling Salesman Problem) usando a biblioteca PyGAD.

## Problema

O Problema do Caixeiro Viajante consiste em encontrar a rota mais curta que passa por todas as cidades exatamente uma vez e retorna à cidade inicial. Neste projeto, trabalhamos com 10 cidades da região da Grande Florianópolis.

## Detalhes da Implementação

### 1. Codificação do Cromossomo

- Cada cromossomo é uma permutação dos índices das cidades (0 a 9)
- O tamanho do cromossomo é igual ao número de cidades (10)
- Exemplo: [0, 3, 1, 4, 2, 6, 5, 8, 7, 9]

### 2. População

- Tamanho da população: Definido automaticamente pelo PyGAD
- Número de pais para cruzamento: 4
- Inicialização: Aleatória dentro do intervalo [0, número de cidades]

### 3. Função de Fitness

- Calcula o inverso da distância total do percurso
- Quanto menor a distância total, maior o valor de fitness
- Considera a distância euclidiana entre as coordenadas das cidades
- Inclui o retorno à cidade inicial

### 4. Seleção e Cruzamento

- Seleção: Implementada automaticamente pelo PyGAD
- Número de pais para cruzamento: 4
- Tipo de cruzamento: Padrão do PyGAD

### 5. Mutação

- Tipo: Aleatória
- Taxa de mutação: 10% dos genes
- Ajuda a manter a diversidade da população

### 6. Critério de Parada

- Número máximo de gerações: 500

## Visualização

O projeto inclui duas visualizações:

1. Gráfico de progresso do fitness ao longo das gerações
2. Mapa com a melhor rota encontrada

## Requisitos

- Python 3.x
- NumPy
- PyGAD
- Matplotlib

## Como Executar

1. Instale as dependências:

```bash
pip install numpy pygad matplotlib
```

2. Execute o script:

```bash
python tsp_ga.py
```

## Resultados

O programa irá:

1. Executar o algoritmo genético
2. Mostrar o melhor valor de fitness encontrado
3. Exibir a melhor rota encontrada
4. Gerar visualizações do progresso e da rota

## Considerações sobre a Implementação

### Pontos Fortes

1. Uso de coordenadas reais das cidades
2. Visualização clara da rota no mapa
3. Monitoramento do progresso do fitness
4. Implementação modular e bem documentada

### Desafios Encontrados

1. Ajuste dos parâmetros do AG para melhor convergência
2. Tratamento de permutações válidas no cromossomo
3. Balanceamento entre exploração e explotação

### Possíveis Melhorias

1. Implementação de operadores de cruzamento específicos para TSP
2. Adição de técnicas de otimização local
3. Paralelização do algoritmo
4. Interface gráfica para interação com o usuário
