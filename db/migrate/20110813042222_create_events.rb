class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.binary     'image'
      t.string     'name', :null => false
      t.string     'location'
      t.datetime   'start_time'
      t.datetime   'end_time'
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
