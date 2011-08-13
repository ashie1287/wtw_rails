class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string 'name', :null => false
      t.string 'location'
      t.date 'start_time'
      t.date 'end_time'
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
