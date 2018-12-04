class CreateUserEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :user_events do |t|
      t.integer :user_id, null: false, index: true
      t.integer :life_event_id, null: false, index: true
      t.integer :year, limit: 2
      t.integer :event_type, limit: 1
    end
  end
end
