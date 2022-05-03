class EditJobController < ApplicationController
=begin
  def list
    @specific_designers = SpecificDesigner.all
  end
   
  def show
    @specific_designer = SpecificDesigner.find(params[:id])
  end
  
  # Associated with the view used for search_redirect
  def search
  end
  
  # Displays the correct specific profile search when selected during SpecificDesigner search
  def search_redirect
    @checkboxes = params[:checkboxes]
    @experience = params[:checkboxes]
    @params_arg = params
    
    @user_objects = SpecificDesigner.search @checkboxes,flash[:general_queries], @experience, @params_arg
    
    @user_objects.each do |object|
      @general_info_object = GeneralInfo.find_by(object[:userKey])
      
      @attribute_param = object.attribute_values
      @attribute_param[:first_name] = @general_info_object[:first_name]
      @attribute_param[:last_name] = @general_info_object[:last_name]
      @attribute_param[:gender] = @general_info_object[:gender]
      @attribute_param[:state] = @general_info_object[:state]
      @attribute_param[:profession] = @general_info_object[:profession]
    end
    
    redirect_to search_profile_show_path
  end
  
  def prep_show 
  end
  
  # Associated with the view used for create
  def new
    @specific_designer = SpecificDesigner.new
  end
   
  # Create is called upon for the 3rd part of profile creation
  def create
    # Creates a SpecificDesigner object
    @specific_designer = SpecificDesigner.new(specific_designer_params)
    @genre_str
    if !params[:specific_designer][:allgenres].nil?
      for index in 0 ... params[:specific_designer][:allgenres].size
         @genre_str = @genre_str.to_s + params[:specific_designer][:allgenres][index] + ","
      end
    else
    end
    
    # Sets genre for the SpecificDesigner object
    @specific_designer.genre = @genre_str
    # Assigns user_key to be the session key of the current user
    @specific_designer.user_key = session[:current_user_key]

    # If SpecificDesigner object saved correctly to database, displays home page
    # Else displays the SpecificDesigner new view
    if @specific_designer.save!
     redirect_to root_path
    else
     render :action=> 'new'
 end
  end
  
  # Params used to create the SpecificDesigner object
  def specific_designer_params
    params.require(:specific_designer).permit(:genre, {:allgenres => []}, :influencers, :specialties, :compensation, :experience)  #passing into create with these keys.
  end
=end  
  # Allows user to edit the params of the SpecificDesigner object
  # Displays information pulled from database that matches the session key of the current user
  # Associated with the view used for update
  def edit
    if session[:current_user_key] == nil
      redirect_to '/' and return
    end
    if GeneralInfo.exists?(:userKey => session[:current_user_key])
      @general_info = GeneralInfo.find_by(userKey: session[:current_user_key])
      if @general_info
        @attr_contents = @general_info[:job_attr]
      end
      @general_info[:job_attr] = {}  # DO NOT DELETE - Form helper does not like the keys being integers, must be set to empty then rebuilt by controller in patch request
      @general_info_attributes = GeneralInfo.attribute_names
      @general_info_values = @general_info.attribute_values
      @login_info = LoginInfo.find_by(userKey: session[:current_user_key])
      

      @job_title = @general_info[:job_name]
      if (@job_title == "" || @job_title == nil)
        @job_title = "Photographer"
      end
      if @job_title == 'Admin'
        @attr_titles = Array.new
        @attr_types = Array.new
        @attr_contents = Array.new  
      else
        @attr_titles = @job_title.constantize.view_Attr()
        @attr_types = @job_title.constantize.view_Attr_Type()
      end
      @holder = GeneralInfo.new
    else
      redirect_to '/'and return
    end
  end
   
  # Saves the edit of the SpecificDesigner object to the database
  def update
    @holder = params[:general_info].to_hash
    @general_info = GeneralInfo.find_by(userKey: session[:current_user_key])
    
    @convert = Hash.new
    @holder["job_attr"].each do |key, val| 
	@convert[key.to_i] = val
    end
    #if params[:job_attr].present?
     # @general_info[:job_attr] = edit_job_update_param[:job_attr]
    #end
    if @general_info.update_attribute(:job_attr, @convert)
      redirect_to '/show_profile'
    else
      render :action => 'edit'
    end
  end
  
  

  # Params used to edit the SpecificDesigner object
  def specific_designer_param
    params.require(:specific_designer).permit(:genre, :influencers, :specialties, :compensation, :experience)  
  end
   
  # Not implemented
  def delete
    SpecificDesigner.find(params[:user_key]).destroy
    redirect_to :action => 'root_path'
  end
end
