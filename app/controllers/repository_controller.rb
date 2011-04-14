class RepositoryController < CrudController
	
	def index
		@rams = Ram.where("machine_id IS Null")
		@machine_id = params[:id]
		@machine_type = params[:machine_type]
	end
	
	def attach
		rams = Ram.where("machine_id IS Null")
		machine_id = params[:id]
		machine_type = params[:machine_type]
		rams.each do |r|
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
