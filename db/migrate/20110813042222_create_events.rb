class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.binary     'image', :limit => 10.megabytes
      t.string     'name', :null => false
      t.string     'location'
      t.datetime   'start_time'
      t.datetime   'end_time'
      t.boolean    'allow_signup', :null => false, :default => false
      t.boolean    'allow_teams', :null => false, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
