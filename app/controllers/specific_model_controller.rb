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
    puts "Hello, I'm executing"
    # if @specific_model.save
    #   redirect_to :action => 'list'
    # else
    #   render :action => 'new'
    # end
  end
  
  def specific_model_params
    params.require(:specific_models).permit(:height_feet, :height_inches, :bust, :waist, :hips, :cups, :shoe_size, :dress_size, :hair_color, :eye_color, :ethnicity, :skin_color, :shoot_nudes, :tattoos, :piercings, :experience, :genre, :test)
  end
   
  def edit
    @specific_model = SpecificModel.find(params[:id])
  end
  
  def specific_model_param
    params.require(:specific_model).permit(:height_feet, :height_inches, :bust, :waist, :hips, :cups, :shoe_size, :dress_size, :hair_color, :eye_color, :ethnicity, :skin_color, :shoot_nudes, :tattoos, :piercings, :experience, :genre, :test)
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
