class Disk < ActiveRecord::Base
  	belongs_to :distributor
  	belongs_to :machine, :polymorphic => true
	validates :machine_id, :presence => true
  
    def label
  	"#{model}"
  end
end
