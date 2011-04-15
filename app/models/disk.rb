class Disk < ActiveRecord::Base
  	belongs_to :distributor
  	belongs_to :machine, :polymorphic => true
  	acts_as_versioned :table_name => :disk_versions
 
    def label
  	"#{model}"
  end
  
  def age_in_days
  	(Date.today - purchase_date).to_s
  end
  
  def warranty_end_in_days
  	(warranty_till - Date.today).to_s
  end
  
  def attrs_list
  	[:model, :capacity, :serial_number]
  end
end
