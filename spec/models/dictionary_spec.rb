require "rails_helper"

describe Dictionary, type: :model do

  # context "#initialize" do
  #   it "has a data_file" do
  #     data_file = double("data_file")
  #     dictionary = Dictionary.new(data_file)
  #
  #     expect(dictionary.data_file).to eq(data_file)
  #   end
  # end

  context "#find_word_trees" do
    it "finds the correct word trees" do
      dictionary1 = Dictionary.new(data_file1)
      # dictionary2 = Dictionary.new(data_file2)

      expect(dictionary1.find_possible_stacks).to eq(["ire", "rite", "trite", "titres", "tinters", "tritones", "stationer", "iterations", "orientalist", "orientalists", "traditionless"])

      # expect(dictionary2.find_word_trees).to eq([["ton", "snot", "notes", "lentos", "tolanes", "elations", "tensional", "lineations", "nationalise", "nationalizes", "nationalizers", "renationalizes", "generalizations"]])
    end
  end


  def data_file1
    @data_file1 ||= File.join(Rails.root, 'spec', 'support', 'sample_word_list1.dat')
  end

  def data_file2
    @data_file2 ||= File.join(Rails.root, 'spec', 'support', 'wordlist_generalizations.dat')
  end

  def data_file3
    @data_file3 ||= File.join(Rails.root, 'spec', 'support', 'sample_word_list_multiple_trees.dat')
  end

end