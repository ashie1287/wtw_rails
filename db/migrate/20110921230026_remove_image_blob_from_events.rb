class RemoveImageBlobFromEvents < ActiveRecord::Migration
  def self.up
    remove_column(:events, :image)
  end

  def self.down
    add_column(:events, :image, :binary, :limit => 10.megabytes)
  end
end
