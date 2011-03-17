class DisksController < CrudController
	self.search_columns = [:model, :serial_number, :notes, :capacity]
	
	before_render_form :set_values;
	before_save :set_creator
	before_render_show :set_diffhash
	
	def set_values
		@machine_types = ["Notebook", "Server"]
	    @machines = Server.all + Notebook.all
	    @distributors = Distributor.all
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
	
	protected
	def diff_hash
		# diff_hash["version"][created_at] = 2011-03-14 08:35:14 UTC
		# diff_hash["version"]["attribute"] = [ "before", "after" ]
		diff_hash = Hash.new
		(1..(@entry.versions.count)).each do |i|
			v1 = @entry.versions[i - 1] # get version
			v0 = @entry.versions[i - 2] # get version before !
			h_version = diff_hash[v1.version] = Hash.new
			h_version[:updated_at] = v1.updated_at
			h_version[:creator] = v1.creator
			h_version[:change_notice] = v1.change_notice
			(1..(v1.attributes.count)).each do |a|
				a1 = v1.attributes.to_a[a]
				a0 = v0.attributes.to_a[a]
				if a0.to_a[1] != a1.to_a[1] && !(["updated_at", "creator", "change_notice", "version", "id"].include? a0[0] )
					h_version[a1[0]] = [a0[1], a1[1]] # 
				end
			end
		end
		diff_hash
	end
end
