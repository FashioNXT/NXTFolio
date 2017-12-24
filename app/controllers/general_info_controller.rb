class GeneralInfoController < ApplicationController
  # Variable that holds a params/object with all the attributes filled in
  def list
      @general_infos = GeneralInfo.all
  end
  
  def show
     @general_info = GeneralInfo.find(params[:id])
  end
  
  def get_user_keys array
    @return_array = Array.new
    array.each do |element,index|
      @return_array.push(element[:userKey])
    end
    
    return @return_array
  end
  
  # Displays the correct specific profile search when selected during GeneralInfo search
  def search_redirect
    @objects = params.except("utf8")
    @objects = @objects.except("button")
    
    @general_queries = GeneralInfo.search @objects
    
    flash[:general_queries] = get_user_keys @general_queries
    
    if @objects[:profession] == "1"
      redirect_to specific_designer_search_path 
    elsif @objects[:profession] == "2"
      redirect_to specific_model_search_path 
    elsif @objects[:profession] == "3"
      redirect_to specific_photographer_search_path 
    else
      redirect_to root_path
    end
  end
   
  # Associated with the view used for create
  def new
    @templates = Template.uniq.pluck(:prof_name).sort
    @templates.unshift('Designer')
    @templates.unshift('Model')
    @templates.unshift('Photographer')
    @general_info = GeneralInfo.new
  end
 

  def profession_specific
    last_template_id = GeneralInfo.last.template_id
    template = Template.find(last_template_id)
    $prof_name = template.prof_name
    @some = eval(template.prof_attribute)
  end

  # POST request action for profession_specifi, called when profession_specific form is submitted     
  def profession_specific_create
    field_name_arr = params[:field_name]
    field_value_arr = params[:field_value]
    attributes_json = {}
    if (field_name_arr != nil)
      field_name_arr.each_with_index do |field_name, index|
        attributes_json[field_name] = field_value_arr[index]
      end
    end
    attributes_json = attributes_json.to_json
    ginfo_last = GeneralInfo.last # this would be last entry in general_info i.e. the one created by previous (general_info/new) page
    ginfo_last.specific_profile = attributes_json
    ginfo_last.save
    if ginfo_last.save!
     redirect_to '/show_profile'
    else
     render :action=> 'new'
    end
  end

  # Create is called upon for the 2nd part of profile creation & routes to which specific profile to create after general info is submitted
  def create
    # Check to see if the required params are filled in
    error_statement = ""
    if params[:general_info][:first_name] == ""
      error_statement += "First Name, "
    end
    if params[:general_info][:last_name] == ""
      error_statement += "Last Name, "
    end
    if params[:general_info][:month_ofbirth] == ""
      error_statement += "Month Of Birth, "
    end
    if params[:general_info][:day_ofbirth] == ""
      error_statement += "Day of Birth, "
    end
    if params[:general_info][:year_ofbirth] == ""
      error_statement += "Year of Birth, "
    end
    if params[:general_info][:country] == ""
      error_statement += "Country, "
    end
    if params[:general_info][:state] == ""
      error_statement += "State, "
    end
    if params[:general_info][:city] == ""
      error_statement += "City, "
    end

    if error_statement.length > 0
      error_statement = error_statement[0, error_statement.length-2]
      error_statement += " are required."
      flash[:notice] = error_statement
      redirect_to new_general_info_path and return
    end
      
    # Creates a GeneralInfo object & assigns userKey to be the session key of the current user
    @general_info = GeneralInfo.new(general_info_params)
    @general_info.userKey = session[:current_user_key]
    $template_name = params[:general_info][:specific_profile_id]
    # Save GeneralInfo object to database & redirect to specific profile view
    # Else display GeneralInfo view if save fails
    $redirect_path = general_info_profession_specific_path
    if $template_name == "Designer"
        $redirect_path = new_specific_designer_path
        @general_info.specific_profile_id = 1
    elsif $template_name == "Model"
        $redirect_path = new_specific_model_path
        @general_info.specific_profile_id = 2
    elsif $template_name == "Photographer"
        $redirect_path = new_specific_photographer_path
        @general_info.specific_profile_id = 3
    else
        template_id1 = Template.find_by(prof_name: $template_name).id
        @general_info.template_id = template_id1
    end


    if @general_info.save!
        redirect_to $redirect_path
    else
      render :action => 'new'
    end
  end
  
  # Params used to create the GeneralInfo object
  def general_info_params
    params.require(:general_info).permit(:first_name, :last_name, :month_ofbirth, :day_ofbirth, :year_ofbirth, :gender, :phone, :country, :state, :city, :compensation, :facebook_link, :linkedIn_link, :instagram_link, :personalWebsite_link, :bio, :specific_profile_id, :profile_picture, :cover_picture, :gallery_pictures => [])
  end
  
  # Allows user to edit the general_info_params of the GeneralInfo object
  # Displays information pulled from database that matches the session key of the current user
  # Associated with the view used for update
  def edit
    if GeneralInfo.exists?(:userKey => session[:current_user_key])
      @general_info = GeneralInfo.find_by(userKey: session[:current_user_key])
    else
      redirect_to :action => 'new'
    end
  end
   
  # Saves the edit of the GeneralInfo object to the database
  def update
    @general_info = GeneralInfo.find_by(userKey: session[:current_user_key])
    galleryPict = []
    if @general_info!=nil and @general_info[:gallery_pictures].present?
      galleryPict=@general_info[:gallery_pictures]
    end
    if general_info_update_param[:gallery_pictures].present?
      galleryPict=galleryPict+general_info_update_param[:gallery_pictures]
    end
    general_info_update_param[:gallery_pictures]=galleryPict

    if @general_info.update_attributes(general_info_update_param)
      redirect_to '/show_profile'
    else
      render :action => 'edit'
    end
  end
  
  # Params used to edit the GeneralInfo object
  def general_info_update_param
     params.require(:general_info).permit(:first_name, :last_name, :month_ofbirth, :day_ofbirth, :year_ofbirth, :gender, :phone, :country, :state, :city, :compensation, :facebook_link, :linkedIn_link, :instagram_link, :personalWebsite_link, :bio, :profile_picture, :cover_picture, :gallery_pictures => [])
  end
  
  # Allows user to edit the profession of the GeneralInfo object
  # Displays information pulled from database that matches the session key of the current user
  # Associated with the view used for update_profession
  def edit_profession
    if GeneralInfo.exists?(:userKey => session[:current_user_key])
      @general_info = GeneralInfo.find_by(userKey: session[:current_user_key])
    else
      redirect_to :action => 'new'
    end
  end
  
  # Saves the edit of the GeneralInfo object's profession to the database
  def update_profession
    @general_info = GeneralInfo.find_by(userKey: session[:current_user_key])
     
    if @general_info.update_attribute(specific_profile_id, :specific_profile_id)
      redirect_to '/show_profile'
    else
      render :action => 'edit_profession'
    end
  end
  
  # Params used to edit the GeneralInfo object's profession
  def general_info_update_profession_param
     params.require(:general_info).permit(:specific_profile_id)
  end 
  
  # Not implemented
  def delete
    GeneralInfo.find(params[:userKey]).destroy
  end
  
  # Takes input from the search view & calls the model search functions
  def search
  end
end
