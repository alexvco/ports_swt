require 'rails_helper'

describe StackWordTree, type: :model do

  it { should serialize(:result) }
  it { should validate_presence_of(:data_file) }

  context "default" do
    it "has a default random name" do
      allow(Faker::App).to receive(:name).and_return("RandomName")
      tree = StackWordTree.create!(data_file: data_file)

      expect(tree.name).to eq("RandomName Tree")
      expect(Faker::App).to have_received(:name)
    end
  end

  context "#find_longest_stack_tree" do
    context "when data_file does not exist" do
      it "raises an error" do
        tree           = StackWordTree.new
        tree.data_file = nil

        expect { tree.find_longest_stack_tree }.to raise_error(StackWordTree::NoDataFiledError, "No data file provided")
      end
    end

    context "when data_fiile exists" do
      before { stub_dictionary }

      it "finds the longest stack tree using Dictionary" do
        tree = create(:stack_word_tree, data_file: data_file)
        tree.find_longest_stack_tree

        expect(Dictionary).to have_received(:new).with(tree.data_file.file.file)
        expect(dictionary).to have_received(:find_longest_word_stacked_tree)
      end

      it "updates its result based on the Dictionnary result" do
        allow(dictionary).to receive(:find_longest_word_stacked_tree).and_return(["Some Result"])
        tree = create(:stack_word_tree)
        tree.find_longest_stack_tree
        tree.reload

        expect(tree.result).to eq(["Some Result"])
      end
    end
  end

  def stub_dictionary
    allow(Dictionary).to receive(:new).and_return(dictionary)
    allow(dictionary).to receive(:find_longest_word_stacked_tree).and_return([])
  end

  def dictionary
    @dictionary ||= spy("Dictionary")
  end

  def data_file
    @data_file ||= Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'no_tree_file.dat'))
  end
end
