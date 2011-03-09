require 'net/ldap'

class ApplicationController < ActionController::Base
  before_filter :load_settings, :authenticate

  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery 
  
  def load_settings
    @application_settings = YAML.load( File.open( RAILS_ROOT + "/config/settings.yml" ) )
  end

  def authenticate
    authenticate_or_request_with_http_basic @application_settings['general']['title'] do |username, password|
      ldap = Net::LDAP.new :host => @application_settings['ldap']['host'],
                           :port => @application_settings['ldap']['port'],
                           :base => @application_settings['ldap']['base']

      begin
        bind_result = ldap.bind_as :filter   => "(uid=#{username})",
                                   :password => password
      rescue Net::LDAP::LdapError
        bind_result = false
      end

      # Lets have a look if the user is in the admin group
      ldap.search :filter => Net::LDAP::Filter.eq('memberUid', username),
                  :base => @application_settings['ldap']['admin_group_dn'] do |entry|
        session[:admin_group] = true
      end
      
      if bind_result
        session[:user_name] = bind_result.first.givenname.to_s + " " + bind_result.first.sn.to_s
        session[:user_mail] = bind_result.first.mail.to_s                                                                                                                                     
        session[:user_ui]  = bind_result.first.uid.to_s                                                                                                                                       
      end
                                                                                                                                                                                 
      bind_result
    end
  end

end
