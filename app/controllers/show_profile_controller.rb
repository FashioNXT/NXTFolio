class ShowProfileController < ApplicationController
  
  def show_profile
    if session[:current_user_key] != nil 
      @error = session[:current_user_key].to_s
      puts "sessions current_user_key" + session[:current_user_key].to_s
      
      if GeneralInfo.exists?(:userKey => session[:current_user_key])
        @general_info = GeneralInfo.find_by(userKey: session[:current_user_key])
        @general_info_attributes = GeneralInfo.attribute_names
        @general_info_values = @general_info.attribute_values
        
        case @general_info.specific_profile_id
        when 1
          if SpecificDesigner.exists?(:user_key => session[:current_user_key])
            @specific_designer = SpecificDesigner.find_by(user_key: session[:current_user_key])
            @profile_info = @specific_designer.attribute_values
            @profile_type = "Designer"
          else
            #stuff
          end
        when 2
          if SpecificModel.exists?(:user_key => session[:current_user_key])
            @specific_model = SpecificModel.find_by(user_key: session[:current_user_key])
            @profile_info = @specific_model.attribute_values
            @profile_type = "Model"
          else
            #stuff
          end
        when 3
          if SpecificPhotographer.exists?(:user_key => session[:current_user_key])
            @specific_photographer = SpecificPhotographer.find_by(user_key: session[:current_user_key])
            @profile_info = @specific_photographer.attribute_values
            @profile_type = "Photographer"
          else
            #stuff
          end
        else
          puts "Unknown profile type! Profile type given: " + @general_info.specific_profile_id
          @profile_type = "Error"
        end
      else
        #SHOULD SHOW BLANK STUFF!!!!
        @general_info = GeneralInfo.new
        @general_info_values = Hash.new
        
      end
    else
      puts "No profile!"
      redirect_to "/login_info/login"
    end
  end
  
  # showOthers aka show the profiles from search
  
end
