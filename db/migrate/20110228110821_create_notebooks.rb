class CreateNotebooks < ActiveRecord::Migration
  def self.up
    create_table :notebooks do |t|
      t.string :model
      t.string :processor
      t.string :serial_number
      t.string :service_tag
      t.string :express_service_code
      t.decimal :price, :precision => 8, :scale => 2
      t.date :purchase_date
      t.date :warranty_till
      t.date :owner_changed_on
      t.string :previous_owner
      t.string :battery_serial_number
      t.string :power_supply_serial_number
      t.string :mac_addr_lan
      t.string :mac_addr_wlan
      t.text :notes
      t.references :distributor
      t.references :owner

      t.timestamps
    end
  end

  def self.down
    drop_table :notebooks
  end
end
