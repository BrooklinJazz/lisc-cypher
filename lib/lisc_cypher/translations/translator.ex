defmodule LiscCypher.Cypher.Translator do
  def translate_sentence(sentence) do
    sentence
    |> String.upcase()
    |> split_words
    |> translate_word_list
    |> String.trim

  end

  def split_words(words) do
    words |> String.split(" ")
  end

  def translate_word_list(word_list) do
    word_list |>
    List.foldl("", fn x, acc -> acc <> " " <> translate_word(x) end)
  end

  def translate_word(word) do
    word
    |> String.replace("EXA", " EXA ")
    |> String.split(" ", trim: true)
    |> List.foldl("", fn chars, acc -> acc <> translate_char_groups(chars) end)
  end

  def translate_char_groups(char_group) do
    case char_group do
      "EXA" -> "PAR"
      _ -> String.split(char_group, "") |> translate_char_list
    end
  end

  def translate_char_list(char_list) do
    List.foldl(char_list, "", fn group, acc -> acc <> translate_char(group) end)
  end

  def translate_char(char) do
    case char do
      "A" -> "L"
      "C" -> "K"
      "E" -> "S"
      "F" -> "M"
      "G" -> "R"
      "H" -> "E"
      "I" -> "A"
      "J" -> "I"
      "K" -> "Ks"
      "L" -> "I"
      "M" -> "F"
      "N" -> "V"
      "P" -> "R"
      "Q" -> "A"
      "R" -> "G"
      "U" -> "Y"
      "V" -> "N"
      "W" -> "Ps"
      "X" -> "K"
      "Y" -> "U"
      _ -> char
    end
  end
end
