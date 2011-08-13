class CreateUserTeams < ActiveRecord::Migration
  def self.up
    create_table :user_teams do |t|
      t.integer :user_id, :null => false
      t.integer :team_id, :null => false

      t.timestamps
    end
    add_index :user_teams, [:user_id, :team_id], :unique => true
  end

  def self.down
    drop_table :user_teams
  end
end
