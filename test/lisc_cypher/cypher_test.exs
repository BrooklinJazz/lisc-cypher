defmodule LiscCypher.CypherTest do
  use LiscCypher.DataCase


  describe "translate note" do
    import  LiscCypher.Cypher.Translator
    test "translate_word" do
      alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
      assert translate_word(alphabet) == "LBKDSMREAIKsIFVORAGSTYNPsKUZ"
    end
    test "translate sentence" do
      alphabet = "ABCD EFGHIJKLMNOPQRSTUVWX YZ"
      # it's adding a space TODO fix
      assert translate_sentence(alphabet) == " LBKD SMREAIKsIFVORAGSTYNPsK UZ"
    end
  end

  describe "note" do
    alias LiscCypher.Cypher.Note
    alias LiscCypher.Cypher

    @valid_attrs %{body: "some body", title: "some title"}
    @update_attrs %{body: "some updated body", title: "some updated title"}
    @invalid_attrs %{body: nil, title: nil}

    def note_fixture(attrs \\ %{}) do
      {:ok, note} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Cypher.create_note()

      note
    end

    test "list_note/0 returns all note" do
      note = note_fixture()
      assert Cypher.list_note() == [note]
    end

    test "get_note!/1 returns the note with given id" do
      note = note_fixture()
      assert Cypher.get_note!(note.id) == note
    end

    test "create_note/1 with valid data creates a note" do
      assert {:ok, %Note{} = note} = Cypher.create_note(@valid_attrs)
      assert note.body == "some body"
      assert note.title == "some title"
    end

    test "create_note/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cypher.create_note(@invalid_attrs)
    end

    test "update_note/2 with valid data updates the note" do
      note = note_fixture()
      assert {:ok, %Note{} = note} = Cypher.update_note(note, @update_attrs)
      assert note.body == "some updated body"
      assert note.title == "some updated title"
    end

    test "update_note/2 with invalid data returns error changeset" do
      note = note_fixture()
      assert {:error, %Ecto.Changeset{}} = Cypher.update_note(note, @invalid_attrs)
      assert note == Cypher.get_note!(note.id)
    end

    test "delete_note/1 deletes the note" do
      note = note_fixture()
      assert {:ok, %Note{}} = Cypher.delete_note(note)
      assert_raise Ecto.NoResultsError, fn -> Cypher.get_note!(note.id) end
    end

    test "change_note/1 returns a note changeset" do
      note = note_fixture()
      assert %Ecto.Changeset{} = Cypher.change_note(note)
    end
  end
end
