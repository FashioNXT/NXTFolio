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
    @specific_photographer = SpecificDesigner.new(specific_photographer_params)
    @genre_str
    if !params[:specific_photographer][:allgenres].nil?
      for index in 0 ... params[:specific_photographer][:allgenres].size
         @genre_str = @genre_str.to_s + params[:specific_photographer][:allgenres][index] + ","
      end
    else
    end
      
    #puts @genre_str
    @specific_photographer.genre = @genre_str
    @specific_photographer.user_key = session[:current_user_key] 

    if @specific_photographer.save!
      puts "Saved and returning to root"
      redirect_to root_path
    else
      render :action => 'new'
    end
  end
  
  def specific_photographer_params
    params.require(:specific_photographer).permit(:compensation, {:allgenres => []} , :experience, :influencers, :specialties, :genre)
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
