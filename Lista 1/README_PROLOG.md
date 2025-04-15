# Sistema de Guia Turístico em Prolog

Este módulo implementa um guia turístico para Florianópolis usando Prolog, permitindo consultas baseadas em locais, tipos de atrações, custos, horários ideais e condições climáticas.

## Requisitos

- SWI-Prolog instalado (versão 7.6.4 ou superior)

## Instalação do SWI-Prolog

### Ubuntu/Debian

```bash
sudo apt-get update
sudo apt-get install swi-prolog
```

## Arquivos do Sistema

- `turismo.pl` - Arquivo principal contendo os fatos e regras do sistema

## Como Executar

### Modo Interativo

1. Abra o terminal no diretório que contém o arquivo `turismo.pl`
2. Inicie o SWI-Prolog:

```bash
swipl
```

3. Carregue o arquivo:

```prolog
?- [turismo].
```

4. Faça suas consultas (veja exemplos abaixo)

## Consultas Disponíveis

### Consultas por Características

1. **Locais por tipo**:

```prolog
?- local_por_tipo(Local, Tipo).
```

Exemplo: `?- local_por_tipo(Local, praia).`

2. **Locais por custo**:

```prolog
?- local_por_custo(Local, NivelCusto).
```

Exemplo: `?- local_por_custo(Local, baixo).`

3. **Locais por horário**:

```prolog
?- local_por_horario(Local, Periodo).
```

Exemplo: `?- local_por_horario(Local, manha).`

4. **Locais por condição climática**:

```prolog
?- local_por_clima(Local, CondicaoClimatica).
```

Exemplo: `?- local_por_clima(Local, ensolarado).`

### Consultas Compostas

1. **Recomendação completa**:

```prolog
?- recomendacao(Local, Tipo, NivelCusto, Periodo, CondicaoClimatica).
```

Exemplo: `?- recomendacao(Local, praia, baixo, manha, ensolarado).`

2. **Recomendação personalizada**:

```prolog
?- recomendacao_personalizada(Local, Custo, Periodo, Clima).
```

Exemplo: `?- recomendacao_personalizada(Local, baixo, manha, ensolarado).`

### Consultas Específicas

1. **Locais econômicos**:

```prolog
?- locais_economicos(Local).
```

2. **Locais para dias chuvosos**:

```prolog
?- locais_para_dia_de_chuva(Local).
```

3. **Locais para visitar pela manhã**:

```prolog
?- locais_para_manha(Local).
```

4. **Praias disponíveis**:

```prolog
?- locais_praias(Local).
```
