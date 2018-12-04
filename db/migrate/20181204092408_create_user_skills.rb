class CreateUserSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :user_skills do |t|
      t.integer :user_id, null: false, index: true
      t.integer :life_skill_id, null: false, index: true
    end
  end
end
