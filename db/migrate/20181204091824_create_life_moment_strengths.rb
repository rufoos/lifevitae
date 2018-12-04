class CreateLifeMomentStrengths < ActiveRecord::Migration[5.2]
  def change
    create_table :life_moment_strengths do |t|
      t.integer :life_moment_id, null: false, index: true
      t.string :name, null: false
      t.integer :user_id
    end
  end
end
