class AddThemeIdToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_reference :questions, :theme, foreign_key: true, index: true
  end
end
