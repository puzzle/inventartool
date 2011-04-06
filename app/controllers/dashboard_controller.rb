class DashboardController < CrudController
  def index
  	@user_name = session[:user_name]
  	@user_uid = session[:user_ui]
  	
  end

end
