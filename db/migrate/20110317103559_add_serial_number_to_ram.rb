class AddSerialNumberToRam < ActiveRecord::Migration
  def self.up
    add_column :rams, :serial_number, :string
  end

  def self.down
    remove_column :rams, :serial_number
  end
end
