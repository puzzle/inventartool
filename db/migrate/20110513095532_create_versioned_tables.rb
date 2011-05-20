#  | # COPYRIGHT HEADER START # 
# |   InventarTool - Web Application to manage hardware and components inventory
# |   Copyright (C) 2011  Puzzle ITC GmbH www.puzzle.ch
# |   
# |   This program is free software: you can redistribute it and/or modify
# |   it under the terms of the GNU Affero General Public License as
# |   published by the Free Software Foundation, either version 3 of the
# |   License, or (at your option) any later version.
# |   
# |   This program is distributed in the hope that it will be useful,
# |   but WITHOUT ANY WARRANTY; without even the implied warranty of
# |   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# |   GNU Affero General Public License for more details.
# |   
# |   You should have received a copy of the GNU Affero General Public License
# |   along with this program.  If not, see <http://www.gnu.org/licenses/>.
# | # COPYRIGHT HEADER END # 
 

class CreateVersionedTables < ActiveRecord::Migration
  def self.up
    add_column :displays, :creator, :string
    add_column :displays , :change_notice, :string
    Display.create_versioned_table
    
    add_column :distributors, :creator, :string
    add_column :distributors , :change_notice, :string
    Distributor.create_versioned_table
    
    add_column :notebooks, :creator, :string
    add_column :notebooks , :change_notice, :string
    Notebook.create_versioned_table
    
    add_column :owners, :creator, :string
    add_column :owners , :change_notice, :string
    Owner.create_versioned_table
    
    add_column :rams, :creator, :string
    add_column :rams , :change_notice, :string
    Ram.create_versioned_table
    
    add_column :servers, :creator, :string
    add_column :servers , :change_notice, :string
    Server.create_versioned_table
    
    add_column :stock_objects, :creator, :string
    add_column :stock_objects, :change_notice, :string
    StockObject.create_versioned_table
  end

  def self.down
    remove_column :displays, :creator
    remove_column :displays, :change_notice
    Display.drop_versioned_table
    
    remove_column :distributors, :creator
    remove_column :distributors, :change_notice
    Distributor.drop_versioned_table
    
    remove_column :notebooks, :creator
    remove_column :notebooks, :change_notice
    Notebook.drop_versioned_table
    
    remove_column :owners, :creator
    remove_column :owners, :change_notice
    Owner.drop_versioned_table
    
    remove_column :rams, :creator
    remove_column :rams, :change_notice
    Ram.drop_versioned_table
    
    remove_column :servers, :creator
    remove_column :servers, :change_notice
    Server.drop_versioned_table
    
    remove_column :stock_objects, :creator
    remove_column :stock_objects, :change_notice
    StockObject.drop_versioned_table
  end
end
