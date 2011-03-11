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
	def show
		@version_diff = diffVersions
    	respond_with @entry
  	end
	
	def detach
		set_entry
 		@entry.machine_id = nil
		@entry.machine_type = nil
		detached = save_entry
		redirect_to :back
	end
	
	def diffVersions
		set_entry
		version_diff = []
		for i in 2..(@entry.versions.count) do
			v1 = @entry.versions[i - 1]
			v0 = @entry.versions[i - 2]
			diff = []
			for a in 1..(v1.attributes.count) do
				a1 = v1.attributes.to_a[a]
				a0 = v0.attributes.to_a[a]
				if a0.to_a[1] != a1.to_a[1] && !(["updated_at", "version", "id"].include? a0[0] )
					diff << [a1[0],a0[1], a1[1]]
				end
			end
			version_diff << diff
		end
		version_diff
	end
end
