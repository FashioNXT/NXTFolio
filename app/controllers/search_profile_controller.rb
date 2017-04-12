class SearchProfileController < ApplicationController
  #Variable that holds a params/object with all the attributes filled in
  def list
    @search_profiles = SearchProfile.all
  end
   
  def show
    if !(flash[:users].empty?)
      @users = GeneralInfo.where(userKey: flash[:users])
    end
  end
   
  def create
  end
  
  def get_user_keys(array)
    puts "+++++++++++++++IN GET USER KEYS"
    @return_array = Array.new
    array.each do |element,index|
      puts "#{element[:userKey]} is part of the array"
      @return_array.push(element[:userKey])
    end
    
    puts "HEY! THIS IS THE ARRAYS SIZE:" + @return_array.length.to_s
    return @return_array
  end
  
  def search
    
  end
  
  def search_general
    #@general_info = GeneralInfo.new(general_info_search_params)
    @objects = params.except("utf8")
    @objects = @objects.except("button")
    
    @general_queries = GeneralInfo.search @objects
    
    @user_keys = get_user_keys @general_queries
    flash[:users] = @user_keys
    puts "CHECKING FLASH USERS"
    puts @user_keys.length.to_s
    #puts flash[:users].length.to_s
    
    if @objects[:profession] == "1"
      redirect_to :action => 'search_specific_designer'
    elsif @objects[:profession] == "2"
      redirect_to :action => 'search_specific_model'
    elsif @objects[:profession] == "3"
      redirect_to :action => 'search_specific_photographer'
    else
      redirect_to :action => 'show'
    end
  end
  
  def search_specific_designer
    @checkboxes = params[:checkboxes]
    @experience = params[:checkboxes]
    @params_arg = params
    
    @user_objects = SpecificDesigner.search @checkboxes,flash[:users], @experience, @params_arg
    
    flash[:users] = user_objects[:user_key]
    redirect_to :action => 'show'
  end
  
  def search_specific_model
    @params_arg = params
    @checkboxes = params[:checkboxes]
    
    @user_objects = SpecificModel.search flash[:users], @checkboxes, @params_arg
    flash[:users] = @user_objects
    redirect_to :action => 'show'
  end
  
  def search_specific_photographer
    @checkboxes = params[:checkboxes]
    @experience = params[:experience]
    @params_arg = params

    @user_objects = SpecificPhotographer.search @checkboxes,flash[:general_queries],@experience, @params_arg
    
    flash[:users] = @user_objects
    redirect_to :action => 'show'
  end
  
  def search_profile_params
    #passing into create with these keys.
    params.require(:search_profile).permit(:email, :password, :password_confirmation)
  end
  
  def edit
    @search_profile = SearchProfile.find(params[:id])
  end
   
  def update
    @search_profile = SearchProfile.find(params[:id])
    	
    if @search_profile.update_attributes(login_info_param)
      redirect_to :action => 'show', :id => @login_info
    else
      render :action => 'edit'
    end
  end

  def search_profile_param
    params.require(:login_info).permit(:title, :price, :subject_id, :description)
  end
   
  def delete
    SearchProfile.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  # def login
    
  # end
end