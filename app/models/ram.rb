class Ram < ActiveRecord::Base
  belongs_to :machine, :polymorphic => true
  def label 
  	"#{capacity}"
  end
end
