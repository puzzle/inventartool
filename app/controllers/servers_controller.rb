class ServersController < CrudController
	self.search_columns = [:name, :model, :processor, :serial_number, :notes]
	before_filter :set_warranty, :only => [:update, :create]
	before_render_form :set_values
	
	def set_warranty
		@warranty_till = (params[model_identifier][:warranty_till]).to_i
		@purchase_date = Date.parse( {"1i"=>params[model_identifier][:"purchase_date(1i)"], "2i"=>params[model_identifier][:"purchase_date(2i)"], "3i"=>params[model_identifier][:"purchase_date(3i)"]}.to_a.sort.collect{|c| c[1]}.join("-"))
		params[model_identifier][:warranty_till] = @purchase_date + @warranty_till.years
	end
	
	def set_values
		if (@entry.warranty_till != nil)
	    	@entry.warranty_till = ((@entry.warranty_till - @entry.purchase_date).to_i)/365
	    end
	end
end
