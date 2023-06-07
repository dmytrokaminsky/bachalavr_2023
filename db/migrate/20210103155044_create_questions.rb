class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.text :title, null: false
      t.references :author, foreign_key: false

      t.timestamps
    end

    add_foreign_key :questions, :users, column: :author_id
  end
end
