class DisksController < CrudController
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
end
