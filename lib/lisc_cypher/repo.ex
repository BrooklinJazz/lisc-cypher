defmodule LiscCypher.Repo do
  use Ecto.Repo,
    otp_app: :lisc_cypher,
    adapter: Ecto.Adapters.Postgres
end
