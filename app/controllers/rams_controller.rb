class RamsController < CrudController
	self.search_columns = [:capacity, :description, :machine_id, :machine_type, :serial_number]
end
