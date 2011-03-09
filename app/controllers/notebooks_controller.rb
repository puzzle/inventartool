class NotebooksController < CrudController
	self.search_columns = [:model, :serial_number, :notes, :service_tag]
end
