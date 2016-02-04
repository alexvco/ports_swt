require "rails_helper"

feature "User Manages StackWordTrees" do

  scenario "Views Existing Trees" do
    tree1.update_column(:name, "Tree1")
    tree2.update_column(:name, "Tree2")

    visit_tree_page

    expect(page).to have_content("Tree1")
    expect(page).to have_content("Tree2")
    expect(current_path).to eq(stack_word_trees_path)
  end

  scenario "Creating a new trees from the home page" do
    visit root_path

    expect(page).to_not have_content("Here Is Your Awesome Stacked Word Tree!")
    expect(page).to_not have_content("ire")

    attach_file "Data file", data_file
    click_on "Find My Stacked Word Tree"

    expect(page).to have_content("Your stack tree is called #{StackWordTree.first.name}, take good care of it!")
    expect(page).to have_content("ire")
    expect(page).to have_content("tritones")
    expect(page).to have_content("traditionless")
    expect(current_path).to eq(stack_word_tree_path(StackWordTree.first))
  end

  scenario "Views Details Of a Tree" do
    tree1.update_column(:name, "Tree1")
    visit_tree_page

    click_on "View Tree Details"
    expect(page).to have_content("Your stack tree is called #{StackWordTree.first.name}, take good care of it!")
  end

  scenario "Removing a tree" do
    create_tree
    visit_tree_page

    click_on "Remove Tree"

    expect(page).to have_content("Stack word tree was successfully removed.")
  end

  def data_file
    @data_file ||= File.join(Rails.root, 'spec', 'support', 'sample_word_traditionless.dat')
  end

  def create_tree
    tree1
  end

  def tree1
    @tree1 ||= create(:stack_word_tree)
  end

  def tree2
    @tree2 ||= create(:stack_word_tree)
  end

  def visit_tree_page
    visit root_path
    click_on "Trees"
  end
end

