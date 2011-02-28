class Ram < ActiveRecord::Base
	belongs_to :machine, :polymorphic => true
	validates :machine_id, :presence => true
	
	def label
		"#{capacity} MB, #{description}"
	end
end
