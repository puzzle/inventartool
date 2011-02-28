class CreateDisplays < ActiveRecord::Migration
  def self.up
    create_table :displays do |t|
      t.decimal :price, :precision => 8, :scale => 2
      t.date :purchase_date
      t.string :serial_number
      t.string :model
      t.text :notes
      t.references :distributor
      t.references :owner

      t.timestamps
    end
  end

  def self.down
    drop_table :displays
  end
end
