class AddCommentToStockObjects < ActiveRecord::Migration
  def self.up
    add_column :stock_objects, :comment, :text
    add_column :stock_object_versions, :comment, :text
  end

  def self.down
    remove_column :stock_objects, :comment
    remove_column :stock_object_versions, :comment
  end
end
