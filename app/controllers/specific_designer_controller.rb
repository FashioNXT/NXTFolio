class SpecificDesignerController < ApplicationController
  def list
    @specific_designers = SpecificDesigner.all
  end
   
  def show
    @specific_designer = SpecificDesigner.find(params[:id])
  end
  
  def search
    
  end
  
  def search_redirect
    @checkboxes = params[:checkboxes]
    @experience = params[:checkboxes]
    @params_arg = params
    
    @user_objects = SpecificDesigner.search @checkboxes,flash[:general_queries], @experience, @params_arg
    
    @user_objects.each do |object|
      @general_info_object = GeneralInfo.find_by(object[:userKey])
      
      @attribute_param = object.attribute_values
      @attribute_param[:first_name] = @general_info_object[:first_name]
      @attribute_param[:last_name] = @general_info_object[:last_name]
      @attribute_param[:gender] = @general_info_object[:gender]
      @attribute_param[:state] = @general_info_object[:state]
      @attribute_param[:profession] = @general_info_object[:profession]
      
    end
    
    redirect_to search_profile_show_path
  end
  
  def prep_show 
   
  end
  
  def new
    @specific_designer = SpecificDesigner.new
  end
   
  def create
    @specific_designer = SpecificDesigner.new(specific_designer_params)
    @genre_str
    if !params[:specific_designer][:allgenres].nil?
      for index in 0 ... params[:specific_designer][:allgenres].size
         @genre_str = @genre_str.to_s + params[:specific_designer][:allgenres][index] + ","
      end
    else
    end
      
    puts session[:current_user_key]
    @specific_designer.genre = @genre_str
    @specific_designer.user_key = session[:current_user_key]

    
     if @specific_designer.save!
       puts "Saved and returning to root"
       redirect_to root_path
     else
       puts "Error saving, returning to new"
       render :action=> 'new'                  # Render the new page again
     end
  end
  
  def specific_designer_params
    params.require(:specific_designer).permit(:genre, {:allgenres => []}, :influencers, :specialties, :compensation, :experience)  #passing into create with these keys.
  end
   
  def edit
    if SpecificDesigner.exists?(:user_key => session[:current_user_key])
      @specific_designer = SpecificDesigner.find_by(user_key: session[:current_user_key])
    else
      redirect_to :action => 'new'
    end
  end
   
  def update
    @specific_designer = SpecificDesigner.find_by(user_key: session[:current_user_key])
    
    if @specific_designer.update_attributes(specific_designer_param)
      redirect_to '/show_profile'
    else
      render :action => 'edit'
    end
  end
  
  def specific_designer_param
    params.require(:specific_designer).permit(:genre, :influencers, :specialties, :compensation, :experience)  
  end
   
  def delete
    SpecificDesigner.find(params[:user_key]).destroy
    redirect_to :action => 'root_path'
  end
end
