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
 

# Extension of StandardHelper functionality to provide a set of default 
# attributes for the current model to be used in tables and forms. This helper
# is included in CrudController.
module ListHelper
  
  # Create a table of the @entries variable with the default or 
  # the passed attributes in its columns.
  def list_table(*attrs, &block)
    # only use default attrs if no attrs and no block are given
    attributes = (block_given? || attrs.present?) ? attrs : default_attrs
    table(@entries) do |t|
      t.sortable_attrs(*attributes)    
      yield t if block_given? 
    end
  end
    
  # The default attributes to use in attrs, list and form partials.
  # These are all defined attributes except certain special ones like 'id' or 'position'.
  def default_attrs  
    attrs = model_class.column_names.collect(&:to_sym)
    attrs - [:id, :position, :password, :updated_at, :created_at, :removed]
  end
    
end
