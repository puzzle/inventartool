class DisksController < CrudController
	self.search_columns = [:model, :serial_number, :notes, :capacity]
	
	def edit
		@machine_types = ["Notebook", "Server"]
	    @machines = Server.all + Notebook.all
	    @distributors = Distributor.all
	    render_with_callback 'edit'
	end
	def update
	    @entry.attributes = params[model_identifier]
	    @entry.creator = session[:user_ui]
	    updated = with_callbacks(:update) { save_entry }
	    respond_processed(updated, 'updated', 'edit')
	end
	def new
		@machine_types = ["Notebook", "Server"]
		@machines = Server.all + Notebook.all
		@distributors = Distributor.all
		render_with_callback 'new'
	end
	def create
	    @entry.attributes = params[model_identifier]
	    @entry.creator = session[:user_ui]
	    created = with_callbacks(:create) { save_entry } 
	    
	    respond_processed(created, 'created', 'new') do |format|
	      format.xml  { render :xml => @entry, :status => :created, :location => @entry } if created
	    end
  	end
	def show
    	@diffhash = diff_hash
    	respond_with @entry
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
		(2..(@entry.versions.count)).each do |i|
			v1 = @entry.versions[i - 1] # Aktuelle Version
			v0 = @entry.versions[i - 2] # Vorherige Version
			h_version = diff_hash[v1.version] = Hash.new
			h_version[:created_at] = v1.created_at
			h_version[:creator] = v1.creator
			(1..(v1.attributes.count)).each do |a|
				a1 = v1.attributes.to_a[a]
				a0 = v0.attributes.to_a[a]
				if a0.to_a[1] != a1.to_a[1] && !(["updated_at", "version", "id"].include? a0[0] )
					h_version[a1[0]] = [a0[1], a1[1]] # 
				end
			end
		end
		diff_hash
	end
end
