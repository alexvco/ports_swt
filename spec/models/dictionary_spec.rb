require "rails_helper"

describe Dictionary, type: :model do
  context "#find_longest_word_stacked_tree" do
    it "finds the correct word trees" do
      dictionary1 = Dictionary.new(data_file1)
      dictionary2 = Dictionary.new(data_file2)

      expect(dictionary1.find_longest_word_stacked_tree).to eq(["ire", "rite", "trite", "titres", "tinters", "tritones", "stationer", "iterations", "orientalist", "orientalists", "traditionless"])

      expect(dictionary2.find_longest_word_stacked_tree).to eq(["ton", "snot", "notes", "lentos", "tolanes", "elations", "tensional", "lineations", "nationalise", "nationalizes", "nationalizers", "renationalizes", "generalizations"])
    end
  end

  def data_file1
    @data_file1 ||= File.join(Rails.root, 'spec', 'support', 'sample_word_traditionless.dat')
  end

  def data_file2
    @data_file2 ||= File.join(Rails.root, 'spec', 'support', 'sample_word_generalizations.dat')
  end
end