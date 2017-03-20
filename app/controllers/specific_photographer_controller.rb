class SpecificPhotographerController < ApplicationController
  def list
    @specific_photographers = SpecificPhotographer.all
  end
   
  def show
    @specific_photographer = SpecificPhotographer.find(params[:id])
  end
   
  def new
    @specific_photographer = SpecificPhotographer.new
  end
   
  def create
    
    puts specific_photographer_params[:compensation]
    # @specific_photographer = SpecificPhotographer.new(specific_photographer_params)
    
    # if @specific_photographer.save
    #   redirect_to :action => 'list'
    # else
    #   render :action => 'new'
    # end
  end
  
  def specific_photographer_params
    params.require(:specific_photographers).permit(:compensation, :experience, :influencers, :specialties, :genre)
  end
   
  def edit 
    @specific_photographer = SpecificPhotographer.find(params[:id])
  end
   
  def update   
    @specific_photographer = SpecificPhotographer.find(params[:id])
	
    if @specific_photographer.update_attributes(specific_photographer_param)
      redirect_to :action => 'show', :id => @specific_photographer
    else
      render :action => 'edit'
    end
  end

  def specific_photographers_param
    params.require(:specific_photographer).permit(:compensation, :experience, :influencers, :specialties, :genre)
  end
   
  def delete
    SpecificPhotographer.find(params[:id]).destroy
    redirect_to :action => 'list'
  end    
  
end
