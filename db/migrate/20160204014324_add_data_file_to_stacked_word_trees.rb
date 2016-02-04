class AddDataFileToStackedWordTrees < ActiveRecord::Migration
  def change
    add_column :stack_word_trees, :data_file, :string
  end
end
