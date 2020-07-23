defmodule LiscCypher.Repo.Migrations.CreateNote do
  use Ecto.Migration

  def change do
    create table(:note) do
      add :title, :string
      add :body, :string

      timestamps()
    end

  end
end
