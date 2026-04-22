/**
 * Script de Testes: Tabela 'subjects'
 * 
 * Execute estes comandos no Xano para validar a criação da tabela.
 * Cada seção testa um aspecto diferente do schema.
 * 
 * @author EduTrack AI
 * @date 2026-04-14
 */

-- =============================================================================
-- FASE 2: CRIAÇÃO E VALIDAÇÃO DA TABELA
-- =============================================================================

-- Verificar se a tabela foi criada
SELECT * FROM information_schema.tables 
WHERE table_schema = DATABASE() AND table_name = 'subjects';

-- Listar estrutura da tabela
DESCRIBE subjects;

-- Verificar constraints e foreign keys
SELECT * FROM information_schema.key_column_usage 
WHERE table_name = 'subjects' AND table_schema = DATABASE();

-- =============================================================================
-- FASE 3: VALIDAÇÃO DE ÍNDICES
-- =============================================================================

-- Listar todos os índices da tabela
SHOW INDEX FROM subjects;

-- Verificar índice em user_id
SELECT * FROM information_schema.statistics 
WHERE table_name = 'subjects' 
AND index_name IN ('idx_subjects_user_id', 'idx_subjects_name');

-- =============================================================================
-- FASE 4: TESTES FUNCIONAIS
-- =============================================================================

-- TESTE 1: INSERT válido
-- Esperado: Sucesso, id auto-incrementado
INSERT INTO subjects (name, teacher, hours, user_id)
VALUES ('Matemática', 'Prof. João Silva', 60, 1);

-- Verificar inserção
SELECT * FROM subjects WHERE name = 'Matemática';

---

-- TESTE 2: Validar UNIQUE em 'name'
-- Esperado: ERRO (duplicate entry)
-- Descomente a linha abaixo para testar:
-- INSERT INTO subjects (name, teacher, hours, user_id)
-- VALUES ('Matemática', 'Prof. Maria Santos', 45, 1);
-- Resultado esperado: Error 1062 - Duplicate entry 'Matemática' for key 'name'

---

-- TESTE 3: Validar NOT NULL em campos obrigatórios
-- Esperado: ERRO (teacher pode não ser null)
-- Descomente para testar:
-- INSERT INTO subjects (name, teacher, hours, user_id)
-- VALUES ('Física', NULL, 50, 1);
-- Resultado esperado: Error 1048 - Column 'teacher' cannot be null

---

-- TESTE 4: Validar Foreign Key em 'user_id'
-- Esperado: ERRO (user_id 999 não existe)
-- Descomente para testar:
-- INSERT INTO subjects (name, teacher, hours, user_id)
-- VALUES ('Química', 'Prof. Ana Costa', 40, 999);
-- Resultado esperado: Error 1452 - Cannot add or update a child row: a foreign key constraint fails

---

-- TESTE 5: Validar Cascade Delete
-- Procedimento:
-- 1. Criar subject com user_id = X
INSERT INTO subjects (name, teacher, hours, user_id)
VALUES ('Biologia', 'Prof. Carlos Mendes', 55, 2);

-- 2. Verificar que foi criado
SELECT * FROM subjects WHERE user_id = 2;

-- 3. Deletar user com id = 2 (assumindo que user/users está acessível)
-- DELETE FROM `user/users` WHERE id = 2;

-- 4. Verificar que subject foi deletado automaticamente (cascade)
-- SELECT * FROM subjects WHERE user_id = 2;
-- Resultado esperado: 0 linhas (subject foi deletado)

---

-- TESTE 6: Query por user_id (validar índice de performance)
-- Esperado: Execução rápida com índice idx_subjects_user_id
SELECT * FROM subjects WHERE user_id = 1;

-- Análise de performance
EXPLAIN SELECT * FROM subjects WHERE user_id = 1;

-- =============================================================================
-- LIMPEZA (Opcional - descomente se quiser resetar)
-- =============================================================================

-- DELETE FROM subjects WHERE id > 0;
-- DROP TABLE subjects;

-- =============================================================================
-- FIM DO SCRIPT
-- =============================================================================
