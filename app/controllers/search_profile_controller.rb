class SearchProfileController < ApplicationController
  # Variable that holds a params/object with all the attributes filled in
  def list
    @search_profiles = SearchProfile.all
  end
   
  # Associated with the view that displays all search results
  def show
    @users = Array.new
    flash[:user_keys] = flash[:user_keys]
    if flash[:user_keys] == "ALL"
      @users = GeneralInfo.all
    elsif !(flash[:user_keys].empty?)
      flash[:user_keys].each do |user_key|
        @users.push(GeneralInfo.find_by(userKey: user_key))
      end
    else
      flash[:notice] = "No entries matched your search."
    end
  end
  
  # Not implemented (not needed for this controller, can be deleted)
  def create
  end
  
  def get_user_keys array
    @return_array = Array.new
    array.each do |element,index|
      @return_array.push(element[:userKey])
    end
    
    return @return_array
  end
  
  # Empty function needed for rendering a view
  def search
    
    @possible_Jobs = Array.new
    @possible_Jobs[0] = 'Any'
    @possible_Jobs = @possible_Jobs + GeneralInfo.see_Jobs
  end
  
  def search_general
    @possible_Jobs = Array.new
    @possible_Jobs[0] = 'Any'
    @possible_Jobs = @possible_Jobs + GeneralInfo.see_Jobs
    @search_params = params.except("utf8").except("button")

    @job_title = @search_params[:job_type]
    puts @job_title
    if @job_title == "Any"
      @attr_titles = []
    else 
      if (@job_title == "" || @job_title == nil)
        @job_title = "Photographer"
      end

      @attr_titles = @job_title.constantize.view_Attr()
      @attr_types = @job_title.constantize.view_Attr_Type()

      puts @attr_titles.inspect

    end

    flash[:titles] = @attr_titles
    flash[:job_title] = @job_title
    redirect_to :action => 'search_job'

    # Pass which ever users were in the resulting @user_keys to the next tier of searching.
    #if @search_params[:profession] == "0"
    #  if flash[:user_keys].empty?
        #flash[:user_keys] = "ALL"
    #  end
    #  redirect_to :action => 'show'
    #elsif @search_params[:profession] == "1"
    #  redirect_to :action => 'search_designer'
    #elsif @search_params[:profession] == "2"
    #  redirect_to :action => 'search_model'
    #elsif @search_params[:profession] == "3"
    #  redirect_to :action => 'search_photographer'
    #else
    #  redirect_to :action => 'show'
    #end
  end
  
  # Associated with the view for search_profile/search_job
  def search_job
    @attr_titles = flash[:titles]
    @job_title = flash[:job_title]
  end

  def search_photographer

    redirect_to :action => 'show'
  end

  def search_login
    @search_params = params.except("utf8").except("button")

    if @search_params==nil or @search_params[:email]==nil or @search_params[:email] == ''
      @general_queries = GeneralInfo.all
    else
      @general_queries = LoginInfo.search @search_params
    end

    #@general_queries = GeneralInfo.search @search_params

    #Get the user keys
    @user_keys = get_user_keys @general_queries

    flash[:user_keys] = @user_keys

    # Pass which ever users were in the resulting @user_keys to the next tier of searching.
    redirect_to :action => 'show'
  end

  def search_specific
    @checkboxes = params[:checkboxes]
    @experience = params[:checkboxes]
    @params_arg = params

    @job = params[:job_name]

    puts @job

    @search_params = Hash.new

    params.each do |key, val|
      if val != "" && val != "Contains" && val != "Any" && key != "utf8" && key != "controller" && key != "action"
        @search_params[key] = val
      end
    end

    puts @search_params
    
    @user_keys = SpecificJob.search flash[:user_keys], @search_params, @job
    
    if @user_keys.empty?
      #@user_keys = get_user_keys SpecificDesigner.all
    end
    
    flash[:user_keys] = @user_keys
    redirect_to :action => 'show'
  end
  
  # Associated with the view for search_profile/search_model
  def search_model
  end
  
  def search_specific_model
    @params_arg = params
    @checkboxes = params[:checkboxes]

    @search_params = Hash.new

    params.each do |key, val|
      if val != "" && val != "Contains" && val != "Any" && key != "utf8" && key != "controller" && key != "action"
        @search_params[key] = val
      end
    end
    
    @user_keys = SpecificModel.search flash[:user_keys], @search_params
    
    if @user_keys.empty?
      #@user_keys = get_user_keys SpecificModel.all
    end
    
    flash[:user_keys] = @user_keys
    redirect_to :action => 'show'
  end
  
  def search_specific_photographer
    @checkboxes = params[:checkboxes]
    @experience = params[:experience]
    @params_arg = params
    
    @search_params = Hash.new

    params.each do |key, val|
      if val != "" && val != "Contains" && val != "Any" && key != "utf8" && key != "controller" && key != "action"
        @search_params[key] = val
      end
    end
    
    @user_keys = SpecificPhotographer.search flash[:user_keys], @search_params
    
    if @user_keys.empty?
      #@user_keys = get_user_keys SpecificPhotographer.all
    end
    flash[:user_keys] = @user_keys
    redirect_to :action => 'show'
  end
  
  def search_profile_params
    #passing into create with these keys.
    params.require(:search_profile).permit(:email, :password, :password_confirmation)
  end
  
  # Associated with the view that displays after a profile is selected from the search results list
  def show_profile
    if GeneralInfo.exists?(:userKey => params[:id])
      @general_info = GeneralInfo.find_by(userKey: params[:id])
      @general_info_attributes = GeneralInfo.attribute_names
      @general_info_values = @general_info.attribute_values
      
      case @general_info.specific_profile_id
      when 1
        @profile_type = "Designer"
        if SpecificDesigner.exists?(:user_key => params[:id])
          @specific_designer = SpecificDesigner.find_by(user_key: params[:id])
          @profile_info = @specific_designer.attribute_values
        else
          #stuff
        end
      when 2
        @profile_type = "Model"
        if SpecificModel.exists?(:user_key => params[:id])
          @specific_model = SpecificModel.find_by(user_key: params[:id])
          @profile_info = @specific_model.attribute_values
        else
          #stuff
        end
      when 3
        @profile_type = "Photographer"
        if SpecificPhotographer.exists?(:user_key => params[:id])
          @specific_photographer = SpecificPhotographer.find_by(user_key: params[:id])
          @profile_info = @specific_photographer.attribute_values
        else
          #stuff
        end
      else
        puts "Unknown profile type! Profile type given: " + @general_info.specific_profile_id
        @profile_type = "Error"
      end
    else
      #SHOULD DISPLAY BLANK STUFF!!!!
      @general_info = GeneralInfo.new
      @general_info_values = Hash.new
    end
  end
  
  # The 4 methods below are not implemented
  def edit
    @search_profile = SearchProfile.find(params[:id])
  end
   
  def update
    @search_profile = SearchProfile.find(params[:id])
    	
    if @search_profile.update_attributes(login_info_param)
      redirect_to :action => 'show', :id => @login_info
    else
      render :action => 'edit'
    end
  end

  def search_profile_param
    params.require(:login_info).permit(:title, :price, :subject_id, :description)
  end
   
  def delete
    SearchProfile.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
