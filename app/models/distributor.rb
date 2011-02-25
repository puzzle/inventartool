class Distributor < ActiveRecord::Base
	has_many :servers
	
	def label
		"#{name}"
	end
end
