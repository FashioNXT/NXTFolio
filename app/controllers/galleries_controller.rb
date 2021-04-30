class GalleriesController < ApplicationController
  def new
    @gallery = Gallery.new
  end

  def create
    @general_info = GeneralInfo.find_by(userKey: session[:current_user_key])
    @gallery = Gallery.new(gallery_params)
    @gallery.update_attribute(:GeneralInfo_id, @general_info.id);

    if @gallery.save
      flash[:notice] = "Project Created"

      redirect_to root_path
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
