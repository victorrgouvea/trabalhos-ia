;;; Testes do Sistema Especialista de Guia Turístico

;; Carrega o arquivo principal
(load "turismo.clp")

;; Função para executar todos os testes
(deffunction testar-sistema ()
    (printout t "=== Iniciando Testes do Sistema Especialista ===" crlf)
    
    ;; Teste 1: Local por tipo
    (printout t crlf "Teste 1: Busca por tipo 'praia'" crlf)
    (executar-consulta "tipo" "praia")
    
    ;; Teste 2: Local por custo
    (printout t crlf "Teste 2: Busca por custo 'baixo'" crlf)
    (executar-consulta "custo" "baixo")
    
    ;; Teste 3: Local por horário
    (printout t crlf "Teste 3: Busca por horário 'manha'" crlf)
    (executar-consulta "horario" "manha")
    
    ;; Teste 4: Local por clima
    (printout t crlf "Teste 4: Busca por clima 'ensolarado'" crlf)
    (executar-consulta "clima" "ensolarado")
    
    ;; Teste 5: Recomendação completa
    (printout t crlf "Teste 5: Recomendação completa para praia" crlf)
    (assert (recomendacao (local "praia-mole") (tipo "praia") (custo "medio") 
                         (horario "tarde") (clima "ensolarado")))
    (run)
    
    ;; Teste 6: Locais econômicos
    (printout t crlf "Teste 6: Busca por locais econômicos" crlf)
    (assert (local (nome ?nome) (custo "baixo")))
    (run)
    
    ;; Teste 7: Locais para dia chuvoso
    (printout t crlf "Teste 7: Busca por locais para dia chuvoso" crlf)
    (assert (local (nome ?nome) (clima "chuvoso")))
    (run)
    
    ;; Teste 8: Locais para manhã
    (printout t crlf "Teste 8: Busca por locais para manhã" crlf)
    (assert (local (nome ?nome) (horario "manha")))
    (run)
    
    ;; Teste 9: Todas as praias
    (printout t crlf "Teste 9: Lista de todas as praias" crlf)
    (assert (local (nome ?nome) (tipo "praia")))
    (run)
    
    (printout t crlf "=== Fim dos Testes ===" crlf)
)

;; Executa os testes
(testar-sistema) 