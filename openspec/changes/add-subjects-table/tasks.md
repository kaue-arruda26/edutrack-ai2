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
  - **Arquivo auxiliar**: [VERIFICACAO-RAPIDA.md](VERIFICACAO-RAPIDA.md) para validação rápida
  - Resultado: ✅ / ❌

- [ ] **Validar Foreign Key com `user/users`**
  - Procedimento:
    1. Confirmar que `user/users` existe no Xano
    2. Testar constraint: Tentar criar subject com `user_id` inválido
    3. Esperado: Erro de constraint (fk_constraint_violation)
  - **Arquivo auxiliar**: Execute SQL em [tests-xano.sql](tests-xano.sql#L81-L89)
  - Resultado: ✅ / ❌

### Fase 3: Performance e Robustez
- [ ] **Criar índice em `user_id`**
  - Tipo: Index (não UNIQUE)
  - Propósito: Otimizar queries filtradas por user (SELECT * FROM subjects WHERE user_id = ?)
  - Verificação: Confirmar índice criado no Xano
  - **Arquivo auxiliar**: [VERIFICACAO-RAPIDA.md](VERIFICACAO-RAPIDA.md) valida índices
  - Resultado: ✅ / ❌

- [ ] **Testar Cascade Delete**
  - Procedimento:
    1. Criar subject com user_id = X
    2. Deletar user com id = X
    3. Esperado: subject também é deletado
  - **Arquivo auxiliar**: [tests-xano.sql](tests-xano.sql#L113-L127) - TESTE 5
  - Resultado: ✅ / ❌

### Fase 4: Testes Funcionais

**Arquivo com todos os testes**: [tests-xano.sql](tests-xano.sql)

- [ ] **Teste 1: INSERT válido** ([tests-xano.sql#L44-L48](tests-xano.sql#L44-L48))
  ```sql
  INSERT INTO subjects (name, teacher, hours, user_id)
  VALUES ('Matemática', 'Prof. João Silva', 60, 1);
  ```
  - Esperado: Sucesso, id auto-incrementado
  - Resultado: ✅ / ❌

- [ ] **Teste 2: Validar UNIQUE em `name`** ([tests-xano.sql#L54-L58](tests-xano.sql#L54-L58))
  ```sql
  INSERT INTO subjects (name, teacher, hours, user_id)
  VALUES ('Matemática', 'Prof. Maria Santos', 45, 1);
  ```
  - Esperado: ERRO 1062 (duplicate entry)
  - Resultado: ✅ / ❌

- [ ] **Teste 3: NOT NULL em campos obrigatórios** ([tests-xano.sql#L65-L69](tests-xano.sql#L65-L69))
  ```sql
  INSERT INTO subjects (name, teacher, hours, user_id)
  VALUES ('Física', NULL, 50, 1);
  ```
  - Esperado: ERRO 1048 (cannot be null)
  - Resultado: ✅ / ❌

- [ ] **Teste 4: Foreign Key em `user_id`** ([tests-xano.sql#L76-L80](tests-xano.sql#L76-L80))
  ```sql
  INSERT INTO subjects (name, teacher, hours, user_id)
  VALUES ('Química', 'Prof. Ana Costa', 40, 999);
  ```
  - Esperado: ERRO 1452  e Versionamento

- [ ] **Git commit dos arquivos auxiliares** (já feito na Fase 1)
  ```bash
  git add -A openspec/changes/add-subjects-table/ tables/subjects.xs
  git commit -m "feat: adiciona tabela 'subjects' com OpenSpec e testes"
  ```
  - Commit: `671cf2b` ✅

- [ ] **Git commit com documentação de testes** (próximo)
  ```bash
  git add openspec/changes/add-subjects-table/tests-xano.sql
  git add openspec/changes/add-subjects-table/VERIFICACAO-RAPIDA.md
  git commit -m "docs: adiciona scripts de validação e testes para tabela 'subjects'"
  ```
  - Resultado: ✅ / ❌

- [ ] **Marcar change como concluída** (após todos os testes passarem)
  - [ ] Todos os testes da Fase 4 passaram
  - [ ] FK funcionando com cascade
  - [ ] Índices criados e validadosesultado: ✅ / ❌

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
