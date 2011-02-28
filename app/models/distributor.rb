class Distributor < ActiveRecord::Base
	has_many :servers
	has_many :displays
	
	def label
		"#{name}"
	end
end
