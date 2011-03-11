class Disk < ActiveRecord::Base
  	belongs_to :distributor
  	belongs_to :machine, :polymorphic => true
  	acts_as_versioned :table_name => :disk_versions
 
    def label
  	"#{model}"
  end
end
