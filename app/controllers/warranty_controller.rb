class WarrantyController < CrudController
	#@warranty_end muss vom User definiert werden können durch Date-Formular.
	def index
		@low_warranty = params[:lowest_warranty_end_date]
		@max_warranty = params[:warranty_end_date]
		if @max_warranty == ""
			if @low_warranty == ""
			@max_warranty = nil
			else
				@max_warranty = "9999-99-99"
			end
		end
		if @max_warranty == nil
			@notebooks = Notebook.all
			@servers = Server.all
			@disks = Disk.all
		else
			@notebooks = Notebook.where("warranty_till <= :end_date AND warranty_till >= :low_date", :end_date => @max_warranty, :low_date => @low_warranty)
			@servers = Server.where("warranty_till <= :end_date AND warranty_till >= :low_date", :end_date => @max_warranty, :low_date => @low_warranty)
			@disks = Disk.where("warranty_till <= :end_date AND warranty_till >= :low_date", :end_date => @max_warranty, :low_date => @low_warranty)
		end
		@low_warranty = params[:lowest_warranty_end_date]
		@max_warranty = params[:warranty_end_date]
	end
	
end
