class StockObject < ActiveRecord::Base
	
	def label
		"#{name}"
	end
end
