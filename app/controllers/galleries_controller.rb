class GalleriesController < ApplicationController
  def new
    @gallery = Gallery.new
  end

  #create the project, use params to sent the foreign key to gallery database
  def create
    @general_info = GeneralInfo.find_by(userKey: session[:current_user_key])
    params[:gallery][:GeneralInfo_id] = @general_info.id
    @gallery = Gallery.new(gallery_params)
    
    if @gallery.save
      flash[:notice] = "Project Created"

      redirect_to '/show_profile'
    else
      render 'new'
    end
  end

  def destroy
  end

  def index
  end

  def show
    @gallery = Gallery.find(params[:project_key])
  end

  private
    def gallery_params
      params.require(:gallery).permit(:gallery, :gallery_title, :gallery_description, :gallery_ratings, :gallery_totalRate, :gallery_totalRator, :GeneralInfo_id, :gallery_picture => [])
    end
end
