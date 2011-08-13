class CreateUserEvents < ActiveRecord::Migration
  def self.up
    create_table :user_events do |t|
      t.integer :user_id, :null => false
      t.integer :event_id, :null => false

      t.timestamps
    end
    add_index :user_events, [:user_id, :event_id], :unique => true
  end

  def self.down
    drop_table :user_events
  end
end
