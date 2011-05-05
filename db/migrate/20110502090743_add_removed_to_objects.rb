class AddRemovedToObjects < ActiveRecord::Migration
  def self.up
    add_column :servers, :removed, :boolean, :default => false
    add_column :notebooks, :removed, :boolean, :default => false
    add_column :disks, :removed, :boolean, :default => false
    add_column :rams, :removed, :boolean, :default => false
    add_column :displays, :removed, :boolean, :default => false
    add_column :distributors, :removed, :boolean, :default => false
    add_column :owners, :removed, :boolean, :default => false
    add_column :stock_objects, :removed, :boolean, :default => false
    
    add_column :disk_versions, :removed, :boolean, :default => false
  end

  def self.down
    remove_column :servers, :removed
    remove_column :notebooks, :removed
    remove_column :disks, :removed
    remove_column :rams, :removed
    remove_column :displays, :removed
    remove_column :distributors, :removed
    remove_column :owners, :removed
    remove_column :stock_objects, :removed
    
    remove_column :disk_versions, :removed
  end
end
