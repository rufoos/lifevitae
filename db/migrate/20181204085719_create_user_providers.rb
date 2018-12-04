class CreateUserProviders < ActiveRecord::Migration[5.2]
  def change
    create_table :user_providers do |t|
      t.integer :user_id, null: false, index: true
      t.string :username
      t.string :provider, null: false
      t.string :uid, null: false
      t.text :token
      t.string :avatar_link
      t.integer :expires_at, limit: 5
      t.string :refresh_token
    end
  end
end
