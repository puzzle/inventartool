class CreateRams < ActiveRecord::Migration
  def self.up
    create_table :rams do |t|
      t.integer :capacity
      t.string :type
      t.references :machine

      t.timestamps
    end
  end

  def self.down
    drop_table :rams
  end
end
