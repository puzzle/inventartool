class AddNameToServer < ActiveRecord::Migration
  def self.up
    add_column :servers, :name, :string
  end

  def self.down
    remove_column :servers, :name
  end
end
