defmodule LiscCypher.Cypher.Translator do

  def translate_sentence(sentence) do
    sentence
    |> String.upcase
    |> String.split(" ")
    |> List.foldl("", fn x, acc -> acc <> " " <> translate_word(x) end)
  end
P
  def translate_word(word) do
    word
    |> String.split("", trim: true)
    |> List.foldl("", fn char, acc -> acc <> translate_char(char) end)
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
