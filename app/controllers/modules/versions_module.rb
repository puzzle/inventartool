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
 

module Versions
  

  def set_diffhash
    @diffary = diff_ary.reverse.paginate(:page => params[:page], :per_page => 5)
    p @diffary
  end
  
  def set_creator
    @entry.creator = session[:user_ui]
  end

  protected
  def diff_ary
    # diff_hash["version"][created_at] = 2011-03-14 08:35:14 UTC
    # diff_hash["version"]["attribute"] = [ "before", "after" ]
    diff_ary = []
    (1..(@entry.versions.count)).each do |i|
      v1 = @entry.versions[i - 1] # get version
      v0 = @entry.versions[i - 2] # get version before !
      h_version = {}
      h_version[:updated_at] = v1.updated_at
      h_version[:creator] = v1.creator
      h_version[:change_notice] = v1.change_notice
      (1..(v1.attributes.count)).each do |a|
        a1 = v1.attributes.to_a[a]
        a0 = v0.attributes.to_a[a]
        if a0.to_a[1] != a1.to_a[1] && !(["updated_at", "creator", "change_notice", "version", "id"].include? a0[0] )
          h_version[a1[0]] = [a0[1], a1[1]] # h_version[:key] = ["before", "after"]
        end
      end
      diff_ary << {:version => v1.version, :diff =>  h_version, }
    end
    diff_ary
  end
end