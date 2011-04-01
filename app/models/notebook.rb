class Notebook < ActiveRecord::Base
  belongs_to :distributor
  belongs_to :owner
  
  has_many :disks, :as => :machine
  has_many :rams, :as => :machine
  
  def label
  	"#{model}"
  end
  
  def age_in_days
  	(Date.today - purchase_date).to_s
  end
  
  def warranty_end_in_days
  	(warranty_till - Date.today).to_s
  end
end
