class Server < ActiveRecord::Base
  belongs_to :distributor
  has_many :rams, :as => 'machine'
end
