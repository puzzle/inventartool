class Distributor < ActiveRecord::Base
	has_many :servers
	has_many :displays
	has_many :disks
	has_many :notebooks
	
	
	def label
		"#{name}"
	end
end
