class CreateThemes < ActiveRecord::Migration[5.2]
  def change
    create_table :themes do |t|
      t.string :title, null: false
      t.integer :questions_count, default: 0
    end
  end
end
