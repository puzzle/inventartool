class Server < ActiveRecord::Base
  belongs_to :distributor
  has_many :rams, :as => :machine
  has_many :disks, :as => :machine
  
  def label
  	"#{model} #{serial_number}"
  end
  
  def age_in_days
  	(Date.today - purchase_date).to_s
  end
  
  def warranty_end_in_days
  	(warranty_till - Date.today).to_s
  end
end
