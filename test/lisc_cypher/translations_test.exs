defmodule LiscCypher.TranslationsTest do
  use LiscCypher.DataCase

  alias LiscCypher.Translations
  import LiscCypher.AccountsFixtures

  describe "notes" do
    alias LiscCypher.Translations.Note

    @valid_attrs %{body: "some body", title: "some title"}
    @update_attrs %{body: "some updated body", title: "some updated title"}
    @invalid_attrs %{body: nil, title: nil}
    @no_user_attrs %{body: "some body", title: "some title", user_id: nil}

    setup do
      user = user_fixture()
      note = note_fixture(%{user_id: user.id})
      valid_attrs = %{body: "some body", title: "some title"}
      update_attrs = %{body: "some updated body", title: "some updated title"}
      %{user: user, note: note, valid_attrs: valid_attrs, update_attrs: update_attrs}
    end

    def note_fixture(attrs \\ %{}) do
      {:ok, note} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Translations.create_note()

      note
    end

    test "list_notes/1 _ no user or invalid id _ returns no notes" do
      assert Translations.list_notes(0) == []
    end

    test "list_notes/1 _ with user _ returns user notes", %{note: note, user: user} do
      assert Translations.list_notes(user.id) == [note]
    end

    test "get_note!/1 returns the note with given id", %{note: note} do
      assert Translations.get_note!(note.id) == note
    end

    test "create_note/1 with valid data creates a note" do
      %{id: id} = _user = user_fixture()
      note = note_fixture(%{user_id: id})
      assert note.body == "some body"
      assert note.title == "some title"
      assert note.user_id == id
    end

    test "create_note/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Translations.create_note(@invalid_attrs)
    end

    test "create_note/1 with invalid date _  no user" do
      assert {:error, %Ecto.Changeset{}} = Translations.create_note(@no_user_attrs)
    end

    test "update_note/2 with valid data updates the note", %{update_attrs: update_attrs, note: note} do
      assert {:ok, %Note{} = note} = Translations.update_note(note, update_attrs)
      assert note.body == "some updated body"
      assert note.title == "some updated title"
    end

    test "update_note/2 with invalid data returns error changeset", %{note: note} do
      assert {:error, %Ecto.Changeset{}} = Translations.update_note(note, @invalid_attrs)
      assert note == Translations.get_note!(note.id)
    end

    test "delete_note/1 deletes the note", %{note: note} do
      assert {:ok, %Note{}} = Translations.delete_note(note)
      assert_raise Ecto.NoResultsError, fn -> Translations.get_note!(note.id) end
    end

    test "change_note/1 returns a note changeset", %{note: note} do
      assert %Ecto.Changeset{} = Translations.change_note(note)
    end
  end

  describe "languages" do
    alias LiscCypher.Translations.Language
    @valid_attrs %{char_map: %{"A" => "B"}, description: "some description", title: "some title", word_map: %{"WORD" => "DROW"}}
    @update_attrs %{char_map: %{"U" => "P"}, description: "some updated description", title: "some updated title", word_map: %{"UPDATE" => "UPDATED"}}
    @invalid_attrs %{char_map: nil, description: nil, title: nil, word_map: nil}

    def language_fixture(attrs \\ %{}) do
      {:ok, language} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Translations.create_language()

      language
    end

    test "list_languages/0 returns all languages" do
      language = language_fixture()
      assert Translations.list_languages() == [language]
    end

    test "get_language!/1 returns the language with given id" do
      language = language_fixture()
      assert Translations.get_language!(language.id) == language
    end

    test "create_language/1 with valid data creates a language" do
      assert {:ok, %Language{} = language} = Translations.create_language(@valid_attrs)
      assert language.char_map == %{"A" => "B"}
      assert language.description == "some description"
      assert language.title == "some title"
      assert language.word_map == %{"WORD" => "DROW"}
    end

    test "create_language/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Translations.create_language(@invalid_attrs)
    end

    test "update_language/2 with valid data updates the language" do
      language = language_fixture()
      assert {:ok, %Language{} = language} = Translations.update_language(language, @update_attrs)
      assert language.char_map == %{"U" => "P"}
      assert language.description == "some updated description"
      assert language.title == "some updated title"
      assert language.word_map == %{"UPDATE" => "UPDATED"}
    end

    test "update_language/2 with invalid data returns error changeset" do
      language = language_fixture()
      assert {:error, %Ecto.Changeset{}} = Translations.update_language(language, @invalid_attrs)
      assert language == Translations.get_language!(language.id)
    end

    test "delete_language/1 deletes the language" do
      language = language_fixture()
      assert {:ok, %Language{}} = Translations.delete_language(language)
      assert_raise Ecto.NoResultsError, fn -> Translations.get_language!(language.id) end
    end

    test "change_language/1 returns a language changeset" do
      language = language_fixture()
      assert %Ecto.Changeset{} = Translations.change_language(language)
    end
  end
end
