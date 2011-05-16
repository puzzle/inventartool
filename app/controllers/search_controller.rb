class SearchController < CrudController
  
  def index
    @title = "Search"
    @notebooks = Notebook.all
    @servers = Server.all
    @disks = Disk.all
    @rams = Ram.all
    @displays = Display.all
    
    params[:notebooks] = "on"
    params[:servers] = "on"
    params[:disks] = "on"
    params[:rams] = "on"
    params[:displays] = "on"
  end
  
  def search
    @title = "Search"
    blnRemoved = false
    blnCheck = false
    if (params[:removed] == "on")
      blnRemoved = true
    end
    
    #----- Notebooks
    if (params[:notebooks] == "on")    
      blnCheck = true
      if (params[:standard_searchField] != "" || params[:owner] != "" || params[:distributor] != "")
        @notebooks = Notebook.where("removed = :removed", :removed => blnRemoved)
      end
      
      if (params[:standard_searchField] != "") 
        @notebooks = @notebooks & standard_search(@notebooks)
      end
      
      if (params[:owner] != "")
        @notebooks = @notebooks & owner_search(@notebooks)
      end
      
      if (params[:distributor] != "") 
        @notebooks = @notebooks & distributor_search(@notebooks)
      end
     end
    #----- Servers
    if (params[:servers] == "on")
      blnCheck = true
      if (params[:standard_searchField] != "" || params[:distributor] != "")
        @servers = Server.where("removed = :removed", :removed => blnRemoved)
       end
      
      if (params[:standard_searchField] != "") 
        @servers = @servers & standard_search(@servers)
      end
      
      if (params[:distributor] != "") 
        @servers = @servers & distributor_search(@servers)
      end
    end
    #----- Disks
    if (params[:disks] == "on")
      blnCheck = true
      if (params[:standard_searchField] != "" || params[:distributor] != "" || params[:machine] != "")
        @disks = Disk.where("removed = :removed", :removed => blnRemoved)
      end
      
      if (params[:standard_searchField] != "") 
        @disks = @disks & standard_search(@disks)
      end
      
      if (params[:machine] != "") 
        @disks = @disks & machine_search(@disks)
      end
      
      if (params[:distributor] != "") 
        @disks = @disks & distributor_search(@disks)
      end
    end
    
    #----- Rams
    if (params[:rams] == "on")
      blnCheck = true
      if (params[:standard_searchField] != "" || params[:distributor] != "" || params[:machine] != "")
        @rams = Ram.where("removed = :removed", :removed => blnRemoved)
      end
      
      if (params[:standard_searchField] != "") 
        @rams = @rams & standard_search(@rams)
      end
      
      if (params[:machine] != "") 
        @rams = @rams & machine_search(@rams)
      end
      
      if (params[:distributor] != "") 
        @rams = @rams & distributor_search(@rams)
      end
    end
    
    #----- Displays
    if (params[:displays] == "on")
      blnCheck = true
      if (params[:standard_searchField] != "" || params[:owner] != "" || params[:distributor] != "")
        @displays = Display.where("removed = :removed", :removed => blnRemoved)
      end
      
      if (params[:standard_searchField] != "") 
        @displays = @displays & standard_search(@displays)
      end
      
      if (params[:owner] != "")
        @displays = @displays & owner_search(@displays)
      end
      
      if (params[:distributor] != "") 
        @displays = @displays & distributor_search(@displays)
      end
     end
    if (blnCheck == false)
      @notebooks = Notebook.all
      @servers = Server.all
      @disks = Disk.all
      @rams = Ram.all
      @displays = Display.all
    end
    render :action => 'index'
  end
  
  #----------------------------------------------------------------------|
  # Owner Search
  #----------------------------------------------------------------------|
  def owner_search(objects)
    
    objects_list = []
    owners = Owner.where("name LIKE :search_value", :search_value => "%#{params[:owner]}%")
    objects.each do |o|
        owners.each do |d|
          if (o.owner_id == d.id)
              objects_list << o
          end
        end
    end
    objects_list
  end
  
  #----------------------------------------------------------------------|
  # Distributor Search
  #----------------------------------------------------------------------|
  def distributor_search(objects)  
    objects_list = []
    distributors = Distributor.where("name LIKE :search_value", :search_value => "%#{params[:distributor]}%")
    objects.each do |o|
        distributors.each do |d|
          if (o.distributor_id == d.id)
              objects_list << o
          end
        end
    end
    objects_list
  end
  
  #----------------------------------------------------------------------|
  # Machine Search
  #----------------------------------------------------------------------|
  def machine_search(objects)
    objects_list = []
    notebooks = Notebook.where("model LIKE :search_value", :search_value => "%#{params[:machine]}%")
    servers = Server.where("model LIKE :search_value", :search_value => "%#{params[:machine]}%")
    machines = notebooks + servers
    objects.each do |o|
      machines.each do |m|
        if (m.id == o.machine_id)
          objects_list << o
        end
      end
    end
    objects_list
  end
  #----------------------------------------------------------------------|
  # Looks wich columns are used for the Search Method
  #----------------------------------------------------------------------|
  def standard_search(objects)
    return_objects = []
    objects.each do |o|
      o.attrs_list.each do |x|
        if (o.read_attribute(x).to_s =~ /#{params[:standard_searchField]}/i)
         return_objects << o
         end
      end
    end
    return_objects
  end
  
end