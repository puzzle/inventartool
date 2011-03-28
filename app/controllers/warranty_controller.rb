class WarrantyController < CrudController
	#@warranty_end muss vom User definiert werden können durch Date-Formular.
	def index
		@low_warranty = params[:lowest_warranty_end_date]
		@warranty = params[:warranty_end_date]
		if @warranty == ""
			if @low_warranty == ""
			@warranty = nil
			else
				@warranty = Date.today
			end
		end
		if @warranty == nil
		@notebooks = Notebook.all
		@servers = Server.all
		@disks = Disk.all
		@rams = Ram.all
		else
		@notebooks = Notebook.where("warranty_till <= :end_date AND warranty_till >= :low_date", :end_date => @warranty, :low_date => @low_warranty)
		@servers = Server.where("warranty_till <= :end_date AND warranty_till >= :low_date", :end_date => @warranty, :low_date => @low_warranty)
		@disks = Disk.where("warranty_till <= :end_date AND warranty_till >= :low_date", :end_date => @warranty, :low_date => @low_warranty)
		@rams = Ram.where("warranty_till <= :end_date AND warranty_till >= :low_date", :end_date => @warranty, :low_date => @low_warranty)
	end
	end	
	
end
