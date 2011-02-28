class Display < ActiveRecord::Base
  belongs_to :distributor
  belongs_to :owner
  
  def label
  	"#{model}"
  end
end
