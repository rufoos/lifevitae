class CreateUserAchievements < ActiveRecord::Migration[5.2]
  def change
    create_table :user_achievements do |t|
      t.integer :user_id, null: false, index: true
      t.string :name, null: false
    end
  end
end
