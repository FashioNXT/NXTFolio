class ShowProfileController < ApplicationController
  # Associated with the view that displays after a profile is selected from the search results list
  def show_profile
    @gallery_taggings = GalleryTagging.all
    logger.info("Debugging Star rating:")
    logger.debug(@gallery.inspect)
  
    if session[:current_user_key] != nil or params[:user_key] != nil
      user_key_current = params[:user_key] || session[:current_user_key]
      @error = user_key_current.to_s
      puts "sessions current_user_key" + user_key_current.to_s
  
      @user = GeneralInfo.find_by(userKey: user_key_current)
      load_notifications if @user && @user.notification
  
      if GeneralInfo.exists?(:userKey => user_key_current)
        load_general_info(user_key_current)
        set_profile_data(user_key_current)
        check_admin_and_own_profile(user_key_current)
        load_job_info(user_key_current)
        handle_profile_selection(user_key_current)
        load_following_data(user_key_current)
      else
        # SHould show blank stuff
      end
    else
      redirect_to "/login_info/login"
    end
    puts @attribute_titles.inspect
  end

  def destroy
    @gallery = Gallery.find(params[:id])
    puts @gallery
    puts("destroy show pro running!!!")
    #@myArr = @gallery[:gallery_picture]
    @index = params[:id].to_i
    @gallery.destroy
    redirect_to '/show_profile'
  end
  
  private
  
  # Extracted method for loading notifications
  def load_notifications
    @notifications_from = @user.notification_from
  end
  
  # Extracted method for loading general info
  def load_general_info(user_key_current)
    @gallery = Gallery.all
    @general_info = GeneralInfo.find_by(userKey: user_key_current)
    @general_info_attributes = GeneralInfo.attribute_names
    @general_info_values = @general_info.attribute_values
    @login_info = LoginInfo.find_by(userKey: user_key_current)
    @email = @login_info&.email
  end
  
  # Extracted method for setting profile data
  def set_profile_data(user_key_current)
    @username = @general_info[:first_name]
    @on_Own = session[:current_user_key] == user_key_current
    @is_Admin = GeneralInfo.find_by(userKey: session[:current_user_key])&.is_admin || false
    @job_title = @general_info[:job_name].presence || "Photographer"
  end
  
  # Extracted method for loading job info
  def load_job_info(user_key_current)
    using_default = @job_title == "Photographer"
    if GeneralInfo.check_Job?(@job_title) && !using_default
      @attribute_titles = @job_title.constantize.view_Attr
      @attribute_types = @job_title.constantize.view_Attr_Type
      @attribute_contents = @general_info_values[:job_attr]
    else
      @attribute_titles = {}
      @attribute_types = []
      @attribute_contents = {}
    end
  end
  
  # Extracted method for handling profile selection
  def handle_profile_selection(user_key_current)
    case @general_info.specific_profile_id
    when 1
      # Load SpecificDesigner if exists
      # @specific_designer = SpecificDesigner.find_by(user_key: user_key_current)
    when 2
      # Load SpecificModel if exists
      # @specific_model = SpecificModel.find_by(user_key: user_key_current)
    when 3
      # Load SpecificPhotographer if exists
      # @specific_photographer = SpecificPhotographer.find_by(user_key: user_key_current)
    else
      @profile_type = "Error"
    end
  end
  
  # Extracted method for loading following data
  def load_following_data(user_key_current)
    @followers = @user.get_followers
    @following = @user.get_users_they_follow
    current_user = GeneralInfo.find_by(userKey: session[:current_user_key])
    @currently_following = Follow.exists?(follower: current_user, followee: @user)
  end
  
  # Extracted method for checking admin and own profile
  def check_admin_and_own_profile(user_key_current)
    if GeneralInfo.find_by(userKey: session[:current_user_key])
      @addUser = user_key_current
    end
  end  
end