require "rails_helper"

feature "User Manages StackWordTrees" do

  scenario "User Views Existing Trees" do
    tree1.update_column(:name, "Tree1")
    tree2.update_column(:name, "Tree2")

    visit_tree_page

    expect(page).to have_content("Tree1")
    expect(page).to have_content("Tree2")
    expect(current_path).to eq(stack_word_trees_path)
  end

  scenario "Creating a new trees" do
    visit_tree_page
    click_on "New Stack word tree"

    attach_file "Data file", data_file
    click_on "Create Stack word tree"

    expect(page).to have_content("Stack word tree was successfully created.")
    expect(page).to have_content("ire")
    expect(page).to have_content("tritones")
    expect(page).to have_content("traditionless")
  end

  scenario "Updating a tree" do
    tree1.update_column(:result, ["foo", "bar"])
    visit edit_stack_word_tree_path(tree1)

    attach_file "Data file", data_file
    click_on "Update Stack word tree"

    expect(page).to have_content("Stack word tree was successfully updated.")
    expect(page).to have_content("ire")
    expect(page).to have_content("tritones")
    expect(page).to have_content("traditionless")
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

