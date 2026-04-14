# Especificação Técnica: Tabela 'subjects'

## Schema Definition

### Campos

```
subjects
├── id (INT, PRIMARY KEY, AUTO_INCREMENT)
├── name (VARCHAR/TEXT, NOT NULL, UNIQUE)
├── teacher (VARCHAR/TEXT, NOT NULL)
├── hours (INT, NOT NULL)
├── user_id (INT, NOT NULL, FOREIGN KEY → user/users.id)
└── Constraints: PRIMARY KEY (id), UNIQUE (name), FOREIGN KEY (user_id)
```

### Detalhes dos Campos

#### 1. `id` (INT)
- **Tipo**: INTEGER
- **Constraints**: PRIMARY KEY, AUTO_INCREMENT
- **Descrição**: Identificador único de cada disciplina
- **Default**: Auto-incrementado pelo banco

#### 2. `name` (TEXT/VARCHAR)
- **Tipo**: TEXT ou VARCHAR(255)
- **Constraints**: NOT NULL, UNIQUE
- **Descrição**: Nome da disciplina (ex: "Matemática", "Física")
- **Validação**: Não pode ser vazio ou duplicado

#### 3. `teacher` (TEXT/VARCHAR)
- **Tipo**: TEXT ou VARCHAR(255)
- **Constraints**: NOT NULL
- **Descrição**: Nome do professor responsável pela disciplina
- **Validação**: Não pode ser vazio

#### 4. `hours` (INT)
- **Tipo**: INTEGER
- **Constraints**: NOT NULL
- **Descrição**: Carga horária total da disciplina
- **Validação**: Deve ser maior que 0 (validação em aplicação)

#### 5. `user_id` (INT)
- **Tipo**: INTEGER
- **Constraints**: NOT NULL, FOREIGN KEY
- **Referência**: `user/users.id`
- **Ação em Deleção (ON DELETE)**: CASCADE
- **Ação em Atualização (ON UPDATE)**: CASCADE
- **Descrição**: Vínculo com o usuário proprietário da disciplina
- **Validação**: Deve existir em `user/users.id`

### Índices

| Índice | Campos | Tipo | Propósito |
|--------|--------|------|-----------|
| PRIMARY | `id` | PRIMARY KEY | Identificação única |
| UNIQUE | `name` | UNIQUE | Evitar duplicação de nomes |
| FK | `user_id` | FOREIGN KEY | Performance em queries por usuário |

### Relacionamentos

```
subjects.user_id ──> user/users.id
  (N:1)
```

Um usuário pode ter múltiplas disciplinas.
Uma disciplina pertence a exatamente um usuário.

## Implementação

Arquivo: `tables/subjects.xs`

## Validações de Aplicação

1. **Unicidade de nome**: Validar no frontend/backend antes de INSERT
2. **Existência de user_id**: Verificar que user exists em `user/users`
3. **Horas positivas**: `hours > 0`
4. **Campos obrigatórios**: Todos os campos (exceto `id`) devem ser preenchidos

## Considerações Futuras

- Adicionar `created_at` (DATETIME DEFAULT CURRENT_TIMESTAMP) para auditoria
- Adicionar `updated_at` (DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP)
- Adicionar `description` (TEXT, NULLABLE) para descrição da disciplina
- Adicionar `status` (ENUM ou INT) para ativar/desativar disciplinas sem deletar
