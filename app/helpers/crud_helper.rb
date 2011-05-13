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
module CrudHelper

  # Renders a generic form for the current entry with :default_attrs or the 
  # given attribute array, using the StandardFormBuilder.
  # If a block is given, a custom form may be rendered and attrs is ignored.
  def crud_form(attrs = nil, options = {}, &block)
    attrs = default_attrs - [:created_at, :updated_at] unless attrs
    standard_form(@entry, attrs, &block)
  end
  
  # Create a table of the @entries variable with the default or 
  # the passed attributes in its columns.
  def crud_table(*attrs, &block)
    if block_given?
      list_table(*attrs, &block)
    else      
      attrs = default_attrs if attrs.blank?
      list_table(*attrs) do |t| 
         add_table_actions(t)
      end
    end
  end
  
  # Adds a set of standard action link column (show, edit, destroy) to the given table.
  def add_table_actions(table)
    action_col(table) { |e| link_table_action_show(e) }
    action_col(table) { |e| link_table_action_edit(e) }
    action_col(table) { |e| link_table_action_destroy(e) }
  end
  
  def link_table_action_show(record)
    link_table_action('show', record)
  end
  
  def link_table_action_edit(record)
    link_table_action('edit', edit_polymorphic_path(record))  
  end
  
  def link_table_action_destroy(record)
    link_table_action('delete', record, 
                      :confirm => StandardHelper::CONFIRM_DELETE_MESSAGE, 
                      :method => :delete)  
  end
  
  def link_table_action(image, url, html_options = {})
    link_to(action_icon(image), url, html_options) 
  end
  
  def action_col(table, &block)
    table.col('', :class => 'center', &block)
  end
  
end
