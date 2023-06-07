class CreateRounds < ActiveRecord::Migration[5.2]
  def change
    create_table :rounds do |t|
      t.references :theme, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :current_answers, default: 0, null: false
      t.integer :wrong_answers, default: 0, null: false
      t.boolean :finished, default: false, null: false

      t.timestamps
    end
  end
end
