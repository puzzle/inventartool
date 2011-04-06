class AddInRepairToDiskVersions < ActiveRecord::Migration
  def self.up
    add_column :disk_versions, :in_repair, :boolean
  end

  def self.down
    remove_column :disk_versions, :in_repair
  end
end
