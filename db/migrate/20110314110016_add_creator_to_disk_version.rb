class AddCreatorToDiskVersion < ActiveRecord::Migration
  def self.up
    add_column :disk_versions, :creator, :string
  end

  def self.down
    remove_column :disk_versions, :creator
  end
end
