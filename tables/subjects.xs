/**
 * XanoScript Table Definition: subjects
 * 
 * Tabela para armazenar disciplinas/matérias do EduTrack AI
 * Inclui: nome, professor, carga horária, vínculo com usuário
 * 
 * @version 1.0
 * @created 2026-04-14
 */

create_table(
  table_name: "subjects",
  columns: [
    {
      name: "id",
      type: "int",
      primary_key: true,
      auto_increment: true
    },
    {
      name: "name",
      type: "text",
      nullable: false,
      unique: true
    },
    {
      name: "teacher",
      type: "text",
      nullable: false
    },
    {
      name: "hours",
      type: "int",
      nullable: false
    },
    {
      name: "user_id",
      type: "int",
      nullable: false,
      foreign_key: {
        table: "user/users",
        column: "id",
        on_delete: "cascade",
        on_update: "cascade"
      }
    }
  ],
  indexes: [
    {
      name: "idx_subjects_user_id",
      columns: ["user_id"],
      unique: false
    },
    {
      name: "idx_subjects_name",
      columns: ["name"],
      unique: true
    }
  ]
);

/**
 * Índices criados:
 * - idx_subjects_user_id: Para queries filtradas por user_id
 * - idx_subjects_name: Garante unicidade de nomes
 * 
 * Foreign Key Constraint:
 * - subjects.user_id → user/users.id (CASCADE ON DELETE/UPDATE)
 */
