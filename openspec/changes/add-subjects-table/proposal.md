# Proposal: Adicionar Tabela 'subjects'

## Objetivo
Definir o esquema da tabela `subjects` para armazenar disciplinas/matérias dentro do EduTrack AI.

## Contexto
O sistema educacional precisa gerenciar disciplinas/matérias com informações sobre:
- Nome da disciplina
- Professor responsável
- Horas/carga horária
- Vínculo com usuário (owner)

## Especificação
Criar tabela `subjects` no banco de dados Xano com os seguintes campos:

| Campo | Tipo | Descrição |
|-------|------|-----------|
| `id` | INT (auto increment) | Identificador único, primary key |
| `name` | TEXT | Nome da disciplina (único) |
| `teacher` | TEXT | Nome do professor responsável |
| `hours` | INT | Carga horária total |
| `user_id` | INT (FK) | Foreign key para tabela `user/users` do Xano |

## Foreign Key
- Campo: `user_id`
- Tabela referenciada: `user/users` (tabela de autenticação do Xano)
- Ação em deleção: Cascata (deletar subjects quando user é deletado)

## Escalopo
- ✅ Definição de schema em XanoScript
- ✅ Validações e constraints
- ❌ Inicialização de dados (fora do escopo)
- ❌ Endpoints API (fora do escopo)

## Decisões
1. Campo `name` é **UNIQUE** — não há duas disciplinas COM o mesmo nome por usuário
2. Timestamps (`created_at`, `updated_at`) não inclusos — podem ser adicionados futuramente
3. Todos os campos (exceto `id`) são obrigatórios (NOT NULL)

## Próximos Passos
1. Revisar e aprovar especificação técnica em `specs/spec.md`
2. Implementar arquivo XanoScript em `tables/subjects.xs`
3. Executar tasks em `tasks.md` para criar tabela no Xano
