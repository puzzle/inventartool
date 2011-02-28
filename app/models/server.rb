class Server < ActiveRecord::Base
  belongs_to :distributor
  has_many :rams, :as => :machine
  has_many :disks, :as => :machine
  
  def label
  	"#{model} #{serial_number}"
  end
end
