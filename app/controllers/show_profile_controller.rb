class ShowProfileController < ApplicationController
  # Associated with the view that displays after a profile is selected from the search results list
  def show_profile
    logger.info("Debuggging Star rating:")
    logger.debug(@gallery.inspect)
    if session[:current_user_key] != nil or params[:user_key] != nil
      user_key_current = params[:user_key] || session[:current_user_key]
      @error = user_key_current.to_s
      puts "sessions current_user_key" + user_key_current.to_s

      @user = GeneralInfo.find_by(userKey: user_key_current)
      
      if @user.notification
        @notifications_from = @user.notification_from
      end

      if GeneralInfo.exists?(:userKey => user_key_current)
        @gallery = Gallery.all
        @general_info = GeneralInfo.find_by(userKey: user_key_current)
        @general_info_attributes = GeneralInfo.attribute_names
        @general_info_values = @general_info.attribute_values
        @login_info = LoginInfo.find_by(userKey: user_key_current)
        if LoginInfo.find_by(userKey: @general_info.userKey)
          @email = LoginInfo.find_by(userKey: @general_info.userKey).email
        end
        #@adminMaker = GeneralInfo.make_admin(params[:room])
        using_default = false

        if session[:current_user_key] != nil and params[:user_key] == nil
          @login_user_true = session[:current_user_key]
        end

        @username = @general_info[:first_name]

        @on_Own = false
        if session[:current_user_key] == user_key_current
          @on_Own = true
        end

        @is_Admin = false
        if GeneralInfo.find_by(userKey: session[:current_user_key]) != nil
          @is_Admin = GeneralInfo.find_by(userKey: session[:current_user_key]).is_admin
          @addUser = user_key_current
        end
        puts @addUser.inspect
        @job_title = @general_info[:job_name]
        if (@job_title == "" || @job_title == nil)
          @job_title = "Photographer"
          using_default = true
        end

        if (GeneralInfo.check_Job?(@job_title)&& !using_default)
          #@attr_titles = @job_title.constantize.view_Attr()
          #@attr_types = @job_title.constantize.view_Attr_Type()
          #@attr_contents = @general_info[:job_attr]

          #@profile_type = @job_title #@general_info_values[:job_name]
          @attribute_titles = @job_title.constantize.view_Attr()
          @attribute_types = @job_title.constantize.view_Attr_Type()
          @attribute_contents = @general_info_values[:job_attr]
        else
          @attribute_titles = Hash.new
          @attribute_types = Array.new
          @attribute_contents = Hash.new
        end
        puts @general_info.inspect
        # Start of messy profile selection
        case @general_info.specific_profile_id
        when 1
          @profile_type = "Designer"
          if SpecificDesigner.exists?(:user_key => user_key_current)
            @specific_designer = SpecificDesigner.find_by(user_key: user_key_current)
            @profile_info = @specific_designer.attribute_values
          else
            @profile_info = nil
          end
        when 2
          @profile_type = "Model"
          if SpecificModel.exists?(:user_key => user_key_current)
            @specific_model = SpecificModel.find_by(user_key: user_key_current)
            @profile_info = @specific_model.attribute_values
          else
            @profile_info = nil
          end
        when 3
          @profile_type = "Photographer"
          if SpecificPhotographer.exists?(:user_key => user_key_current)
            @specific_photographer = SpecificPhotographer.find_by(user_key: user_key_current)
            @profile_info = @specific_photographer.attribute_values
          else
            @profile_info = nil
          end
        else
          puts "Unknown profile type! Profile type given: "
          @profile_type = "Error"
        end
        @followers = @user.get_followers
        @following = @user.get_users_they_follow
        current_user = GeneralInfo.find_by(userKey: session[:current_user_key])
        @currently_following = Follow.exists?(:follower => current_user, :followee => @user)
        # End of Messy Profile Selection
        puts @profile_info.inspect
      else
        #SHOULD SHOW BLANK STUFF!!!!
        @job_title = "No Profile Selected"
        @general_info = GeneralInfo.new
        @general_info_values = Hash.new
        @attribute_titles = Hash.new
        @attribute_types = Array.new
        @attribute_contents = Hash.new
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




end
