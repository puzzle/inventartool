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
 

require 'net/ldap'
require 'will_paginate/array'

class ApplicationController < ActionController::Base
  before_filter :load_settings, :authenticate

  clear_helpers # Disable loading of all helpers, so that specific disks_helper is used by Disk, and rams_helper by Ram ...

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery 
  
  def load_settings
    @application_settings = YAML.load( File.open( RAILS_ROOT + "/config/settings.yml" ) )
  end

  def authenticate
   if (! session[:user_ui])
      authenticate_or_request_with_http_basic @application_settings['general']['authname'] do |username, password|
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
  
end
