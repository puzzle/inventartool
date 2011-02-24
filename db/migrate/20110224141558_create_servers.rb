class CreateServers < ActiveRecord::Migration
  def self.up
    create_table :servers do |t|
      t.string :model
      t.string :processor
      t.date :purchase_date
      t.date :warranty_till
      t.integer :rack_units
      t.string :serial_number
      t.decimal :price
      t.text :notes
      t.references :distributor

      t.timestamps
    end
  end

  def self.down
    drop_table :servers
  end
end
