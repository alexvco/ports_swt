require 'rails_helper'

describe StackWordTree, type: :model do

  it { should serialize(:result) }

  context "default" do
    it "has a default random name" do
      allow(Faker::App).to receive(:name).and_return("RandomName")
      tree = StackWordTree.create!

      expect(tree.name).to eq("RandomName Tree")
      expect(Faker::App).to have_received(:name)
    end
  end
end
