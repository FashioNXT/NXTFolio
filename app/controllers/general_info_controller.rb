class GeneralInfoController < ApplicationController

  def list
    @general_infos = GeneralInfo.all
  end
  
  def generate_about_me
    @general_info = GeneralInfo.find_by(userKey: session[:current_user_key])
    generator = AboutMeGenerator.new(@general_info)

    # Return 404 if no matching user is found
  unless @general_info
    render json: { error: 'User not found' }, status: :not_found and return
  end
  
    missing_fields = generator.missing_fields
    Rails.logger.info "Missing fields: #{missing_fields}" # Debugging
  
    # Generate the About Me content, even if there are missing fields
    about_me_content = generator.generate_about_me
    Rails.logger.info "About Me content: #{about_me_content}"
  
    # If there are missing fields, include them as recommendations
    if missing_fields.any?
      render json: { 
        about_me: about_me_content, 
        missing_fields: missing_fields, 
        message: "For better personalization, please complete the following fields: #{missing_fields.join(', ')}."
      }
    else
      # If no missing fields, just return the generated About Me content
      render json: { about_me: about_me_content }
    end
  end
  
  def show
    # @general_info = GeneralInfo.find(params[:id])
  end

  def get_user_keys(array)
    # Placeholder for logic to extract user keys from array
  end

  def make_admin
    if admin_authorized?
      user_entry = GeneralInfo.find_by(userKey: params[:user])
      if user_entry
        update_user_as_admin(user_entry)
        redirect_to show_profile_show_profile_path(user_key: params[:user])
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  def new
    set_possible_jobs_and_templates
    set_countries
    initialize_general_info
  end

  def new2
    load_general_info
    @show_generate_about_me_button = true
    render :edit2
  end

  def create
    @possible_Jobs = GeneralInfo.see_Jobs
    @general_info = GeneralInfo.new(general_info_params)
  
    if email_exists?
      flash[:error] = "An account with this email already exists. Please log in or use a different email."
      render :new and return
    end
  
    setup_login_user
  
    if @general_info.save
      flash[:success] = "Profile created successfully."
  
      # Send the welcome email only if the profile was saved successfully
      UserMailer.welcome_email(@general_info, session[:current_login_user]).deliver_now!
  
      # Handle redirection based on the selected option
      if params[:select_one]
        session.delete(:current_login_user)
        redirect_to general_info_new2_path   and return
      elsif params[:select_two]
        redirect_to search_engine_show_path  and return
      else
        head :no_content # Return 204 No Content for successful creation without redirection
      end
    else
      flash[:error] = @general_info.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    set_countries_and_jobs
    load_general_info || redirect_to(action: 'new')
  end

  def edit2
    if load_general_info
      @username = @general_info[:first_name]
    else
      puts "No GeneralInfo found for userKey: #{session[:current_user_key]}"
      flash[:notice] = "Please complete your profile to proceed."
      redirect_to :action => 'new' and return
    end

    load_general_info || redirect_to(action: 'new')
  end

  def edit_travel
    load_general_info || redirect_to(action: 'new')
  end

  def update
    @general_info = GeneralInfo.find_by(userKey: session[:current_user_key])

    if @general_info.update(general_info_update_param)
      params[:continue] ? redirect_to('/general_info/edit2') : redirect_to('/show_profile')
    else
      render :edit
    end
  end

  def follow
    current_user = GeneralInfo.find_by(userKey: session[:current_user_key])
    other_user = GeneralInfo.find(params[:id])
    current_user.follow(params[:id])
    redirect_to show_profile_show_profile_path(user_key: other_user.userKey)
  end

  def unfollow
    current_user = GeneralInfo.find_by(userKey: session[:current_user_key])
    other_user = GeneralInfo.find(params[:id])
    current_user.unfollow(params[:id])
    redirect_to show_profile_show_profile_path(user_key: other_user.userKey)
  end

  def destroy
    # Placeholder for Gallery destroy logic
  end

  def search
    # Placeholder for search logic
  end

  private

  def admin_authorized?
    session[:current_user_key] != params[:user] &&
      GeneralInfo.find_by(userKey: session[:current_user_key]).is_admin
  end

  def update_user_as_admin(user_entry)
    user_entry.update(is_admin: true, job_name: 'Admin')
  end

  def set_possible_jobs_and_templates
    @possible_Jobs = GeneralInfo.see_Jobs
    @templates = Template.pluck(:prof_name).sort.unshift('Designer', 'Model', 'Photographer')
  end

  def set_countries
    @countries = Country.all.order(:name)
  end

  def initialize_general_info
    @general_info ||= GeneralInfo.new
    @general_info.emailaddr = session[:current_login_user]["email"] if session.key?(:current_login_user)
  end

  def email_exists?
    LoginInfo.exists?(email: params[:general_info][:emailaddr])
  end

  def setup_login_user
    current_user = session[:current_login_user]
    login_user = LoginInfo.create!(
      email: params[:general_info][:emailaddr],
      password: current_user["password"],
      password_confirmation: current_user["password"],
      userKey: generate_user_key
    )
    session[:current_user_key] = login_user.userKey

    initialize_general_info_profile
  end

  def generate_user_key
    SecureRandom.hex(10)
  end

  def initialize_general_info_profile
    @general_info.userKey = session[:current_user_key]
    @general_info.is_admin = GeneralInfo.none?
    @general_info.job_name = assign_job_name
  end

  def assign_job_name
    job_name = params[:general_info][:job_name]
    GeneralInfo.any? && job_name.to_s.casecmp('admin').zero? ? 'Photographer' : job_name
  end

  def set_countries_and_jobs
    set_countries
    @possible_Jobs = GeneralInfo.see_Jobs
  end

  def load_general_info
    return unless GeneralInfo.exists?(userKey: session[:current_user_key])

    @general_info = GeneralInfo.find_by(userKey: session[:current_user_key])
    @username = @general_info.first_name
  end

  def general_info_params
    params.require(:general_info).permit(
      :first_name, :last_name, :company, :industry, :highlights, :country, :state,
      :city, :emailaddr, :bio, :specialization, :profdetails, :facebook_link,
      :linkedIn_link, :profile_picture, :personalWebsite_link, :compensation,
      :experience, :specific_profile_id, :job_name, :profile_picture, :cover_picture,
      :gallery_pictures, :travel_country, :travel_state, :travel_city, :travel_start,
      :travel_end, :travel_details, tempVar: []
    )
  end

  def general_info_update_param
    params.require(:general_info).permit(
      :first_name, :last_name, :company, :highlights, :industry, :country, :state,
      :city, :emailaddr, :bio, :specialization, :profdetails, :facebook_link,
      :linkedIn_link, :profile_picture, :personalWebsite_link, :compensation,
      :experience, :cover_picture, :gallery_pictures, :travel_country, :travel_state,
      :travel_city, :travel_start, :travel_end, :travel_details, tempVar: []
    )
  end
end
