# Tasks: Implementação da Tabela 'subjects'

## Checklist de Execução

### Fase 1: Validação
- [ ] **Validar sintaxe XanoScript**
  - Comando: `python -m py_compile tables/subjects.xs` (ou validar manualmente)
  - Esperado: Sem erros de sintaxe
  - Resultado: ✅ / ❌

- [ ] **Revisar especificações em `specs/spec.md`**
  - Validar campos, tipos, constraints
  - Validar relacionamentos e foreign keys
  - Resultado: ✅ / ❌

### Fase 2: Criação no Xano
- [ ] **Criar tabela no Xano**
  - Acessar: Xano Backend → Tables
  - Ação: Importar/criar tabela `subjects` usando `tables/subjects.xs`
  - Esperado: Tabela criada com todos os campos
  - Resultado: ✅ / ❌

- [ ] **Validar Foreign Key com `user/users`**
  - Procedimento:
    1. Confirmar que `user/users` existe no Xano
    2. Testar constraint: Tentar criar subject com `user_id` inválido
    3. Esperado: Erro de constraint (fk_constraint_violation)
  - Resultado: ✅ / ❌

### Fase 3: Performance e Robustez
- [ ] **Criar índice em `user_id`**
  - Tipo: Index (não UNIQUE)
  - Propósito: Otimizar queries filtradas por user (SELECT * FROM subjects WHERE user_id = ?)
  - Verificação: Confirmar índice criado no Xano
  - Resultado: ✅ / ❌

- [ ] **Testar Cascade Delete**
  - Procedimento:
    1. Criar subject com user_id = X
    2. Deletar user com id = X
    3. Esperado: subject também é deletado
  - Resultado: ✅ / ❌

### Fase 4: Testes Funcionais
- [ ] **Teste 1: INSERT válido**
  ```sql
  INSERT INTO subjects (name, teacher, hours, user_id)
  VALUES ('Matemática', 'Prof. João', 60, 1);
  ```
  - Esperado: Sucesso, id auto-incrementado
  - Resultado: ✅ / ❌

- [ ] **Teste 2: Validar UNIQUE em `name`**
  ```sql
  INSERT INTO subjects (name, teacher, hours, user_id)
  VALUES ('Matemática', 'Prof. Maria', 45, 1);
  ```
  - Esperado: ERRO (duplicate name)
  - Resultado: ✅ / ❌

- [ ] **Teste 3: NOT NULL em campos obrigatórios**
  ```sql
  INSERT INTO subjects (name, teacher, hours, user_id)
  VALUES ('Física', NULL, 50, 1);
  ```
  - Esperado: ERRO (NULL em teacher)
  - Resultado: ✅ / ❌

- [ ] **Teste 4: Foreign Key em `user_id`**
  ```sql
  INSERT INTO subjects (name, teacher, hours, user_id)
  VALUES ('Química', 'Prof. Ana', 40, 999);
  ```
  - Esperado: ERRO (user_id 999 não existe)
  - Resultado: ✅ / ❌

### Fase 5: Documentação
- [ ] **Atualizar README ou wiki** (se aplicável)
  - Adicionar seção sobre tabela `subjects`
  - Listar campos, relacionamentos, exemplos de uso

- [ ] **Commitar no Git**
  ```bash
  git add openspec/changes/add-subjects-table/
  git add tables/subjects.xs
  git commit -m "feat: adiciona tabela 'subjects' com XanoScript"
  ```
  - Resultado: ✅ / ❌

---

## Notas

- **Dependência**: Tabela `user/users` deve existir no Xano antes de criar `subjects`
- **Rollback**: Se algo falhar, deletar tabela `subjects` no Xano e revisar `spec.md`
- **Contato**: Em caso de dúvidas, revisar `proposal.md` e `specs/spec.md`

---

## Timeline Estimada

| Fase | Tempo | Owner |
|------|-------|-------|
| Fase 1 | 5 min | Dev |
| Fase 2 | 10 min | Dev/DevOps |
| Fase 3 | 10 min | Dev |
| Fase 4 | 15 min | QA/Dev |
| Fase 5 | 5 min | Dev |
| **Total** | **~45 min** | |
