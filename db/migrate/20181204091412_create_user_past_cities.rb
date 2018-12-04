class CreateUserPastCities < ActiveRecord::Migration[5.2]
  def change
    create_table :user_past_cities do |t|
      t.integer :user_id, null: false, index: true
      t.integer :country_id, null: false, index: true
      t.integer :city_id, null: false, index: true
    end
  end
end
