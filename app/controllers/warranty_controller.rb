class WarrantyController < ApplicationController
	#@warranty_end muss vom User definiert werden können durch Date-Formular.
	def index
		@warranty_end = 14
		@warranty_object = :warranty_till
		@notebooks = Notebook.where("warranty_till <= :end_date", :end_date => (Date.today + @warranty_end.day))
	end
	
end
