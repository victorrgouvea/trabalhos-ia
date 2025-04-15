% ---------- LOCAIS ----------
% Define todos os locais turísticos de Florianópolis
local(praia_da_daniela).
local(lagoa_do_peri).
local(dunas_da_joaquina).
local(ilha_do_campeche).
local(shopping_beira_mar).
local(piscinas_naturais_da_barra_da_lagoa).
local(mercado_publico).
local(lagoinha_do_leste).
local(lagoa_da_conceicao).
local(santo_antonio_de_lisboa).
local(via_gastronomica_coqueiros).
local(museu_historico_santa_catarina).
local(igreja_sao_francisco_de_paula).
local(parque_de_coqueiros).
local(ponte_hercilio_luz).
local(trilha_morro_da_gravata).
local(barco_pirata_floripa).
local(shopping_villa_romana).

% ---------- TIPOS ----------
tipo(praia_da_daniela, praia).
tipo(ilha_do_campeche, praia).
tipo(lagoinha_do_leste, trilha).
tipo(trilha_morro_da_gravata, trilha).
tipo(dunas_da_joaquina, turismo).
tipo(parque_de_coqueiros, parque).
tipo(lagoa_do_peri, turismo).
tipo(lagoa_da_conceicao, turismo).
tipo(shopping_beira_mar, shopping).
tipo(shopping_villa_romana, shopping).
tipo(mercado_publico, alimentacao).
tipo(via_gastronomica_coqueiros, alimentacao).
tipo(piscinas_naturais_da_barra_da_lagoa, trilha).
tipo(santo_antonio_de_lisboa, turismo).
tipo(museu_historico_santa_catarina, turismo).
tipo(igreja_sao_francisco_de_paula, turismo).
tipo(ponte_hercilio_luz, turismo).
tipo(barco_pirata_floripa, turismo).

% ---------- CUSTO ----------
custo(praia_da_daniela, baixo).
custo(lagoa_do_peri, baixo).
custo(dunas_da_joaquina, medio).
custo(ilha_do_campeche, alto).
custo(shopping_beira_mar, medio).
custo(piscinas_naturais_da_barra_da_lagoa, baixo).
custo(mercado_publico, medio).
custo(lagoinha_do_leste, baixo).
custo(lagoa_da_conceicao, baixo).
custo(santo_antonio_de_lisboa, baixo).
custo(via_gastronomica_coqueiros, alto).
custo(museu_historico_santa_catarina, baixo).
custo(igreja_sao_francisco_de_paula, baixo).
custo(parque_de_coqueiros, baixo).
custo(ponte_hercilio_luz, baixo).
custo(trilha_morro_da_gravata, baixo).
custo(barco_pirata_floripa, medio).
custo(shopping_villa_romana, alto).

% ---------- HORÁRIO ----------
horario(praia_da_daniela, manha).
horario(lagoa_do_peri, tarde).
horario(dunas_da_joaquina, tarde).
horario(ilha_do_campeche, manha).
horario(shopping_beira_mar, noite).
horario(piscinas_naturais_da_barra_da_lagoa, manha).
horario(mercado_publico, tarde).
horario(lagoinha_do_leste, tarde).
horario(lagoa_da_conceicao, tarde).
horario(santo_antonio_de_lisboa, manha).
horario(via_gastronomica_coqueiros, noite).
horario(museu_historico_santa_catarina, tarde).
horario(igreja_sao_francisco_de_paula, manha).
horario(parque_de_coqueiros, tarde).
horario(ponte_hercilio_luz, noite).
horario(trilha_morro_da_gravata, manha).
horario(barco_pirata_floripa, tarde).
horario(shopping_villa_romana, noite).

% ---------- CLIMA ----------
clima(praia_da_daniela, ensolarado).
clima(lagoa_do_peri, ensolarado).
clima(dunas_da_joaquina, ensolarado).
clima(ilha_do_campeche, ensolarado).
clima(shopping_beira_mar, chuvoso).
clima(piscinas_naturais_da_barra_da_lagoa, ensolarado).
clima(mercado_publico, nublado).
clima(lagoinha_do_leste, ensolarado).
clima(lagoa_da_conceicao, ensolarado).
clima(santo_antonio_de_lisboa, ensolarado).
clima(via_gastronomica_coqueiros, nublado).
clima(museu_historico_santa_catarina, nublado).
clima(igreja_sao_francisco_de_paula, nublado).
clima(parque_de_coqueiros, ensolarado).
clima(ponte_hercilio_luz, ensolarado).
clima(trilha_morro_da_gravata, ensolarado).
clima(barco_pirata_floripa, ensolarado).
clima(shopping_villa_romana, chuvoso).

% ---------- REGRAS DE CONSULTA ----------
local_por_tipo(Local, Tipo) :-
    local(Local),
    tipo(Local, Tipo).

local_por_custo(Local, NivelCusto) :-
    local(Local),
    custo(Local, NivelCusto).

local_por_horario(Local, Periodo) :-
    local(Local),
    horario(Local, Periodo).

local_por_clima(Local, CondicaoClimatica) :-
    local(Local),
    clima(Local, CondicaoClimatica).

% Consulta combinada para encontrar locais que atendam a múltiplos critérios
recomendacao(Local, Tipo, NivelCusto, Periodo, CondicaoClimatica) :-
    local(Local),
    tipo(Local, Tipo),
    custo(Local, NivelCusto),
    horario(Local, Periodo),
    clima(Local, CondicaoClimatica).

% Consultas específicas para encontrar locais com base em preferências
locais_economicos(Local) :-
    local_por_custo(Local, baixo).

locais_para_dia_de_chuva(Local) :-
    local_por_clima(Local, chuvoso).

locais_para_manha(Local) :-
    local_por_horario(Local, manha).

locais_praias(Local) :-
    local_por_tipo(Local, praia).

% Regra de recomendação de passeio personalizado
recomendacao_personalizada(Local, Custo, Periodo, Clima) :-
    local(Local),
    custo(Local, Custo),
    horario(Local, Periodo),
    clima(Local, Clima).
