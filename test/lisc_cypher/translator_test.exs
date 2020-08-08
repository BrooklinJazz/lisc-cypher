defmodule LiscCypher.TranslatorTest do
  use LiscCypher.DataCase
  import LiscCypher.Cypher.Translator

  describe "Translator" do
    # test "translate alphabet" do
    #   alphabet = "abcdefghijklmnopqrstuvwxyz"
    #   assert translate_sentence(alphabet) == "LBKDSMREAIKsIFVORAGSTYNPsKUZ"
    # end

    test "translate grouping" do
      alphabet = "example"
      assert translate_sentence(alphabet) == "PARFRIS"
    end
  end
end
