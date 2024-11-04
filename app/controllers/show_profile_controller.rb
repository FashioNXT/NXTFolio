class ShowProfileController < ApplicationController
  # Associated with the view that displays after a profile is selected from the search results list
  def show_profile
    @gallery_taggings = GalleryTagging.all
    logger.info("Debugging Star rating:")
    logger.debug(@gallery.inspect)

    if session[:current_user_key].present? || params[:user_key].present?
      user_key_current = params[:user_key] || session[:current_user_key]
      @error = user_key_current.to_s
      puts "sessions current_user_key: #{user_key_current}"

      @user = GeneralInfo.find_by(userKey: user_key_current)

      if @user
        @instagram_photos = @user.instagram_photos # Fetch Instagram photos
        
        if @user.notification
          @notifications_from = @user.notification_from
        end

        if GeneralInfo.exists?(userKey: user_key_current)
          @gallery = Gallery.all
          @general_info = GeneralInfo.find_by(userKey: user_key_current)
          @general_info_attributes = GeneralInfo.attribute_names
          @general_info_values = @general_info.attribute_values
          @login_info = LoginInfo.find_by(userKey: user_key_current)
          @email = @login_info&.email # Use safe navigation operator

          using_default = false

          if session[:current_user_key].present? && params[:user_key].nil?
            @login_user_true = session[:current_user_key]
          end

          @username = @general_info[:first_name]
          @on_Own = session[:current_user_key] == user_key_current

          @is_Admin = GeneralInfo.find_by(userKey: session[:current_user_key])&.is_admin || false
          @addUser = user_key_current
          @job_title = @general_info[:job_name].presence || "Photographer" # Default job title
          using_default = @job_title.blank?

          if GeneralInfo.check_Job?(@job_title) && !using_default
            @attribute_titles = @job_title.constantize.view_Attr()
            @attribute_types = @job_title.constantize.view_Attr_Type()
            @attribute_contents = @general_info_values[:job_attr]
          else
            @attribute_titles = {}
            @attribute_types = []
            @attribute_contents = {}
          end

          # Start of messy profile selection
          case @general_info.specific_profile_id
          when 1
            # Handle Designer specific logic here
          when 2
            # Handle Model specific logic here
          when 3
            # Handle Photographer specific logic here
          else
            puts "Unknown profile type! Profile type given: "
            @profile_type = "Error"
          end

          @followers = @user.get_followers
          @following = @user.get_users_they_follow
          current_user = GeneralInfo.find_by(userKey: session[:current_user_key])
          @currently_following = Follow.exists?(follower: current_user, followee: @user)
          # End of Messy Profile Selection

        else
          # Redirect to login or show a message if no user found
          redirect_to "/login_info/login"
        end
      else
        # Redirect if user not found
        redirect_to "/login_info/login"
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
    @gallery.destroy
    redirect_to '/show_profile'
  end
end
