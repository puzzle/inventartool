class ServersController < CrudController
	self.search_columns = [:model, :processor, :serial_number, :notes]
end
