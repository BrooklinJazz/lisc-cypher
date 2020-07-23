defmodule LiscCypherWeb.PageController do
  use LiscCypherWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
