class CreateLifeMoments < ActiveRecord::Migration[5.2]
  def change
    create_table :life_moments do |t|
      t.string :main_question
      t.string :sub_question_1
      t.string :sub_question_2
      t.string :sub_question_3
      t.integer :sort
    end
  end
end
