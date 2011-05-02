class Admin::BinaryResourcesController < Admin::BaseController
  resource_controller :except => [:show]

  index.response do |wants|
    wants.html { render :action => :index }
    wants.json { render :json => @collection.to_json()  }
  end
  
  new_action.response do |wants|
    wants.html {render :action => :new, :layout => false}
  end

  create.response do |wants|
    # go to edit form after creating as new post
    wants.html {redirect_to admin_binary_resources_url }
  end

  update.response do |wants|
    # override the default redirect behavior of r_c
    # need to reload Post in case name / permalink has changed
    wants.html {redirect_to admin_binary_resources_url }
  end

  private
  
    def collection

      unless request.xhr?
        # Note: the SL scopes are on/off switches, so we need to select "not_deleted" explicitly if the switch is off
        # QUERY - better as named scope or as SL scope?
        #if params[:search].nil? || params[:search][:deleted_at_not_null].blank?
        #  base_scope = base_scope.not_deleted
        #end

        @search = BinaryResource.search(params[:search])
        @search.order ||= "descend_by_id"

        @collection = @search.paginate( :page  => params[:page] )
      else
        @collection = Post.title_contains(params[:q]).all(:limit => 10)
        @collection.uniq!
      end

    end
  
end 