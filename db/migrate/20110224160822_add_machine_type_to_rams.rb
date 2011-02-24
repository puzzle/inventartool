class AddMachineTypeToRams < ActiveRecord::Migration
  def self.up
  	add_column :rams, :machine_type, :string
  end

  def self.down
  	remove_column :rams, :machine_type, :string
  end
end
