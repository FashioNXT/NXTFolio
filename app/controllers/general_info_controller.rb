class GeneralInfoController < ApplicationController
  @counter = 0
  
  def list
      @general_infos = GeneralInfo.all
  end
  
  def show
     @general_info = GeneralInfo.find(params[:id])
  end
  
  def get_user_keys array
    puts "+++++++++++++++IN GET USER KEYS"
    
    @return_array = Array.new
    array.each do |element,index|
      puts "#{element[:userKey]} is part of the array"
      @return_array.push(element[:userKey])
    end
    
    puts "HEY! THIS IS THE ARRAYS SIZE:" + @return_array.length.to_s
    return @return_array
  end
  
  def search_redirect
    #@general_info = GeneralInfo.new(general_info_search_params)
    @objects = params.except("utf8")
    @objects = @objects.except("button")
    
    @general_queries = GeneralInfo.search @objects
    
    puts "BBBBBBBBBBBBBBBBBBBB"
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
      puts "ELLLLLLLLLLLSEEEE"
      redirect_to root_path
    end
  end
   
  def new
    @general_info = GeneralInfo.new
  end
  
  def select_next
    @general_info = GeneralInfo.new(general_info_params)
    @general_info.userKey = session[:current_user_key] 
    

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
   
  def create
    @general_info = GeneralInfo.new(general_info_params)
    #if @general_info.save
    #  redirect_to :action => 'list'
    #else
    #  render :action => 'new'
    #end
  end
  
  def general_info_params
     params.require(:general_info).permit(:first_name, :last_name, :month_ofbirth, :day_ofbirth, :year_ofbirth, :gender, :country, :state, :city, :compensation, :facebook_link, :linkedIn_link, :instagram_link, :personalWebsite_link, :bio, :specific_profile_id)
  end
   
  def edit
     @general_info = GeneralInfo.find(params[:id])
  end
   
  def update
    @general_info = GeneralInfo.find(params[:id])
     
    if @general_info.update_attributes(general_info_param)
      redirect_to :action => 'show', :id => @general_info
    else
      render :action => 'edit'
    end
  end
  
  def general_info_param
     params.require(:general_info).permit(:first_name, :last_name, :month_ofbirth, :day_ofbirth, :year_ofbirth, :gender, :country, :state, :city, :compensation, :facebook_link, :linkedIn_link, :instagram_link, :personalWebsite_link, :bio, :specific_profile_id)
  end
   
  def delete
    GeneralInfo.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def search
    #Take the input from the search view and call the model search functions.
  end
end