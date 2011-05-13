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
 

class Server < ActiveRecord::Base
  belongs_to :distributor
  has_many :rams, :as => :machine
  has_many :disks, :as => :machine
  
  acts_as_versioned
  
  scope :removed, where(:removed => true)
  scope :not_removed, where(:removed => (nil or false))
  
  def label
    "#{model} #{serial_number}"
  end
  
  def age_in_days
    (Date.today - purchase_date).to_s
  end
  
  def warranty_end_in_days
    (warranty_till - Date.today).to_s
  end
  
  def attrs_list
    [:name, :model, :processor, :serial_number]
  end
  def list_columns
    [:name, :model, :processor, :serial_number, :distributor]
  end
end
