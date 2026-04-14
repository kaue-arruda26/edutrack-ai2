# Teste Rápido: Verificação de Estrutura

Execute este script no Xano para validar rapidamente que a tabela foi criada corretamente.

## ✅ Checklist Rápido

```sql
-- 1. Tabela existe?
SELECT TABLE_NAME FROM information_schema.TABLES 
WHERE TABLE_SCHEMA = 'seu_database' AND TABLE_NAME = 'subjects';

-- 2. Campos corretos?
DESCRIBE subjects;
-- Esperado: id, name, teacher, hours, user_id com tipos corretos

-- 3. Foreign Key configurada?
SELECT CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'subjects' AND COLUMN_NAME = 'user_id';
-- Esperado: FK apontando para user/users.id

-- 4. Índices criados?
SHOW INDEX FROM subjects;
-- Esperado: idx_subjects_user_id, idx_subjects_name

-- 5. Constraints validadas?
SHOW CREATE TABLE subjects;
-- Esperado: UNIQUE(name), FK com CASCADE, NOT NULL em campos obrigatórios
```

## 📋 Resultado Esperado

Se todos os SELECTs acima retornarem dados confirmatórios:
- ✅ Tabela criada com sucesso
- ✅ Campos têm tipos corretos
- ✅ Foreign Key configurada com CASCADE
- ✅ Índices criados para performance
- ✅ Constraints aplicadas

## 🔧 Próximo Passo

Se tudo passar, execute `tests-xano.sql` completo para os 6 testes funcionais.
