class DisksController < CrudController
	self.search_columns = [:model, :serial_number, :notes, :capacity]
	
	def edit
		@machine_types = ["Notebook", "Server"]
	    @machines = Server.all + Notebook.all
	    @distributors = Distributor.all
	    render_with_callback 'edit'
	end
	def new
		@machine_types = ["Notebook", "Server"]
		@machines = Server.all + Notebook.all
		@distributors = Distributor.all
		render_with_callback 'new'
	end
	
	def detach
		set_entry
 		puts @entry.inspect
		@entry.machine_id = nil
		@entry.machine_type = nil
		detached = save_entry
		redirect_to :back
	end
end
