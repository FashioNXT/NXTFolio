class SearchProfileController < ApplicationController
  #Variable that holds a params/object with all the attributes filled in
  def list
    @search_profiles = SearchProfile.all
  end
   
  def show
    if !(flash[:user_keys].empty?)
      @users = GeneralInfo.where(userKey: flash[:user_keys])
    else
      flash[:notice] = "No entries matched your search."
    end
  end
   
  def create
  end
  
  def get_user_keys(array)
    puts "IN GET USER KEYS"
    @return_array = Array.new
    array.each do |element,index|
      puts "#{element[:userKey]} is part of the array"
      @return_array.push(element[:userKey])
    end
    
    puts "HEY! THIS IS THE ARRAYS SIZE:" + @return_array.length.to_s
    return @return_array
  end
  
  def search
    #What is this function? It's like an empty function that is needed to render stuff.
  end
  
  def search_general
    #@general_info = GeneralInfo.new(general_info_search_params)
    @search_params = params.except("utf8").except("button")

    #Search for users based on the general info search params. Not by profession though.
    @general_queries = GeneralInfo.search @search_params

    puts "This is the profession id: #{@search_params[:profession]}"
    
    #Get the user keys
    @user_keys = get_user_keys @general_queries
    
    #If no user keys were returned from search, user keys needs to have everyone of the corresponding profession.
    #if @user_keys.empty?
    #  if @search_params[:profession] == "1"
    #    @user_keys = get_user_keys SpecificDesigner.all
    #  elsif @search_params[:profession] == "2"
    #    @user_keys = get_user_keys SpecificModel.all
    #  elsif @search_params[:profession] == "3"
    #    @user_keys = get_user_keys SpecificPhotographer.all
    #  else
    #    @user_keys = get_user_keys GeneralInfo.all
    #  end
    #end
    
    flash[:user_keys] = @user_keys
    

    #Pass which ever users were in the resulting @user_keys to the next tier of searching.
    if @search_params[:profession] == "0"
      redirect_to :action => 'show'
    elsif @search_params[:profession] == "1"
      redirect_to :action => 'search_designer'
    elsif @search_params[:profession] == "2"
      redirect_to :action => 'search_model'
    elsif @search_params[:profession] == "3"
      redirect_to :action => 'search_photographer'
    else
      redirect_to :action => 'show'
    end
  end
  
  def search_designer
    
  end
  
  def search_specific_designer
    @checkboxes = params[:checkboxes]
    @experience = params[:checkboxes]
    @params_arg = params
    
    puts "SpecificDesigner Search "
    @user_keys = SpecificDesigner.search @checkboxes, flash[:user_keys], @experience, @params_arg
    
    puts "SpecificDesigner Search returned #{@user_keys.length} users"
    if @user_keys.empty?
      @user_keys = get_user_keys SpecificDesigner.all
    end
    
    flash[:user_keys] = @user_keys
    redirect_to :action => 'show'
  end
  
  def search_model
    
  end
  
  def search_specific_model
    @params_arg = params
    @checkboxes = params[:checkboxes]
    
    puts "SpecificModel Search "
    #@user_objects = SpecificModel.search flash[:user_keys], @checkboxes, @params_arg
    @user_keys = SpecificModel.search flash[:user_keys], @checkboxes, @params_arg
    
    if @user_keys.empty?
      @user_keys = get_user_keys SpecificModel.all
    end
    
    flash[:user_keys] = @user_keys
    redirect_to :action => 'show'
  end
  
  def search_specific_photographer
    @checkboxes = params[:checkboxes]
    @experience = params[:experience]
    @params_arg = params
    
    @user_keys = SpecificPhotographer.search @checkboxes,flash[:user_keys],@experience, @params_arg
    
    if @user_keys.empty?
      @user_keys = get_user_keys SpecificPhotographer.all
    end
    flash[:user_keys] = @user_keys
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