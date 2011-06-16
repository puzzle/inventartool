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
 

class NotebooksController < CrudController
  #Remove Module
  require 'modules/remove_module.rb'
  include Remove
  define_model_callbacks :render_removed
  
  # Versions Module
  require 'modules/versions_module.rb'
  include Versions
  before_render_show :set_diffhash
  before_save :set_creator
  
  self.search_columns = [:model, :serial_number, :notes, :service_tag]
  
  before_filter :set_warranty, :only => [:update, :create]
  before_render_form :set_values
  
  def set_warranty
    @warranty_till = (params[model_identifier][:warranty_till]).to_i
    @purchase_date = Date.parse((params[model_identifier][:purchase_date]))
    # @purchase_date = Date.parse( {"1i"=>params[model_identifier][:"purchase_date(1i)"], "2i"=>params[model_identifier][:"purchase_date(2i)"], "3i"=>params[model_identifier][:"purchase_date(3i)"]}.to_a.sort.collect{|c| c[1]}.join("-"))
    params[model_identifier][:warranty_till] = @purchase_date + @warranty_till.years
  end
  
  def set_values
    @entry.purchase_date ||= Date.today
    @entry.warranty_till ||= Date.today
    if (@entry.warranty_till != nil)
      @entry.warranty_till = ((@entry.warranty_till - @entry.purchase_date).to_i)/365
    end
  end
  
  def unuse
    set_entry
    puts @entry.inspect
    @entry.distributor = nil
    detached = save_entry
    redirect_to :back
  end
  
end
