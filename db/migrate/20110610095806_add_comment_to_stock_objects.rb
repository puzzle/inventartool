class AddCommentToStockObjects < ActiveRecord::Migration
  def self.up
    add_column :stock_objects, :comment, :text
  end

  def self.down
    remove_column :stock_objects, :comment
  end
end
