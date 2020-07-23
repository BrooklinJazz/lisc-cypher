defmodule LiscCypherWeb.NoteControllerTest do
  use LiscCypherWeb.ConnCase

  alias LiscCypher.Cypher

  @create_attrs %{body: "some body", title: "some title"}
  @update_attrs %{body: "some updated body", title: "some updated title"}
  @invalid_attrs %{body: nil, title: nil}

  def fixture(:note) do
    {:ok, note} = Cypher.create_note(@create_attrs)
    note
  end

  describe "index" do
    test "lists all note", %{conn: conn} do
      conn = get(conn, Routes.note_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Note"
    end
  end

  describe "new note" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.note_path(conn, :new))
      assert html_response(conn, 200) =~ "New Note"
    end
  end

  describe "create note" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.note_path(conn, :create), note: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.note_path(conn, :show, id)

      conn = get(conn, Routes.note_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Note"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.note_path(conn, :create), note: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Note"
    end
  end

  describe "edit note" do
    setup [:create_note]

    test "renders form for editing chosen note", %{conn: conn, note: note} do
      conn = get(conn, Routes.note_path(conn, :edit, note))
      assert html_response(conn, 200) =~ "Edit Note"
    end
  end

  describe "update note" do
    setup [:create_note]

    test "redirects when data is valid", %{conn: conn, note: note} do
      conn = put(conn, Routes.note_path(conn, :update, note), note: @update_attrs)
      assert redirected_to(conn) == Routes.note_path(conn, :show, note)

      conn = get(conn, Routes.note_path(conn, :show, note))
      assert html_response(conn, 200) =~ "some updated body"
    end

    test "renders errors when data is invalid", %{conn: conn, note: note} do
      conn = put(conn, Routes.note_path(conn, :update, note), note: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Note"
    end
  end

  describe "delete note" do
    setup [:create_note]

    test "deletes chosen note", %{conn: conn, note: note} do
      conn = delete(conn, Routes.note_path(conn, :delete, note))
      assert redirected_to(conn) == Routes.note_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.note_path(conn, :show, note))
      end
    end
  end

  defp create_note(_) do
    note = fixture(:note)
    %{note: note}
  end
end
