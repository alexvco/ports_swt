class CreateStackWordTrees < ActiveRecord::Migration
  def change
    create_table :stack_word_trees do |t|
      t.string :name
      t.text :result

      t.timestamps null: false
    end
  end
end
