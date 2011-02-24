class Server < ActiveRecord::Base
  belongs_to :distributor
  has_many :rams, :as => 'machine'
  
  def label
  	"#{model} #{serial_number}"
  end
end
