class AddInRepairToObjects < ActiveRecord::Migration
  def self.up
    add_column :servers, :in_repair, :boolean
    add_column :notebooks, :in_repair, :boolean
    add_column :disks, :in_repair, :boolean
    add_column :rams, :in_repair, :boolean
    add_column :displays, :in_repair, :boolean
  end

  def self.down
    remove_column :servers, :in_repair
    remove_column :notebooks, :in_repair
    remove_column :disks, :in_repair
    remove_column :rams, :in_repair
    remove_column :displays, :in_repair
  end
end
