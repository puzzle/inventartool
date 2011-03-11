class DisplaysController < CrudController
	self.search_columns = [:model, :serial_number, :notes]
end
