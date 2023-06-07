class AddQuestionsCollectionToRounds < ActiveRecord::Migration[5.2]
  def change
    add_column :rounds, :questions_collection, :string, null: false, default: ''
  end
end
