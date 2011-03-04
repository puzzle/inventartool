class Disk < ActiveRecord::Base
  	belongs_to :distributor
  	belongs_to :machine, :polymorphic => true
 
    def label
  	"#{model}"
  end
end
