class Ram < ActiveRecord::Base
	belongs_to :machine, :polymorphic => true
	
	def label
		"#{capacity} MB, #{description}"
	end
	
	def attrs_list
		[:description, :capacity, :serial_number]
	end
end
