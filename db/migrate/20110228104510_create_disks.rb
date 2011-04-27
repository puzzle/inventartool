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
 

class CreateDisks < ActiveRecord::Migration
  def self.up
    create_table :disks do |t|
      t.string :model
      t.string :serial_number
      t.date :purchase_date
      t.date :warranty_till
      t.decimal :price, :precision => 8, :scale => 2
      t.text :notes
      t.integer :capacity
      t.string :connector
      t.references :distributor
      t.integer :machine_id
      t.string :machine_type

      t.timestamps
    end
  end

  def self.down
    drop_table :disks
  end
end
