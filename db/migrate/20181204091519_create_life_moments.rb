class CreateLifeMoments < ActiveRecord::Migration[5.2]
  def change
    create_table :life_moments do |t|
      t.text :main_question
      t.integer :sort
    end
  end
end
