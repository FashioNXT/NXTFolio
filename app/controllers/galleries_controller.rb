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

    # NXTFolio : Added in Spring 2023 for tagging feature
    @gallery_tagging = @gallery.gallery_taggings

    logger.info("Debugging Average ")

    if @gallery.reviews.blank?
      @average_review=0
    else
      @average_review=@gallery.reviews.average(:rating).round(2)
    end
  end

  # NXTFolio : Added in Spring 2023 for tagging feature
  def create_tagging
    @gallery = Gallery.find_by(id: params[:id])
    tagged_ids = params[:gallery_tagging][:tagged_user_id].reject(&:blank?)
    tagged_ids.each do |tagged_id|
      if GalleryTagging.where(gallery_id: params[:id], general_info_id: tagged_id).empty?
        @gallery_tagging = GalleryTagging.new(gallery_id: params[:id], general_info_id: tagged_id)
        if @gallery_tagging.save
          flash[:notice] = "Tagged User(s) Successfully"
        else
          flash[:alert] = "Failed to Tag User(s)"
        end
      end
    end
    invited_email = params[:gallery_tagging][:invited_email]
    if invited_email
      general_info = LoginInfo.create(email: invited_email, password: SecureRandom.hex(8))
      GalleryTagging.create(gallery_id: @gallery.id, general_info_id: general_info.id, invited_email: invited_email)  
        # send invitation email to collaborator
        # you can use ActionMailer or any other email sending library here
        # for example, you could create a new mailer called "InvitationMailer" and call a method like "invitation_email" to send the email
        InvitationMailer.invitation_email(invited_email).deliver_now
    end


    redirect_to galleries_show_path(:project_key => params[:id])
  end

  
  private

  def gallery_params
    # NXTFolio : Added gallery_tagging in Spring 2023 for tagging feature
    params.require(:gallery).permit(:gallery, :gallery_title, :gallery_description, :ratings, :gallery_totalRate, :gallery_totalRator, :GeneralInfo_id, :gallery_tagging, :gallery_picture => [])
  end

  # NXTFolio : Added in Spring 2023 for tagging feature
  def gallery_tagging_params
    params.require(:gallery_tagging).permit(tagged_user_id: [] )
  end
  
end