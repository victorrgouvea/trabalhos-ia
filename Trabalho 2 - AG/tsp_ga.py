import numpy as np
import pygad
import matplotlib.pyplot as plt
from typing import List, Tuple
import random

# Definindo as cidades e suas coordenadas (x, y)
cities = {
    'Florianópolis': (27.5969, 48.5495),
    'São José': (27.6136, 48.6366),
    'Palhoça': (27.6455, 48.6697),
    'Biguaçu': (27.4961, 48.6598),
    'Santo Amaro': (27.6852, 48.7784),
    'Governador Celso Ramos': (27.3171, 48.5580),
    'Tijucas': (27.2423, 48.6321),
    'São Pedro de Alcântara': (27.5665, 48.8048),
    'Antônio Carlos': (27.5190, 48.7657),
    'Águas Mornas': (27.6963, 48.8243)
}

# Convertendo o dicionário em listas para facilitar o acesso
city_names = list(cities.keys())
city_coords = np.array(list(cities.values()))

def calculate_distance(city1: Tuple[float, float], city2: Tuple[float, float]) -> float:
    """Calcula a distância euclidiana entre duas cidades."""
    return np.sqrt(np.sum((np.array(city1) - np.array(city2)) ** 2))

def create_distance_matrix() -> np.ndarray:
    """Cria a matriz de distâncias entre todas as cidades."""
    num_cities = len(cities)
    distance_matrix = np.zeros((num_cities, num_cities))
    
    for i in range(num_cities):
        for j in range(num_cities):
            if i != j:
                distance_matrix[i][j] = calculate_distance(city_coords[i], city_coords[j])
    
    return distance_matrix

def custom_init_population(num_solutions, num_cities):
    """
    Inicializa a população com permutações válidas das cidades.
    Cada solução é uma permutação única de 0 a num_cities-1.
    """
    initial_population = np.zeros((num_solutions, num_cities))
    for i in range(num_solutions):
        initial_population[i] = np.random.permutation(num_cities)
    return initial_population

# Criando a matriz de distâncias
distance_matrix = create_distance_matrix()

def custom_crossover_func(parents, offspring_size, ga_instance):
    """
    Implementa o Order Crossover (OX) para o TSP.
    Este operador preserva a ordem e posição dos elementos do primeiro pai
    e preenche os elementos restantes na ordem que aparecem no segundo pai.
    """
    offspring = []
    
    for k in range(offspring_size[0]):
        # Selecionando dois pais aleatoriamente
        parent1_idx = random.randint(0, len(parents) - 1)
        parent2_idx = random.randint(0, len(parents) - 1)
        
        parent1 = parents[parent1_idx].copy()
        parent2 = parents[parent2_idx].copy()
        
        # Escolhendo dois pontos de corte aleatórios
        size = len(parent1)
        point1 = random.randint(0, size-2)
        point2 = random.randint(point1+1, size-1)
        
        # Inicializando offspring com valores inválidos
        offspring1 = np.full_like(parent1, -1)
        
        # Copiando a sequência entre os pontos de corte do primeiro pai
        offspring1[point1:point2+1] = parent1[point1:point2+1]
        
        # Preenchendo os elementos restantes na ordem que aparecem no segundo pai
        remaining_elements = [x for x in parent2 if x not in offspring1[point1:point2+1]]
        j = 0
        
        # Preenchendo a parte final
        for i in range(point2+1, size):
            offspring1[i] = remaining_elements[j]
            j += 1
            
        # Preenchendo a parte inicial
        for i in range(0, point1):
            offspring1[i] = remaining_elements[j]
            j += 1
        
        offspring.append(offspring1)
    
    return np.array(offspring)

def custom_mutation_func(offspring, ga_instance):
    """
    Implementa a mutação por troca (swap mutation).
    Troca duas posições aleatórias no cromossomo.
    """
    for chromosome in offspring:
        if random.random() < ga_instance.mutation_probability:
            # Escolhendo duas posições aleatórias
            pos1, pos2 = random.sample(range(len(chromosome)), 2)
            # Trocando os valores
            chromosome[pos1], chromosome[pos2] = chromosome[pos2], chromosome[pos1]
    
    return offspring

def fitness_func(ga_instance, solution: np.ndarray, solution_idx: int) -> float:
    """
    Função de fitness que calcula o inverso da distância total do percurso.
    Quanto menor a distância, maior o fitness.
    
    Args:
        ga_instance: Instância do algoritmo genético
        solution: Array com a sequência de cidades
        solution_idx: Índice da solução na população
    """
    total_distance = 0
    num_cities = len(solution)
    
    for i in range(num_cities):
        # Calculando a distância entre a cidade atual e a próxima
        current_city = int(solution[i])
        next_city = int(solution[(i + 1) % num_cities])  # Volta para a primeira cidade
        total_distance += distance_matrix[current_city][next_city]
    
    # Retornando o inverso da distância total (quanto menor a distância, maior o fitness)
    return 1.0 / total_distance

def plot_route(solution: np.ndarray, title: str = "Melhor Rota"):
    """Plota a rota do caixeiro viajante."""
    plt.figure(figsize=(10, 6))
    
    # Plotando as cidades
    plt.scatter(city_coords[:, 1], city_coords[:, 0], c='red', s=100)
    
    # Adicionando labels das cidades
    for i, city in enumerate(city_names):
        plt.annotate(city, (city_coords[i, 1], city_coords[i, 0]), xytext=(5, 5), 
                    textcoords='offset points')
    
    # Plotando as conexões entre as cidades
    for i in range(len(solution)):
        current_city = int(solution[i])
        next_city = int(solution[(i + 1) % len(solution)])
        plt.plot([city_coords[current_city, 1], city_coords[next_city, 1]],
                [city_coords[current_city, 0], city_coords[next_city, 0]], 'b-')
    
    plt.title(title)
    plt.xlabel('Longitude')
    plt.ylabel('Latitude')
    plt.grid(True)
    plt.show()

def on_generation(ga_instance):
    """Callback chamado ao final de cada geração."""
    if ga_instance.generations_completed % 100 == 0:  # Plot a cada 100 gerações
        plt.figure(figsize=(10, 6))
        plt.plot(ga_instance.best_solutions_fitness)
        plt.title("Progresso do Fitness ao Longo das Gerações")
        plt.xlabel("Geração")
        plt.ylabel("Fitness")
        plt.grid(True)
        plt.show()

# Parâmetros do algoritmo genético
num_generations = 1000  # Aumentado para melhor convergência
num_parents_mating = 4
num_genes = len(cities)

# Criando a população inicial
initial_population = custom_init_population(50, num_genes)

# Criando a instância do GA com os operadores customizados
ga_instance = pygad.GA(
    num_generations=num_generations,
    num_parents_mating=num_parents_mating,
    num_genes=num_genes,
    initial_population=initial_population,
    fitness_func=fitness_func,
    crossover_type=custom_crossover_func,
    mutation_type=custom_mutation_func,
    mutation_probability=0.1,
    on_generation=on_generation,
    sol_per_pop=50
)

# Executando o algoritmo genético
ga_instance.run()

# Obtendo a melhor solução
solution, solution_fitness, _ = ga_instance.best_solution()
print(f"Melhor fitness: {solution_fitness}")

# Mostrando a rota
print("\nMelhor rota encontrada:")
for i in range(len(solution)):
    city_idx = int(solution[i])
    print(f"{i+1}. {city_names[city_idx]}")

# Plotando a melhor rota
plot_route(solution, "Melhor Rota Encontrada") 