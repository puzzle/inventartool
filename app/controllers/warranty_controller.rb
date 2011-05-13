#  | # COPYRIGHT HEADER START # 
# |   InventarTool - Web Application to manage hardware and components inventory
# |   Copyright (C) 2011  Puzzle ITC GmbH www.puzzle.ch
# |   
# |   This program is free software: you can redistribute it and/or modify
# |   it under the terms of the GNU Affero General Public License as
# |   published by the Free Software Foundation, either version 3 of the
# |   License, or (at your option) any later version.
# |   
# |   This program is distributed in the hope that it will be useful,
# |   but WITHOUT ANY WARRANTY; without even the implied warranty of
# |   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# |   GNU Affero General Public License for more details.
# |   
# |   You should have received a copy of the GNU Affero General Public License
# |   along with this program.  If not, see <http://www.gnu.org/licenses/>.
# | # COPYRIGHT HEADER END # 
 

class WarrantyController < CrudController

  #@warranty_end muss vom User definiert werden können durch Date-Formular.
  def index
    @title = "Warranty"
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
