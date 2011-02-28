class CreateStockObjects < ActiveRecord::Migration
  def self.up
    create_table :stock_objects do |t|
      t.string :name
      t.integer :count

      t.timestamps
    end
  end

  def self.down
    drop_table :stock_objects
  end
end
