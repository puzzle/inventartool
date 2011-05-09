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
 

class RepositoryController < CrudController
	
	def index
		@list = []
		@components = params[:entry]
		@machine_id = params[:id]
		@machine_type = params[:machine_type]
		if (@components == "ram")
			entries = Ram.where("machine_id IS Null")
		else
			entries = Disk.where("machine_id IS Null")
		end
		if (entries != nil)
  		entries.each do |r|
  			element = {}
  			@table_headers = []
  			attrs = []
  			r.attrs_list.each do |attr|
  				attrs << r.send(attr)
  				@table_headers << attr
  			end
  			element[:attrs] = attrs
  			element[:id] = r.id
  			@list << element
  		end
		end
	end
	
	def attach
		if (params[:components] == "ram")
			entries = Ram.where("machine_id IS Null")
		else
			entries = Disk.where("machine_id IS Null")
		end
		machine_id = params[:id]
		machine_type = params[:machine_type]
		entries.each do |r|
			if (params[r.id.to_s][:attach] == "1")
				r.update_attribute(:machine_id, machine_id)
				if (machine_type == "notebooks")
					r.update_attribute(:machine_type, "Notebook")
					else
						r.update_attribute(:machine_type, "Server")
				end
			end
		end
		redirect_to :controller => machine_type, :action => 'edit', :id => machine_id
	end
end
