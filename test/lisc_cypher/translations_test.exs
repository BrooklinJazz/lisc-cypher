defmodule LiscCypher.TranslationsTest do
  use LiscCypher.DataCase

  alias LiscCypher.Translations

  describe "notes" do
    alias LiscCypher.Translations.Note

    @valid_attrs %{body: "some body", title: "some title"}
    @update_attrs %{body: "some updated body", title: "some updated title"}
    @invalid_attrs %{body: nil, title: nil}

    def note_fixture(attrs \\ %{}) do
      {:ok, note} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Translations.create_note()

      note
    end

    test "list_notes/0 returns all notes" do
      note = note_fixture()
      assert Translations.list_notes() == [note]
    end

    test "get_note!/1 returns the note with given id" do
      note = note_fixture()
      assert Translations.get_note!(note.id) == note
    end

    test "create_note/1 with valid data creates a note" do
      assert {:ok, %Note{} = note} = Translations.create_note(@valid_attrs)
      assert note.body == "some body"
      assert note.title == "some title"
    end

    test "create_note/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Translations.create_note(@invalid_attrs)
    end

    test "update_note/2 with valid data updates the note" do
      note = note_fixture()
      assert {:ok, %Note{} = note} = Translations.update_note(note, @update_attrs)
      assert note.body == "some updated body"
      assert note.title == "some updated title"
    end

    test "update_note/2 with invalid data returns error changeset" do
      note = note_fixture()
      assert {:error, %Ecto.Changeset{}} = Translations.update_note(note, @invalid_attrs)
      assert note == Translations.get_note!(note.id)
    end

    test "delete_note/1 deletes the note" do
      note = note_fixture()
      assert {:ok, %Note{}} = Translations.delete_note(note)
      assert_raise Ecto.NoResultsError, fn -> Translations.get_note!(note.id) end
    end

    test "change_note/1 returns a note changeset" do
      note = note_fixture()
      assert %Ecto.Changeset{} = Translations.change_note(note)
    end
  end
end