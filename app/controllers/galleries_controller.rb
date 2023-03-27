class GalleriesController < ApplicationController
  def new
    @gallery = Gallery.new
  end

  #create the project, use params to sent the foreign key to gallery database
  def create
    @general_info = GeneralInfo.find_by(userKey: session[:current_user_key])
    params[:gallery][:GeneralInfo_id] = @general_info.id
    @gallery = Gallery.new(gallery_params)
    
    if @gallery.save!
      flash[:notice] = "Project Created"

      redirect_to '/show_profile'
    else
      render 'new'
    end
  end


  def destroy
    #logger.debug(@gallery_picture.inspect)
    #remove_image_at_index(params[ :gallery_picture].to_i)
    puts("running gallery destroy!!!")
    #remove_file(params[ :gallery_picture])
    @gallery = Gallery.find(params[:id])
    @gallery.destroy
    redirect_to galleries_path
  end

  def remove_file(gallery_picture)
    File.delete(gallery_picture)
  end

  def set_gallery
    @gallery = Gallery.find(params[:gallery_id])
  end

  #def remove_image_at_index(index)
  #remain_images = gallery_params # copy the array
  #deleted_image = remain_gallery_picture.delete_at(index) # delete the target image
  #deleted_image.try(:remove!) # delete image from S3
  #@gallery.gallery_pictures = remain_images # re-assign back
  #end

  def index
  end

  def show
    @gallery = Gallery.find(params[:project_key])

    # Ayushri
    @gallery_tagging = @gallery.gallery_taggings

    logger.info("Debugging Average ")

    if @gallery.reviews.blank?
      @average_review=0
    else
      @average_review=@gallery.reviews.average(:rating).round(2)
    end
  end

  # Ayushri
  def create_tagging
    puts "Parameters are :"
    puts params.inspect
    @gallery = Gallery.find_by(id: params[:id])
    puts "Gallery is :"
    puts @gallery.inspect
    @gallery_tagging = @gallery.gallery_taggings.build(gallery_tagging_params)
    #@gallery_tagging = GalleryTagging.new(gallery_tagging_params)
    @gallery_tagging.general_info_id = @gallery.GeneralInfo_id
    puts "Gallery taggig is :"
    puts @gallery_tagging.inspect
    tagged_ids = params[:gallery_tagging][:tagged_user_id].reject(&:blank?)
    tagged_ids.each do |tagged_id|
      puts tagged_id
      @gallery_tagging = GalleryTagging.new
      @gallery_tagging.gallery_id = params[:id]
      @gallery_tagging.general_info_id = tagged_id

    if @gallery_tagging.save!
      flash[:notice] = "Tagged User(s) Successfully"
      puts "success"
    else
      flash[:alert] = "Failed to Tag User(s)"
      puts "failure"
    end
  end
    redirect_to galleries_show_path(:project_key => params[:id])
  end

  
  private

  def gallery_params
    # Ayushri
    params.require(:gallery).permit(:gallery, :gallery_title, :gallery_description, :ratings, :gallery_totalRate, :gallery_totalRator, :GeneralInfo_id, :gallery_tagging, :gallery_picture => [])
  end

  # Ayushri
  def gallery_tagging_params
    #params.require(:gallery_tagging).permit(tagged_user_id: [])
    params.require(:gallery_tagging).permit(tagged_user_id: [] )
  end
  
end