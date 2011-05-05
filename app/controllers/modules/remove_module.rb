module Remove
  
  # List all entries of this model.
  #   GET /entries
  #   GET /entries.xml
  def index
    @entries = list_entries.not_removed.paginate(:page => params[:page])
    respond_with @entries
  end
  
  # List all deleted entries of this model.
  #   GET /entries/deleted
  #   GET /entries/deleted.xml
  def removed
    @entries = list_entries.removed.paginate(:page => params[:page])
    respond_with @entries, :index
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
  
  protected
  def respond_with(object, action = action_name)
    respond_to do |format|
      format.html { render_with_callback action }
      format.xml  { render :xml => object }
    end
  end
end