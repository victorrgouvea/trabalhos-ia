# Algoritmo Genético para o Problema do Caixeiro Viajante

Este projeto implementa um Algoritmo Genético (AG) para resolver o Problema do Caixeiro Viajante (TSP - Traveling Salesman Problem) usando a biblioteca PyGAD.

## Instalação e Execução

### Requisitos

- Python 3.x
- Bibliotecas necessárias:
  - NumPy
  - PyGAD
  - Matplotlib

### Como Executar

1. Instale as dependências:

```bash
pip install numpy pygad matplotlib
```

2. Execute o script principal:

```bash
python tsp_ga.py
```

3. O programa irá:
   - Executar o algoritmo genético
   - Mostrar o melhor valor de fitness encontrado
   - Gerar visualizações do progresso, mostrando gráficos seguidamente com a evolução do algoritmo
   - Exibir a melhor rota encontrada, tanto no terminal quanto em um plot
