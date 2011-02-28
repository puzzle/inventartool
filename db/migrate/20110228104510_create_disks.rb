class CreateDisks < ActiveRecord::Migration
  def self.up
    create_table :disks do |t|
      t.string :model
      t.string :serial_number
      t.date :purchase_date
      t.date :warranty_till
      t.decimal :price, :precision => 8, :scale => 2
      t.text :notes
      t.integer :capacity
      t.string :connector
      t.references :distributor
      t.integer :machine_id
      t.string :machine_type

      t.timestamps
    end
  end

  def self.down
    drop_table :disks
  end
end
