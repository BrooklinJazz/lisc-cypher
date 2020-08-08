defmodule LiscCypher.Translations.Note do
  use Ecto.Schema
  import Ecto.Changeset

  schema "notes" do
    field :body, :string
    field :title, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end
