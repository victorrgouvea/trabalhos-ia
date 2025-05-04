import numpy as np
import pygad
import matplotlib.pyplot as plt
from typing import List, Tuple
import random

# Dicionário com cidades de Santa Catarina (população ≳ 50 mil) e suas coordenadas aproximadas (latitude, longitude)
cities = {
    'Florianópolis': (-27.5954, -48.5480),
    'Joinville': (-26.3044, -48.8487),
    'Blumenau': (-26.9196, -49.0661),
    'São José': (-27.6164, -48.6305),
    'Chapecó': (-27.0962, -52.6066),
    'Criciúma': (-28.6773, -49.3721),
    'Itajaí': (-26.9114, -48.6636),
    'Balneário Camboriú': (-26.9898, -48.6367),
    'Palhoça': (-27.6283, -48.6994),
    'Biguaçu': (-27.5333, -48.7000),
    'Lages': (-27.8170, -50.3374),
    'Jaraguá do Sul': (-26.4813, -49.0682),
    'Tubarão': (-28.4685, -49.0016),
    'Brusque': (-27.1050, -48.9300),
    'Camboriú': (-26.9886, -48.6442),
    'Concórdia': (-27.2326, -52.0103),
    'Itapema': (-27.1891, -48.6099),
    'São Bento do Sul': (-26.2460, -48.6140),
    'Araranguá': (-28.9300, -49.4500),
    'Nova Trento': (-26.2850, -48.9450)
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
    Cada solução é uma permutação única dos índices de 0 a num_cities-1.
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
    Preserva a sequência de cidades de um dos pais e preenche os vazios com os elementos do outro pai.
    """
    offspring = []

    for k in range(offspring_size[0]):
        # Seleciona dois pais aleatórios
        parent1_idx = random.randint(0, len(parents) - 1)
        parent2_idx = random.randint(0, len(parents) - 1)

        parent1 = parents[parent1_idx].copy()
        parent2 = parents[parent2_idx].copy()

        size = len(parent1)
        point1 = random.randint(0, size - 2)
        point2 = random.randint(point1 + 1, size - 1)

        offspring1 = np.full_like(parent1, -1)
        offspring1[point1:point2+1] = parent1[point1:point2+1]

        # Preenche os elementos restantes na ordem do segundo pai,
        # ignorando os elementos já presentes no segmento copiado
        remaining_elements = [x for x in parent2 if x not in offspring1[point1:point2+1]]
        j = 0

        # Preenche a parte após o segmento
        for i in range(point2+1, size):
            offspring1[i] = remaining_elements[j]
            j += 1
        # Preenche a parte antes do segmento
        for i in range(0, point1):
            offspring1[i] = remaining_elements[j]
            j += 1

        offspring.append(offspring1)

    return np.array(offspring)

def custom_mutation_func(offspring, ga_instance):
    """
    Implementa a mutação por troca (swap mutation).
    Troca duas posições aleatórias no cromossomo para manter a validade da permutação.
    """
    for chromosome in offspring:
        if random.random() < ga_instance.mutation_probability:
            pos1, pos2 = random.sample(range(len(chromosome)), 2)
            chromosome[pos1], chromosome[pos2] = chromosome[pos2], chromosome[pos1]
    return offspring

def fitness_func(ga_instance, solution: np.ndarray, solution_idx: int) -> float:
    """
    Calcula o fitness como o inverso da distância total percorrida na rota.
    Uma rota com distância menor gera um fitness maior.
    """
    total_distance_val = 0
    num_cities = len(solution)

    for i in range(num_cities):
        current_city = int(solution[i])
        next_city = int(solution[(i + 1) % num_cities])  # Retorna para a primeira cidade
        total_distance_val += distance_matrix[current_city][next_city]

    return 1.0 / total_distance_val

def plot_route(solution: np.ndarray, title: str = "Melhor Rota"):
    """Plota a rota do caixeiro viajante sobre um mapa simplificado."""
    plt.figure(figsize=(10, 6))

    # Plota as cidades
    plt.scatter(city_coords[:, 1], city_coords[:, 0], c='red', s=100)

    # Adiciona os nomes das cidades
    for i, city in enumerate(city_names):
        plt.annotate(city, (city_coords[i, 1], city_coords[i, 0]), xytext=(5, 5),
                     textcoords='offset points')

    # Conecta as cidades conforme a solução encontrada
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
    """Callback executado a cada geração para visualizar a evolução do fitness."""
    if ga_instance.generations_completed % 100 == 0:
        plt.figure(figsize=(10, 6))
        plt.plot(ga_instance.best_solutions_fitness)
        plt.title("Progresso do Fitness ao Longo das Gerações")
        plt.xlabel("Geração")
        plt.ylabel("Fitness")
        plt.grid(True)
        plt.show()

# Parâmetros do Algoritmo Genético
num_generations = 1000  # Aumentado para permitir uma melhor convergência
num_parents_mating = 4
num_genes = len(cities)
population_size = 50

# Criando a população inicial com permutações válidas das cidades
initial_population = custom_init_population(population_size, num_genes)

# Configurando o GA com os operadores customizados
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
    sol_per_pop=population_size
)

# Executando o Algoritmo Genético
ga_instance.run()

# Obtendo a melhor solução
solution, solution_fitness, _ = ga_instance.best_solution()
print(f"Melhor fitness: {solution_fitness}\n")

print("Melhor rota encontrada:")
for i in range(len(solution)):
    city_idx = int(solution[i])
    print(f"{i+1}. {city_names[city_idx]}")

# Plota a melhor rota encontrada
plot_route(solution, "Melhor Rota Encontrada")
