class WarrantyController < ApplicationController
	#@warranty_end muss vom User definiert werden können durch Date-Formular.
	def index
		if params[:warranty_end_date] == nil
		@notebooks = Notebook.all
		else
		@notebooks = Notebook.where("warranty_till <= :end_date", :end_date => params[:warranty_end_date])
	end
	end	
	
end
