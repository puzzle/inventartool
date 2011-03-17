class AddChangeNoticeToDisk < ActiveRecord::Migration
  def self.up
    add_column :disks, :change_notice, :string
    add_column :disk_versions, :change_notice, :string
  end

  def self.down
    remove_column :disks, :change_notice
    remove_column :disk_versions, :change_notice
  end
end
