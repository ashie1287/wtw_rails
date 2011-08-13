class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.string :name, :null => false
      t.integer :event_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :teams
  end
end
