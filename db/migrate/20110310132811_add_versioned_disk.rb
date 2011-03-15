class AddVersionedDisk < ActiveRecord::Migration
  def self.up
  	Disk.create_versioned_table
  end

  def self.down
  	Disk.drop_versioned_table
  end
end
