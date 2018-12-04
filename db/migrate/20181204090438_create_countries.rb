class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.string :en_name
      t.boolean :visible, default: true
      t.string :code, limit: 3
      t.string :code2, limit: 2
    end
  end
end
