class StockObjectsController < CrudController
	self.search_columns = [:name]
end
