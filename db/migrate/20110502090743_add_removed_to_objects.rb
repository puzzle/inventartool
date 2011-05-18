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
 

class AddRemovedToObjects < ActiveRecord::Migration
  def self.up
    add_column :servers, :removed, :boolean, :default => false
    add_column :notebooks, :removed, :boolean, :default => false
    add_column :disks, :removed, :boolean, :default => false
    add_column :rams, :removed, :boolean, :default => false
    add_column :displays, :removed, :boolean, :default => false
    add_column :distributors, :removed, :boolean, :default => false
    add_column :owners, :removed, :boolean, :default => false
    add_column :stock_objects, :removed, :boolean, :default => false
    
    add_column :disk_versions, :removed, :boolean, :default => false
  end

  def self.down
    remove_column :servers, :removed
    remove_column :notebooks, :removed
    remove_column :disks, :removed
    remove_column :rams, :removed
    remove_column :displays, :removed
    remove_column :distributors, :removed
    remove_column :owners, :removed
    remove_column :stock_objects, :removed
    
    remove_column :disk_versions, :removed
  end
end
