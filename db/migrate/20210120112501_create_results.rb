class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.belongs_to :question, foreign_key: true
      t.belongs_to :answer, foreign_key: true
      t.belongs_to :round, foreign_key: true
      t.boolean :success, default: false, null: false

      t.timestamps
    end
  end
end
