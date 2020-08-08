defmodule LiscCypher.Translations.Language do
  use Ecto.Schema
  import Ecto.Changeset

  schema "languages" do
    field :char_map, :map
    field :description, :string
    field :title, :string
    field :word_map, :map
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(language, attrs) do
    language
    |> cast(attrs, [:title, :description, :word_map, :char_map])
    |> validate_required([:title, :description, :word_map, :char_map])
  end
end
