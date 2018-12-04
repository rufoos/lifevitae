class CreateUserAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :user_answers do |t|
      t.integer :user_id, null: false, index: true
      t.integer :life_moment_id, null: false, index: true
      t.string :answer_1
      t.string :answer_2
      t.string :answer_3
    end
  end
end
