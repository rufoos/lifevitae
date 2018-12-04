class ChangeUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.string :fullname, null: false
      t.date :birth_date
      t.string :phone
      t.integer :gender, index: true, limit: 1
      t.integer :country_id, index: true
      t.integer :city_id, index: true
      t.string :looking_for
      t.string :job_current_role
      t.string :job_org_name
      t.string :job_about_desc
    end
  end
end
