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

  def make_admin
    if !(session[:current_user_key] != params[:user] && GeneralInfo.find_by(userKey: session[:current_user_key]).is_admin)
      @user_entry = GeneralInfo.find_by(userKey: params[:user])
      if @user_entry
        @user_entry.update_attribute(:is_admin, true)
        @user_entry.update_attribute(:job_name,'Admin')
        redirect_to "/show_profile?user_key="+ params[:user].to_s
      else
        puts @user_entry.inspect
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
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
    @possible_Jobs = GeneralInfo.see_Jobs
    # @templates = Template.uniq.pluck(:prof_name).sort
    @templates = Template.pluck(:prof_name).sort
    @templates.unshift('Designer')
    @templates.unshift('Model')
    @templates.unshift('Photographer')

    # get default email from session if available
    @general_info ||= GeneralInfo.new
    @general_info.emailaddr = session[:current_login_user]["email"] if session.has_key? :current_login_user
  end

  def new2
    @general_info ||= GeneralInfo.new
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
    @possible_Jobs = GeneralInfo.see_Jobs
    # Check to see if the required params are filled in
    @general_info = GeneralInfo.new(general_info_params)
    error_statement = ""
    if params[:general_info][:first_name] == ""
      error_statement += "First Name, "
    end
    if params[:general_info][:highlights] == ""
      error_statement += "Highlights, "
    end
    if params[:general_info][:last_name] == ""
      error_statement += "Last Name, "
    end
    if params[:general_info][:company] == ""
      error_statement += "Company"
    end
    if params[:general_info][:industry] == ""
      error_statement += "Industry"
    end
    if params[:general_info][:job_name] == ""
      error_statement += "Profession"
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
    if params[:general_info][:emailaddr] == ""
      error_statement += "Email, "
    end

    if error_statement.length > 0
      error_statement = error_statement[0, error_statement.length-2]
      error_statement += " are required."
      flash[:notice] = error_statement
      render :new and return
    end

    # Add room to LoginInfo DB here to
    # synchronize with GeneralInfo DB
    current_user = session[:current_login_user]
    login_user = LoginInfo.new(
      :email => params[:general_info][:emailaddr], 
      :password => current_user["password"], 
      :password_confirmation => current_user["password"]
    )
    userKey = SecureRandom.hex(10)
    login_user.userKey = userKey
    login_user.save!
    session[:current_user_key] = userKey

    # Creates a GeneralInfo object & assigns userKey to be the session key of the current room
    @general_info = GeneralInfo.new(general_info_params)
    logger.info("Hey I am here")
    logger.debug(@general_info.inspect)
    @general_info.userKey = session[:current_user_key]
    @general_info.is_admin = false

    $template_name = params[:general_info][:job_name]

    if GeneralInfo.any?
      @general_info.is_admin = false
      if(@general_info.job_name == 'Admin' || @general_info.job_name == 'admin')
        @general_info.job_name = 'Photographer'
      end
    else
      @general_info.job_name = 'Admin'
      @general_info.is_admin = true
    end

    unless @general_info.save!
      flash[:error] = "Unknown error when saving: try again later"
      render :action => 'new' and return
    end

    # Send Verification Email upon successful sign-up
    #UserMailer.welcome_email(@general_info,current_user).deliver_now! #works
    if params[:select_one]
      session.delete(:current_login_user)
      redirect_to "/general_info/new2"
    elsif params[:select_two]
      redirect_to "/search_engine/show"
    end
    
    # Redirect to specific profession edit page
    #if $template_name == "Designer"
      #@general_info.update_attribute(:specific_profile_id,1)
      #redirect_to "/specific_designer/edit"
      #elsif $template_name == "Model"
      #@general_info.update_attribute(:specific_profile_id,2)
      #redirect_to "/specific_model/edit"
      #elsif $template_name == "Photographer"
      #@general_info.update_attribute(:specific_profile_id,3)
      #redirect_to "/specific_photographer/edit"
    #end
  end

  # Params used to create the GeneralInfo object
  def general_info_params
    params.require(:general_info).permit(:first_name, :last_name, :company, :industry, \
        :highlights, :country, :state, :city, :emailaddr, :bio, :specialization, \
        :profdetails, :facebook_link, :linkedIn_link, :profile_picture, :personalWebsite_link, \
        :compensation, :experience, :specific_profile_id, :job_name, :profile_picture, :cover_picture, \
        :gallery_pictures, :travel_country, :travel_state, :travel_city, :travel_start, :travel_end, :travel_details, :tempVar => [])
  # the tempVar here does not have any meaning, 
  # but if deleted, the last variable will not be permit, don't know why
  # keep the tempVar at the end!
  end

  # Allows room to edit the general_info_params of the GeneralInfo object
  # Displays information pulled from database that matches the session key of the current room
  # Associated with the view used for update
  def edit
    @possible_Jobs = GeneralInfo.see_Jobs
    if GeneralInfo.exists?(:userKey => session[:current_user_key])
      @general_info = GeneralInfo.find_by(userKey: session[:current_user_key])
    else
      redirect_to :action => 'new'
    end
  end

  def edit2
    if GeneralInfo.exists?(:userKey => session[:current_user_key])
      @general_info = GeneralInfo.find_by(userKey: session[:current_user_key])
    else
      redirect_to :action => 'new'
    end

  end
  
  # edit travel info
  def edit_travel
    if GeneralInfo.exists?(:userKey => session[:current_user_key])
      @general_info = GeneralInfo.find_by(userKey: session[:current_user_key])
    else
      redirect_to :action => 'new'
    end

  end
  
  

  # Saves the edit of the GeneralInfo object to the database
  def update
    logger.info("Debugging general info edit")
    logger.debug(params.inspect)
    @general_info = GeneralInfo.find_by(userKey: session[:current_user_key])
    
    #if @general_info.update_attributes!(general_info_update_param)
    if @general_info.update(general_info_update_param)
      if params[:select_one]
        #session.delete(:current_login_user)
        #redirect_to "/general_info/edit2"
        redirect_to '/show_profile'
      elsif params[:select_two]
        redirect_to '/show_profile'
      end
    else
      render :action => 'edit'
    end
  end

  # Params used to edit the GeneralInfo object
  def general_info_update_param
    params.require(:general_info).permit(:first_name, :last_name, :company, :highlights, :industry, \
        :country, :state, :city, :emailaddr, :bio, :specialization, :profdetails, :facebook_link, \
        :linkedIn_link, :profile_picture, :personalWebsite_link, :compensation, :experience, \
        :cover_picture, :gallery_pictures, :travel_country, :travel_state, :travel_city, :travel_start, :travel_end, :travel_details, :tempVar => [])
  end

  # Allows room to edit the profession of the GeneralInfo object
  # Displays information pulled from database that matches the session key of the current room
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


  #for destroying Gallery
  def destroy
    GeneralInfo.find(params[:gallery]).destroy
  end


  # Takes input from the search view & calls the model search functions
  def search
  end
end
