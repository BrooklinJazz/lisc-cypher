defmodule LiscCypher.Repo.Migrations.CreateLanguages do
  use Ecto.Migration

  def change do
    create table(:languages) do
      add :title, :string
      add :description, :text
      add :word_map, :map
      add :char_map, :map
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:languages, [:user_id])
  end
end
