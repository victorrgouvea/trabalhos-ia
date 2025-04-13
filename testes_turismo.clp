;;; Testes do Sistema Especialista de Guia Turístico

;; Função para executar todos os testes
(deffunction testar-sistema ()
    (printout t "=== Iniciando Testes do Sistema Especialista ===" crlf)
    
    ;; Teste 1: Local por tipo
    (printout t crlf "Teste 1: Busca por tipo 'praia'" crlf)
    (consulta "tipo" praia)
    
    ;; Teste 2: Local por custo
    (printout t crlf "Teste 2: Busca por custo 'baixo'" crlf)
    (consulta "custo" baixo)
    
    ;; Teste 3: Local por horário
    (printout t crlf "Teste 3: Busca por horário 'manha'" crlf)
    (consulta "horario" manha)
    
    ;; Teste 4: Local por clima
    (printout t crlf "Teste 4: Busca por clima 'ensolarado'" crlf)
    (consulta "clima" ensolarado)
    
    ;; Teste 5: Recomendação com múltiplos critérios - Praias baratas
    (printout t crlf "Teste 5: Recomendação de praias baratas" crlf)
    (recomendar praia "qualquer" baixo "qualquer")
    
    ;; Teste 6: Recomendação com múltiplos critérios - Locais para dia chuvoso
    (printout t crlf "Teste 6: Recomendação para dia chuvoso" crlf)
    (recomendar "qualquer" chuvoso "qualquer" "qualquer")
    
    ;; Teste 7: Recomendação com múltiplos critérios - Locais noturnos de custo médio
    (printout t crlf "Teste 7: Recomendação de locais noturnos de custo médio" crlf)
    (recomendar "qualquer" "qualquer" medio noite)
    
    ;; Teste 8: Recomendação com múltiplos critérios - Trilhas para manhã
    (printout t crlf "Teste 8: Recomendação de trilhas para manhã" crlf)
    (recomendar trilha "qualquer" "qualquer" manha)
    
    ;; Teste 9: Recomendação com todos os critérios específicos
    (printout t crlf "Teste 9: Recomendação específica - Praia barata para manhã ensolarada" crlf)
    (recomendar praia ensolarado baixo manha)
    
    ;; Teste 10: Recomendação sem critérios
    (printout t crlf "Teste 10: Lista de todos os locais" crlf)
    (recomendar "qualquer" "qualquer" "qualquer" "qualquer")
    
    (printout t crlf "=== Fim dos Testes ===" crlf)
) 