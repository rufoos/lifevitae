class CreateUserAnswerStrengths < ActiveRecord::Migration[5.2]
  def change
    create_table :user_answer_strengths do |t|
      t.integer :user_answer_id, null: false, index: true
      t.integer :life_moment_strength_id, null: false, index: true
    end
  end
end
