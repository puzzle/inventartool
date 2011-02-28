class Owner < ActiveRecord::Base
	has_many :displays
	
	def label
		"#{name}"
	end
end
