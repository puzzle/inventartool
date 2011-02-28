class Notebook < ActiveRecord::Base
  belongs_to :distributor
  belongs_to :owner
  
  has_many :disks, :as => :machine
  has_many :rams, :as => :machine
  
  def label
  	"#{model}"
  end
end
