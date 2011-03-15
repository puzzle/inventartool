class WarrantyController < ApplicationController
	#@warranty_end muss vom User definiert werden können durch Date-Formular.
	def index
		@warranty_end = 350
		@notebooks = Notebook.where(:warranty_till => Date.today + @warranty_end.day)
	end
	
end
