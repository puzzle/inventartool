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
 

class RamsController < CrudController
	self.search_columns = [:capacity, :description, :serial_number]
	before_filter :set_machine, :only => [:update, :create]
	
	before_render_form :set_values
	
	def set_values
	    @a_machines = []
	    Notebook.all.each do |machine|
	    	@a_machines << ["Notebook: #{machine.label}", "Notebook_#{machine.id}"]
	    end
	    Server.all.each do |machine|
	    	@a_machines << ["Server: #{machine.label}", "Server_#{machine.id}"]
	    end
	    @a_machines << ["(none)", nil ]
	end

	def set_machine
		m = params[model_identifier].delete(:machine).split("_")
		@entry.machine_type = m[0]
		@entry.machine_id = m[1]
	end
	def set_change_notice
		if (params[model_identifier][:change_notice] == "")
			params[model_identifier][:change_notice] = @entry.change_notice
		end
	end

	def set_creator
		@entry.creator = session[:user_ui]
	end

	def set_diffhash
		@diffhash = diff_hash
	end
	
	def detach
		set_entry
 		@entry.machine_id = nil
		@entry.machine_type = nil
		detached = save_entry
		redirect_to :back
	end
end
