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
 

class AddInRepairToObjects < ActiveRecord::Migration
  def self.up
    add_column :servers, :in_repair, :boolean
    add_column :notebooks, :in_repair, :boolean
    add_column :disks, :in_repair, :boolean
    add_column :rams, :in_repair, :boolean
    add_column :displays, :in_repair, :boolean
  end

  def self.down
    remove_column :servers, :in_repair
    remove_column :notebooks, :in_repair
    remove_column :disks, :in_repair
    remove_column :rams, :in_repair
    remove_column :displays, :in_repair
  end
end
