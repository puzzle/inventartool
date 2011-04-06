class DisplaysController < CrudController
	self.search_columns = [:model, :serial_number, :notes]
	
	before_render_form :set_values
	
	def set_values
		@distributors = Distributor.all
		@owners = Owner.all
	end
end
