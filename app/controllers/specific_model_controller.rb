class SpecificModelController < ApplicationController
  def list
    @specific_models = SpecificModel.all
  end
   
  def show
    @specific_model = SpecificModel.find(params[:id])
  end
  
  def search
    
  end
  
  def search_redirect
    @params_arg = params
    @checkboxes = params[:checkboxes]
    
    @user_objects = SpecificModel.search flash[:general_queries], @checkboxes, @params_arg
    @attribute_param_array = Array.new
      
    @user_objects.each do |specific_model_obj|
      @general_info_object = GeneralInfo.find_by(userKey: specific_model_obj[:user_key])
      
      @attribute_param = specific_model_obj.attribute_values
      @attribute_param[:user_key] = specific_model_obj[:user_key]
      @attribute_param[:first_name] = @general_info_object[:first_name]
      @attribute_param[:last_name] = @general_info_object[:last_name]
      @attribute_param[:gender] = @general_info_object[:gender]
      @attribute_param[:state] = @general_info_object[:state]
      @attribute_param[:profession] = @general_info_object[:profession]
      
      puts "++++++++++++++++++++++++++++++"
      puts @attribute_param[:first_name]
      puts @attribute_param[:last_name]
      puts @attribute_param[:gender]
      puts @attribute_param[:state]
      puts @attribute_param[:profession]
      @attribute_param_array.push(@attribute_param)
    end
    
    puts "\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\"
    #flash[:attribute_param_array] = @attribute_param_array
    puts @attribute_param_array.size
    redirect_to search_model_show_path
  end
   
  def new
    @specific_model = SpecificModel.new
  end
   
  def create
    @specific_model = SpecificModel.new(specific_model_param)
    @genre_str = ""
    if !params[:specific_model][:allgenres].nil?
      for index in 0 ... params[:specific_model][:allgenres].size
         @genre_str = @genre_str.to_s + params[:specific_model][:allgenres][index] + ","
      end
    else
    end
    
    #puts @genre_str
    @specific_model.genre = @genre_str
    @specific_model.user_key = session[:current_user_key] 
    
    if @specific_model.save!
      puts "Saved and returning to root"
      redirect_to root_path
    else
      render :action => 'new'
    end
  end
  
  def specific_model_params
    params.require(:specific_models).permit(:height_feet, :height_inches, :bust, :waist, :hips, :cups, :shoe_size, :dress_size, :hair_color, :eye_color, :ethnicity, :skin_color, :shoot_nudes, :tattoos, :piercings, :experience, :genre, {:allgenres => []})
  end
   
  def edit
    if SpecificModel.exists?(:user_key => session[:current_user_key])
      @specific_model = SpecificModel.find_by(user_key: session[:current_user_key])
    else
      redirect_to :action => 'new'
    end
  end
   
  def update
    @specific_model = SpecificModel.find_by(user_key: session[:current_user_key])
    
    if @specific_model.update_attributes(specific_model_param)
      redirect_to '/show_profile'
    else
      render :action => 'edit'
    end
  end
  
  def specific_model_param
    params.require(:specific_model).permit(:height_feet, :height_inches, :bust, :waist, :hips, :cups, :shoe_size, :dress_size, :hair_color, :eye_color, :ethnicity, :skin_color, :shoot_nudes, :tattoos, :piercings, :experience, :genre, {:allgenres => []})
  end
  
  def delete
    SpecificModel.find(params[:id]).destroy
    redirect_to :action => 'list'
  end   
end
