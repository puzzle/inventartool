class Ram < ActiveRecord::Base
	belongs_to :machine, :polymorphic => true
	
	def label
		"#{capacity} MB, #{description}"
	end
end
