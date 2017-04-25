class GeneralInfoController < ApplicationController
  @counter = 0
  
  def list
      @general_infos = GeneralInfo.all
  end
  
  def show
     @general_info = GeneralInfo.find(params[:id])
  end
  
  def get_user_keys array
    
    @return_array = Array.new
    array.each do |element,index|
      puts "#{element[:userKey]} is part of the array"
      @return_array.push(element[:userKey])
    end
    
    return @return_array
    
  end
  
  def search_redirect
    #@general_info = GeneralInfo.new(general_info_search_params)
    @objects = params.except("utf8")
    @objects = @objects.except("button")
    
    @general_queries = GeneralInfo.search @objects
    
    puts @general_queries.length
    #puts @general_queries[0][:first_name]
    #puts @general_queries[0][:last_name]
    #puts @general_queries[1][:first_name]
    #puts @general_queries[1][:last_name]
    
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
   
  def new
    @general_info = GeneralInfo.new
  end
  
  #create is called upon profile creation, and routes to which specific profile to create after general info is filled
  def create
    # Check to see if the required params 
    error_statement = ""
    if params[:general_info][:first_name] == ""
      error_statement += "First Name, "
    end
    if params[:general_info][:last_name] == ""
      error_statement += "Last Name, "
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
      
    @general_info = GeneralInfo.new(general_info_params)
    @general_info.userKey = session[:current_user_key] 
    
    #save general info and redirect to specific profile
    if @general_info.save!
      puts @general_info[:specific_profile_id]
      if @general_info[:specific_profile_id] == 1
        redirect_to new_specific_designer_path 
      elsif @general_info[:specific_profile_id] == 2
        redirect_to new_specific_model_path 
      elsif @general_info[:specific_profile_id] == 3
        redirect_to new_specific_photographer_path 
      end
    else
      puts "Failed to save"
      render :action => 'new'
    end
  end
  
  def general_info_params
    params.require(:general_info).permit(:first_name, :last_name, :month_ofbirth, :day_ofbirth, :year_ofbirth, :gender, :country, :state, :city, :compensation, :facebook_link, :linkedIn_link, :instagram_link, :personalWebsite_link, :bio, :specific_profile_id, :profile_picture, :cover_picture, :gallery_pictures => [])
  end
   
  def edit
    if GeneralInfo.exists?(:userKey => session[:current_user_key])
      @general_info = GeneralInfo.find_by(userKey: session[:current_user_key])
    else
      redirect_to :action => 'new'
    end
  end
   
  def update
    @general_info = GeneralInfo.find_by(userKey: session[:current_user_key])
    
    puts "IN UPDATE FUNCTION, GALLERY PICS"
    puts params[:general_info][:gallery_pictures].to_s
    
    puts general_info_update_param[:first_name] + general_info_update_param[:gallery_pictures].to_s
    puts @general_info.first_name
    
    if @general_info.update_attributes(general_info_update_param)
      redirect_to '/show_profile'
    else
      render :action => 'edit'
    end
  end
  
  def general_info_update_param
     params.require(:general_info).permit(:first_name, :last_name, :month_ofbirth, :day_ofbirth, :year_ofbirth, :gender, :country, :state, :city, :compensation, :facebook_link, :linkedIn_link, :instagram_link, :personalWebsite_link, :bio, :profile_picture, :cover_picture, :gallery_pictures => [])
  end
  
  def edit_profession
    if GeneralInfo.exists?(:userKey => session[:current_user_key])
      @general_info = GeneralInfo.find_by(userKey: session[:current_user_key])
    else
      redirect_to :action => 'new'
    end
  end
  
  def update_profession
    @general_info = GeneralInfo.find_by(userKey: session[:current_user_key])
     
    #if @general_info.update_attributes(general_info_update_profession_param)
    if @general_info.update_attribute(specific_profile_id, :specific_profile_id)
      redirect_to '/show_profile'
    else
      render :action => 'edit_profession'
    end
  end
  
  def general_info_update_profession_param
     params.require(:general_info).permit(:specific_profile_id)
  end 
  
  def delete
    GeneralInfo.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def search
    #Take the input from the search view and call the model search functions.
  end
end