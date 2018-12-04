class CreateCities < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|
      t.integer :country_id
      t.string :en_name
      t.string :state
      t.boolean :visible, default: true
    end
  end
end
