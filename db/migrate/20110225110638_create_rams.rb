class CreateRams < ActiveRecord::Migration
  def self.up
    create_table :rams do |t|
      t.integer :capacity
      t.string :description
      t.integer :machine_id
      t.string :machine_type

      t.timestamps
    end
  end

  def self.down
    drop_table :rams
  end
end
