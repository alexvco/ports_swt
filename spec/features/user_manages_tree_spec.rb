require "rails_helper"

feature "User Manages StackWordTrees" do

  context "Creating a new trees from the home page" do
    scenario "With file that has stack trees" do
      upload_file_and_submit(data_file)

      expect(page).to have_content("Your stack tree is called #{StackWordTree.first.name}, take good care of it!")
      expect(page).to have_content("ire")
      expect(page).to have_content("tritones")
      expect(page).to have_content("traditionless")
      expect(current_path).to eq(stack_word_tree_path(StackWordTree.first))
    end

    scenario "With file that doesn't have stack trees" do
      upload_file_and_submit(no_tree_data_file)

      expect(page).to have_content("Sorry, it looks like this file doesn't have any stacked word trees")
      expect(page).to_not have_content("Your stack tree is called #{StackWordTree.first.name}, take good care of it!")
      expect(page).to_not have_content("ire")
      expect(current_path).to eq(stack_word_tree_path(StackWordTree.first))
    end
  end

  scenario "Viewing All Existing Trees" do
    tree1.update_column(:name, "Tree1")
    tree2.update_column(:name, "Tree2")
    visit_tree_page

    expect(page).to have_content("Tree1")
    expect(page).to have_content("Tree2")
    expect(current_path).to eq(stack_word_trees_path)
  end

  scenario "Viewing Details Of a Tree" do
    tree1.update_columns(name: "Tree1", result: ["foo", "bar"])
    visit_tree_page
    click_on "View Tree Details"

    expect(page).to have_content("Your stack tree is called #{StackWordTree.first.name}, take good care of it!")
    expect(page).to have_content("foo")
    expect(page).to have_content("bar")
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

  def no_tree_data_file
    @data_file ||= File.join(Rails.root, 'spec', 'support', 'no_tree_file.dat')
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

  def upload_file_and_submit(file)
    visit root_path
    expect(page).to_not have_content("Here Is Your Awesome Stacked Word Tree!")
    expect(page).to_not have_content("ire")
    attach_file "Data file", file
    click_on "Find My Stacked Word Tree"
  end
end

