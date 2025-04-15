# Sistema Especialista de Guia Turístico em CLIPS

Este é um sistema especialista desenvolvido em CLIPS para recomendar passeios turísticos em Florianópolis com base em diferentes critérios.

## Estrutura do Sistema

O sistema possui quatro domínios principais:

- **Locais**: Pontos turísticos de Florianópolis
- **Tipos**: Categorias de atrações (praia, trilha, parque, etc.)
- **Condições**: Condições climáticas
- **Recomendações**: Sugestões baseadas nas características dos locais

## Como Executar

1. Inicie o CLIPS:

```bash
clips
```

2. Carregue o arquivo principal:

```clips
(load "turismo.clp")
```

3. Inicialize a base de conhecimento:

```clips
(reset)
```

## Comandos Disponíveis

### 1. Consulta Simples

Use a função `consulta` para buscar locais por um único critério:

```clips
(consulta "tipo" praia)      ; Busca por tipo de local
(consulta "custo" baixo)     ; Busca por custo
(consulta "horario" manha)   ; Busca por horário
(consulta "clima" ensolarado); Busca por clima
```

### 2. Recomendação Personalizada

Use a função `recomendar` para buscar locais com múltiplos critérios:

```clips
(recomendar tipo clima custo horario)
```

Onde:

- `tipo`: praia, trilha, parque, turismo, shopping, alimentacao, "qualquer"
- `clima`: ensolarado, nublado, chuvoso, "qualquer"
- `custo`: baixo, medio, alto, "qualquer"
- `horario`: manha, tarde, noite, "qualquer"

### Exemplos de Uso

1. Encontrar praias baratas:

```clips
(recomendar praia "qualquer" baixo "qualquer")
```

2. Encontrar locais para dia chuvoso:

```clips
(recomendar "qualquer" chuvoso "qualquer" "qualquer")
```

3. Encontrar locais noturnos de custo médio:

```clips
(recomendar "qualquer" "qualquer" medio noite)
```

4. Encontrar trilhas para manhã:

```clips
(recomendar trilha "qualquer" "qualquer" manha)
```

5. Encontrar praia barata para manhã ensolarada:

```clips
(recomendar praia ensolarado baixo manha)
```

6. Listar todos os locais:

```clips
(recomendar "qualquer" "qualquer" "qualquer" "qualquer")
```

## Valores Possíveis

### Tipos de Local

- praia
- trilha
- parque
- turismo
- shopping
- alimentacao

### Climas

- ensolarado
- nublado
- chuvoso

### Custos

- baixo
- medio
- alto

### Horários

- manha
- tarde
- noite

## Executando Testes

Para executar todos os testes do sistema:

1. Carregue o arquivo de testes:

```clips
(load "testes_turismo.clp")
```

2. Execute a função de testes:

```clips
(testar-sistema)
```

## Observações

- Use "qualquer" (com aspas) quando um critério não for importante
- Valores como praia, baixo, manha, etc. não precisam de aspas
- O sistema mostrará todos os locais que atendem aos critérios especificados
- Se nenhum local for encontrado, o sistema informará que não há resultados
