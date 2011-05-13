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