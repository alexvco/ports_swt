require "rails_helper"

feature "User Manages StackWordTrees" do

  scenario "User Views Existing Trees" do
    tree1.update_column(:name, "Tree1")
    tree2.update_column(:name, "Tree2")
    visit root_path
    click_on "Trees"

    expect(page).to have_content("Tree1")
    expect(page).to have_content("Tree2")
    expect(current_path).to eq(stack_word_trees_path)
  end

  def tree1
      @tree1 ||= create(:stack_word_tree)
  end

  def tree2
      @tree2 ||= create(:stack_word_tree)
  end
end

