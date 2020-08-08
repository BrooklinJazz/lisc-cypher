defmodule LiscCypherWeb.NoteController do
  use LiscCypherWeb, :controller

  alias LiscCypher.Translations
  alias LiscCypher.Translations.Note

  def index(conn, _params) do
    notes = Translations.list_notes()
    render(conn, "index.html", notes: notes)
  end

  def new(conn, _params) do
    changeset = Translations.change_note(%Note{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"note" => note_params}) do
    case Translations.create_note(note_params) do
      {:ok, note} ->
        conn
        |> put_flash(:info, "Note created successfully.")
        |> redirect(to: Routes.note_path(conn, :show, note))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    note = Translations.get_note!(id)
    render(conn, "show.html", note: note)
  end

  def edit(conn, %{"id" => id}) do
    note = Translations.get_note!(id)
    changeset = Translations.change_note(note)
    render(conn, "edit.html", note: note, changeset: changeset)
  end

  def update(conn, %{"id" => id, "note" => note_params}) do
    note = Translations.get_note!(id)

    case Translations.update_note(note, note_params) do
      {:ok, note} ->
        conn
        |> put_flash(:info, "Note updated successfully.")
        |> redirect(to: Routes.note_path(conn, :show, note))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", note: note, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    note = Translations.get_note!(id)
    {:ok, _note} = Translations.delete_note(note)

    conn
    |> put_flash(:info, "Note deleted successfully.")
    |> redirect(to: Routes.note_path(conn, :index))
  end
end
