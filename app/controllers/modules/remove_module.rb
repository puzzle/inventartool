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
 

module Remove
  
  # List all entries of this model.
  #   GET /entries
  #   GET /entries.xml
  def index
    @entries = list_entries.not_removed.paginate(:page => params[:page])
    respond_with @entries
  end
  
  # List all deleted entries of this model.
  #   GET /entries/removed
  #   GET /entries/removed.xml
  def removed
    @entries = list_entries.removed.paginate(:page => params[:page])
    respond_with @entries, :removed
  end
  
  # Destroy an existing entry of this model.
  #   DELETE /entries/1
  #   DELETE /entries/1.xml
  def destroy
    # destroy only when object is already removed
    if (@entry.removed != true)
       @entry.removed = true
       success = save_entry
       message = "removed"
    else
      success = with_callbacks(:destroy) { @entry.destroy }
      message = "destroyed"
    end
    respond_processed(success, message ) do |format|
      format.html do 
        if success
          redirect_to_index
        else
          flash.alert = @entry.errors.full_messages.join('<br/>').html_safe
          request.env["HTTP_REFERER"].present? ? redirect_to(:back) : redirect_to_show
        end
      end
    end
  end
  
  # Restore removed entry
  def restore
    set_entry
    @entry.removed = false;
    success = save_entry
    message = "restored"
    respond_processed(success, message ) do |format|
      format.html do 
        if success
          redirect_to_index
        else
          flash.alert = @entry.errors.full_messages.join('<br/>').html_safe
          request.env["HTTP_REFERER"].present? ? redirect_to(:back) : redirect_to_show
        end
      end
    end
  end
  
  protected
  def respond_with(object, action = action_name)
    respond_to do |format|
      format.html { render_with_callback action }
      format.xml  { render :xml => object }
    end
  end
end