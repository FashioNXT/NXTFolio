class SpecificModelController < ApplicationController
  def list
    @specific_models = SpecificModel.all
  end
   
  def show
    @specific_model = SpecificModel.find(params[:id])
  end
   
  def new
    @specific_model = SpecificModel.new
  end
   
  def create
    @specific_model = SpecificModel.new(specific_model_param)
    @genre_str
    if !params[:specific_model][:allgenres].nil?
      for index in 0 ... params[:specific_model][:allgenres].size
         @genre_str = @genre_str.to_s + params[:specific_model][:allgenres][index] + ","
      end
    else
    end
    
    #puts @genre_str
    @specific_model.genre = genre_str
    @specific_model.userKey = session[:current_user_key] 
    
    if @specific_model.save
      root_path and return
    else
      render :action => 'new'
    end
  end
  
  def specific_model_params
    params.require(:specific_models).permit(:height_feet, :height_inches, :bust, :waist, :hips, :cups, :shoe_size, :dress_size, :hair_color, :eye_color, :ethnicity, :skin_color, :shoot_nudes, :tattoos, :piercings, :experience, :genre, {:allgenres => []})
  end
   
  def edit
    @specific_model = SpecificModel.find(params[:id])
  end
  
  def specific_model_param
    params.require(:specific_model).permit(:height_feet, :height_inches, :bust, :waist, :hips, :cups, :shoe_size, :dress_size, :hair_color, :eye_color, :ethnicity, :skin_color, :shoot_nudes, :tattoos, :piercings, :experience, :genre, {:allgenres => []})
  end
   
  def update
    @specific_model = SpecificModel.find(params[:id])
    
    if @specific_model.update_attributes(specific_model_param)
      redirect_to :action => 'show', :id => @specific_model
    else
      render :action => 'edit'
    end
  end
  
  def delete
    SpecificModel.find(params[:id]).destroy
    redirect_to :action => 'list'
  end   
end
