class CreateUserEventTeams < ActiveRecord::Migration
  def self.up
    create_table :user_event_teams do |t|
      t.integer :event_id, :null => false
      t.integer :user_id,  :null => false
      t.integer :team_id

      t.timestamps
    end
    add_index(:user_event_teams, [:user_id, :event_id, :team_id], :unique => true)
    add_index(:user_event_teams, [:user_id, :event_id], :unique => true)
  end

  def self.down
    drop_table :user_event_teams
  end
end
