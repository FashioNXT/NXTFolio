class ShowProfileController < ApplicationController
  
  # showMy aka show my profile using userkey from sessions!! 
  # if no key, don't display link
  def show_designer
    @general_info = GeneralInfo.find_by(userKey: session[:current_user_key])
    puts session[:current_user_key].to_s
    
    if session[:current_user_key].to_s != null
      @specific_designer = SpecificDesigner.find_by(user_key: session[:current_user_key])
    else
      puts "No user key!!!"
    end
    
  end
  
  def show_model
    @general_info = GeneralInfo.find_by(userKey: session[:current_user_key])
    puts session[:current_user_key].to_s
    
    if session[:current_user_key].to_s != nil
      @specific_model = SpecificModel.find_by(user_key: session[:current_user_key])
    else
      puts "No user key!!!"
    end
    
  end
  
  def show_photographer
    @general_info = GeneralInfo.find_by(userKey: session[:current_user_key])
    puts session[:current_user_key].to_s
    
    if session[:current_user_key].to_s != null
      @specific_photographer = SpecificPhotographer.find_by(user_key: session[:current_user_key])
    else
      puts "No user key!!!"
    end
    
  end
  
  def show_profile
    if session[:current_user_key].to_s != nil
      puts session[:current_user_key].to_s
      @general_info = GeneralInfo.find_by(userKey: session[:current_user_key])
      @general_info_attributes = GeneralInfo.attribute_names
      
      #["Designer", "1"],["Model", "2"],["Photographer", "3"]
      case @general_info.specific_profile_id
      when 1
        @specific_designer = SpecificDesigner.find_by(user_key: session[:current_user_key])
        @profile_type = "Designer"
      when 2
        @specific_model = SpecificModel.find_by(user_key: session[:current_user_key])
        @model_info = @specific_model.attribute_values
        @profile_type = "Model"
      when 3
        @specific_photographer = SpecificPhotographer.find_by(user_key: session[:current_user_key])
        @profile_type = "Photographer"
      else
        puts "Unknown profile type! Profile type given: " + @general_info.specific_profile_id
        @profile_type = "Error"
      end
    else
      puts "No user key!!!"
    end
  end
  
  # showOthers aka show the profiles from search
  
end
