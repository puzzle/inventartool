class AddCreatorToDisk < ActiveRecord::Migration
  def self.up
    add_column :disks, :creator, :string
  end

  def self.down
    remove_column :disks, :creator
  end
end
