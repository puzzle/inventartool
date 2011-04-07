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
