class Owner < ActiveRecord::Base
	has_many :displays
	has_many :notebooks
	
	def label
		"#{name}"
	end
end
