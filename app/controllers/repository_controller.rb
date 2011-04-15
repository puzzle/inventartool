class RepositoryController < CrudController
	
	def index
		@list = []
		@components = params[:entry]
		@machine_id = params[:id]
		@machine_type = params[:machine_type]
		puts @components
		if (@components == "ram")
			entries = Ram.where("machine_id IS Null")
		else
			entries = Disk.where("machine_id IS Null")
		end
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
