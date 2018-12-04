class CreateLifeSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :life_skills do |t|
      t.string :name, null: false
      t.integer :user_id
    end
  end
end
