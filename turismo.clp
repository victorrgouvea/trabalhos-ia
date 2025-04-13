;;; Sistema Especialista de Guia Turístico em CLIPS
;;; Domínios: Locais, Tipos, Condições e Recomendações

;;; Definição dos frames
(deftemplate local
    (slot nome)
    (slot tipo)
    (slot custo)
    (slot horario)
    (slot clima))

(deftemplate tipo
    (slot nome)
    (slot descricao)
    (slot recomendacoes))

(deftemplate condicao
    (slot nome)
    (slot descricao)
    (slot recomendacoes))

(deftemplate recomendacao
    (slot local)
    (slot tipo)
    (slot custo)
    (slot horario)
    (slot clima)
    (slot sugestoes))

;;; Definição dos fatos
(deffacts locais
    (local (nome praia_da_daniela) (tipo praia) (custo baixo) (horario manha) (clima ensolarado))
    (local (nome lagoa_do_peri) (tipo turismo) (custo baixo) (horario tarde) (clima ensolarado))
    (local (nome dunas_da_joaquina) (tipo turismo) (custo medio) (horario tarde) (clima ensolarado))
    (local (nome ilha_do_campeche) (tipo praia) (custo alto) (horario manha) (clima ensolarado))
    (local (nome shopping_beira_mar) (tipo shopping) (custo medio) (horario noite) (clima chuvoso))
    (local (nome piscinas_naturais_da_barra_da_lagoa) (tipo trilha) (custo baixo) (horario manha) (clima ensolarado))
    (local (nome mercado_publico) (tipo alimentacao) (custo medio) (horario tarde) (clima nublado))
    (local (nome lagoinha_do_leste) (tipo trilha) (custo baixo) (horario tarde) (clima ensolarado))
    (local (nome lagoa_da_conceicao) (tipo turismo) (custo baixo) (horario tarde) (clima ensolarado))
    (local (nome santo_antonio_de_lisboa) (tipo turismo) (custo baixo) (horario manha) (clima ensolarado))
    (local (nome via_gastronomica_coqueiros) (tipo alimentacao) (custo alto) (horario noite) (clima nublado))
    (local (nome museu_historico_santa_catarina) (tipo turismo) (custo baixo) (horario tarde) (clima nublado))
    (local (nome igreja_sao_francisco_de_paula) (tipo turismo) (custo baixo) (horario manha) (clima nublado))
    (local (nome parque_de_coqueiros) (tipo parque) (custo baixo) (horario tarde) (clima ensolarado))
    (local (nome ponte_hercilio_luz) (tipo turismo) (custo baixo) (horario noite) (clima ensolarado))
    (local (nome trilha_morro_da_gravata) (tipo trilha) (custo baixo) (horario manha) (clima ensolarado))
    (local (nome barco_pirata_floripa) (tipo turismo) (custo medio) (horario tarde) (clima ensolarado))
    (local (nome shopping_villa_romana) (tipo shopping) (custo alto) (horario noite) (clima chuvoso)))

(deffacts tipos
    (tipo (nome praia) (descricao "Praias para banho e lazer") (recomendacoes "Levar protetor solar, toalha e roupa de banho"))
    (tipo (nome trilha) (descricao "Trilhas para caminhadas") (recomendacoes "Usar calçado adequado, levar água e lanche"))
    (tipo (nome parque) (descricao "Parques e áreas de conservação") (recomendacoes "Levar repelente e câmera fotográfica"))
    (tipo (nome turismo) (descricao "Pontos turísticos diversos") (recomendacoes "Levar câmera fotográfica e guia turístico"))
    (tipo (nome shopping) (descricao "Centros comerciais") (recomendacoes "Verificar horário de funcionamento"))
    (tipo (nome alimentacao) (descricao "Locais gastronômicos") (recomendacoes "Verificar cardápio e preços")))

(deffacts condicoes
    (condicao (nome ensolarado) (descricao "Dia de sol") (recomendacoes "Usar protetor solar e chapéu"))
    (condicao (nome nublado) (descricao "Dia nublado") (recomendacoes "Levar guarda-chuva e agasalho"))
    (condicao (nome chuvoso) (descricao "Dia chuvoso") (recomendacoes "Usar capa de chuva e calçado impermeável")))

;;; Regras de inferência
(defrule local-por-tipo
    (local (nome ?nome) (tipo ?tipo))
    (tipo (nome ?tipo) (descricao ?desc) (recomendacoes ?rec))
    =>
    (printout t "Local: " ?nome crlf)
    (printout t "Tipo: " ?tipo " - " ?desc crlf)
    (printout t "Recomendações: " ?rec crlf crlf))

(defrule local-por-custo
    (local (nome ?nome) (custo ?custo))
    =>
    (printout t "Local: " ?nome crlf)
    (printout t "Custo: " ?custo crlf crlf))

