class DashboardController < CrudController
  def index
  	@title = "InventarTool Dashboard"
  	@user_name = session[:user_name]
  	@user_uid = session[:user_ui]
  	
  end

end