(defrule local-por-horario
    (local (nome ?nome) (horario ?horario))
    =>
    (printout t "Local: " ?nome crlf)
    (printout t "Horário ideal: " ?horario crlf crlf))

(defrule local-por-clima
    (local (nome ?nome) (clima ?clima))
    (condicao (nome ?clima) (descricao ?desc) (recomendacoes ?rec))
    =>
    (printout t "Local: " ?nome crlf)
    (printout t "Clima ideal: " ?clima " - " ?desc crlf)
    (printout t "Recomendações: " ?rec crlf crlf))

(defrule recomendacao-completa
    (local (nome ?nome) (tipo ?tipo) (custo ?custo) (horario ?horario) (clima ?clima))
    (tipo (nome ?tipo) (recomendacoes ?rec-tipo))
    (condicao (nome ?clima) (recomendacoes ?rec-clima))
    =>
    (printout t "Recomendação completa para " ?nome ":" crlf)
    (printout t "Tipo: " ?tipo crlf)
    (printout t "Custo: " ?custo crlf)
    (printout t "Horário: " ?horario crlf)
    (printout t "Clima: " ?clima crlf)
    (printout t "Recomendações do tipo: " ?rec-tipo crlf)
    (printout t "Recomendações do clima: " ?rec-clima crlf crlf))

(defrule locais-economicos
    (local (nome ?nome) (custo baixo))
    =>
    (printout t "Local econômico: " ?nome crlf))

(defrule locais-para-dia-chuva
    (local (nome ?nome) (clima chuvoso))
    =>
    (printout t "Local para dia chuvoso: " ?nome crlf))

(defrule locais-para-manha
    (local (nome ?nome) (horario manha))
    =>
    (printout t "Local para manhã: " ?nome crlf))

(defrule locais-praias
    (local (nome ?nome) (tipo praia))
    =>
    (printout t "Praia: " ?nome crlf))

;;; Função para executar consultas
(deffunction consulta (?tipo-consulta ?parametro)
    (bind ?encontrou FALSE)
    (if (eq ?tipo-consulta "tipo") then
        (do-for-all-facts ((?f local)) TRUE
            (if (eq ?f:tipo ?parametro) then
                (printout t ?f:nome crlf)
                (bind ?encontrou TRUE))))
    (if (eq ?tipo-consulta "custo") then
        (do-for-all-facts ((?f local)) TRUE
            (if (eq ?f:custo ?parametro) then
                (printout t ?f:nome crlf)
                (bind ?encontrou TRUE))))
    (if (eq ?tipo-consulta "horario") then
        (do-for-all-facts ((?f local)) TRUE
            (if (eq ?f:horario ?parametro) then
                (printout t ?f:nome crlf)
                (bind ?encontrou TRUE))))
    (if (eq ?tipo-consulta "clima") then
        (do-for-all-facts ((?f local)) TRUE
            (if (eq ?f:clima ?parametro) then
                (printout t ?f:nome crlf)
                (bind ?encontrou TRUE))))
    (return ?encontrou))

;;; Função para recomendar passeios com critérios opcionais
(deffunction recomendar (?tipo ?clima ?custo ?horario)
    (printout t crlf "=== Recomendações de Passeio ===" crlf)
    (printout t "Critérios especificados:" crlf)
    (if (neq ?tipo "qualquer") then (printout t "- Tipo: " ?tipo crlf))
    (if (neq ?clima "qualquer") then (printout t "- Clima: " ?clima crlf))
    (if (neq ?custo "qualquer") then (printout t "- Custo: " ?custo crlf))
    (if (neq ?horario "qualquer") then (printout t "- Horário: " ?horario crlf))
    (printout t crlf)
    
    (bind ?encontrou FALSE)
    (do-for-all-facts ((?f local)) TRUE
        (bind ?atende_criterios TRUE)
        
        (if (and (neq ?tipo "qualquer") (neq ?f:tipo ?tipo))
            then (bind ?atende_criterios FALSE))
        (if (and (neq ?clima "qualquer") (neq ?f:clima ?clima))
            then (bind ?atende_criterios FALSE))
        (if (and (neq ?custo "qualquer") (neq ?f:custo ?custo))
            then (bind ?atende_criterios FALSE))
        (if (and (neq ?horario "qualquer") (neq ?f:horario ?horario))
            then (bind ?atende_criterios FALSE))
            
        (if ?atende_criterios then
            (printout t "Local: " ?f:nome crlf)
            (printout t "Tipo: " ?f:tipo crlf)
            (printout t "Custo: " ?f:custo crlf)
            (printout t "Horário: " ?f:horario crlf)
            (printout t "Clima: " ?f:clima crlf)
            (printout t "---" crlf)
            (bind ?encontrou TRUE)))
    
    (if (not ?encontrou) then
        (printout t "Nenhum local encontrado com os critérios especificados." crlf))
    
    (return TRUE)) 