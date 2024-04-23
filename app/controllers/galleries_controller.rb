class GalleriesController < ApplicationController
  def new
    @gallery = Gallery.new
  end

  #create the project, use params to sent the foreign key to gallery database
  def create
    @general_info = GeneralInfo.find_by(userKey: session[:current_user_key])
    params[:gallery][:GeneralInfo_id] = @general_info.id
    @gallery = Gallery.new(gallery_params)
    if @gallery.gallery_picture.length == 0
      flash.now[:error] = "You should add at least 1 image!"
      render 'new'

    elsif @gallery.gallery_picture.length > 5 
      flash.now[:error] = "You can't add more than 5 images!"
      render 'new'

    
    elsif @gallery.save
      flash[:notice] = "Project Created"

      redirect_to '/show_profile'
    else
      render 'new'
    end
  end

  # def edit
  #   @gallery = Gallery.find(params[:id])
  #   if @gallery.update(gallery_params)
  #     redirect_to @gallery
  #   else
  #     render 'edit'
  #   end
  # end
  # def edit
  #   @gallery = Gallery.find(params[:id])
  # end

  # def update
  #   #@gallery = Gallery.find(params[:id])
  #   @gallery = Gallery.find(35)
  #   if @gallery.update(gallery_params)
  #     redirect_to @gallery
  #   else
  #     render 'edit'
  #   end
  # end


  # def update
  #   @gallery = Gallery.find(params[:id])
  #   if @gallery.update(gallery_params)
  #     redirect_to @gallery
  #   else
  #     render 'edit'
  #   end
  # end

  def update
    @gallery = Gallery.find(params[:id])
    # for item in @gallery.test_picture do
    #   @gallery.gallery_picture.push(item)
    # end
    #@gallery.save!
    #puts(@gallery.test_picture.length)
    #puts("!!!!!!!")
    if @gallery.update(gallery_params)
      @gallery.save
      if @gallery.test_picture.length == 0
        flash.now[:error] = "Add at least 1 image!"
        render 'edit'
      else
        flash[:notice] = "Images uploaded!"
        redirect_to edit_gallery_path(params[:id])
      end
    else
      render 'edit'
    end
  end

  


  def destroy
    #logger.debug(@gallery_picture.inspect)
    #remove_image_at_index(params[ :gallery_picture].to_i)
    #remove_file(params[ :gallery_picture])
    @gallery = Gallery.find(params[:id])
    @gallery.destroy
    redirect_to galleries_path
  end
# spring2023 delete single image in the gallery
  def delete
    @gallery = Gallery.find(params[:id])
    index_str = params[:idx]
    index = (index_str).to_i
    #puts(index.to_s + "!!!!!!!!!!")
    img = @gallery.gallery_picture[index]
    @gallery.gallery_picture.delete_at(index)
    if img.in?(@gallery.test_picture)
      @gallery.test_picture.delete(img)
    end
    @gallery.save
  end


# spring2023 add images to gallery
  def transfer
    @gallery = Gallery.find(params[:id])
    limit = 5 - @gallery.gallery_picture.length
    #puts(limit)
    if @gallery.test_picture.length == 0
      render 'edit'
    elsif @gallery.test_picture.length > limit
      puts("wrong!!!!!!!!!!!!")
      flash.now[:error] = "You can not have more than 5 images in a gallery!"
      @gallery.test_picture.clear
      @gallery.save
      render 'edit'
    else
     #puts("transfer running!!!!!!!!!!!")
     puts("success!!!!!!!!!!!!")
      added = @gallery.test_picture
      @gallery.gallery_picture += added

      @gallery.test_picture.clear
      @gallery.save
    end
  end


  #def remove_file(gallery_picture)
    #File.delete(gallery_picture)
  #end

  #def set_gallery
    #@gallery = Gallery.find(params[:gallery_id])
  #end

  #def remove_image_at_index(index)
  #remain_images = gallery_params # copy the array
  #deleted_image = remain_gallery_picture.delete_at(index) # delete the target image
  #deleted_image.try(:remove!) # delete image from S3
  #@gallery.gallery_pictures = remain_images # re-assign back
  #end

  # def remove_image(image)
  #   @gallery.gallery_picture.delete(image)
  #   @gallery.save
  # end

  # def remove_image
  #   gallery = Gallery.find(params[:gallery_id])
  #   image = gallery.images.find(params[:id])
  #   image.destroy
  #   redirect_to gallery, notice: 'Image was successfully removed.'
  # end





  #def index
  #end

  def show

    puts (params.inspect)
    #@gallery = Gallery.find(params[:project_key])
    @gallery = Gallery.find(params[:id])


    # NXTFolio : Added in Spring 2023 for tagging feature
    @gallery_tagging = @gallery.gallery_taggings
    
    logger.info("Debugging Average ")
    current_user =  GeneralInfo.find_by(userKey: session[:current_user_key])
    if current_user
      current_user_id = current_user.id
      @collab_count = Collaboration.where(general_info_id: current_user_id).count

      print("Users " + current_user_id.to_s + " collaborated with: ")
      print(@collab_count)
    end

    if @gallery.reviews.blank?
      @average_review=0
    else
      @average_review=@gallery.reviews.average(:rating).round(2)
    end
  end

  # NXTFolio : Added function in Spring 2023 for tagging feature
  def create_tagging
    @gallery = Gallery.find_by(id: params[:id])
    tagged_ids = params[:gallery_tagging][:tagged_user_id].split(",").reject(&:blank?)
    puts tagged_ids
    tagged_ids.each do |tagged_id|
      if GalleryTagging.where(gallery_id: params[:id], general_info_id: tagged_id).empty?
        @gallery_tagging = GalleryTagging.new(gallery_id: params[:id], general_info_id: tagged_id)
        if @gallery_tagging.save
          flash[:notice] = "Tagged User(s) Successfully"
        else
          flash[:alert] = "Failed to Tag User(s)"
        end
      end
      
      current_user_id = GeneralInfo.find_by(userKey: session[:current_user_key]).id
      print("Making collaboration between: " + current_user_id.to_s + " and " + tagged_id.to_s)

      if Collaboration.where(general_info_id: current_user_id, collaborator_id: tagged_id).empty?
        @collab = Collaboration.new(general_info_id: current_user_id, collaborator_id: tagged_id)
        if @collab.save
          flash[:notice] = "Collaborations saved Successfully"
        else
          flash[:alert] = "Failed to save Collaboration"
        end
      end
      if Collaboration.where(general_info_id: tagged_id, collaborator_id: current_user_id).empty?
        @collab = Collaboration.new(general_info_id: tagged_id, collaborator_id: current_user_id)
        if @collab.save
          flash[:notice] = "Collaborations saved Successfully"
        else
          flash[:alert] = "Failed to save Collaboration"
        end
      end
    end
    invited_email = params[:gallery_tagging][:invited_email]
    if invited_email.present?
      inviter_name = GeneralInfo.find_by(id:@gallery.GeneralInfo_id).first_name + " " + GeneralInfo.find_by(id:@gallery.GeneralInfo_id).last_name
      invited_name = GeneralInfo.find_by(emailaddr: invited_email).first_name + " " + GeneralInfo.find_by(emailaddr: invited_email).last_name
      project_name = @gallery.gallery_title
      project_key = params[:id]
      InvitationMailer.invitation_email(invited_email,invited_name,inviter_name,project_name,project_key).deliver_now
    end
    redirect_to '/show_profile'
    
  end
  def destroy_tagging
    @gallery = Gallery.find(params[:gallery_id])
    @tagging = @gallery.gallery_taggings.find(params[:id])
    @tagging.destroy
    flash[:notice] = 'Collaborator removed successfully'
    redirect_to @gallery
  end

  # Fall 2023: Piyush Sharan: Add Comments
  def add_comment
    @gallery = Gallery.find(params[:id])
  end
  
  # Fall 2023: Piyush Sharan: Post Comments
  def post_comment
    @gallery = Gallery.find(params[:id])
    @comment = @gallery.comments.build(comment_params)
    @user = GeneralInfo.find_by(userKey: session[:current_user_key])
    @comment.comment_by = @user.first_name + " " + @user.last_name
    # Fall 2023: Vishnuvasan: Added check for empty comment
    if @comment.body.blank?
      flash[:error] = "Comment cannot be empty."
      redirect_to gallery_path(@gallery)
    else
      if @comment.save
        flash[:notice] = "Comment added successfully."
        redirect_to gallery_path(@gallery)
      else
        flash.now[:alert] = "Failed to add comment."
        render 'add_comment'
      end
    end
  end

  def add_tag
    @gallery = Gallery.find_by(id: params[:id])
  end

  def create_tag
    @gallery = Gallery.find_by(id: params[:id])
    @tag = Tag.new(gallery_id: params[:id], body: params[:tag][:body])
    if @tag.save
      redirect_to gallery_path(@gallery)
    else
      render 'add_tag'
    end
  end

  private

  def gallery_params
    # NXTFolio : Added gallery_tagging in Spring 2023 for tagging feature
    params.require(:gallery).permit(:id,:gallery, :gallery_title, :gallery_description, :ratings, :gallery_totalRate, :gallery_totalRator, :GeneralInfo_id, :gallery_tagging, :gallery_picture => [], :remove_image_ids => [], :test_picture => [])
  end

  # NXTFolio : Added in Spring 2023 for tagging feature
  def gallery_tagging_params
    params.require(:gallery_tagging).permit(tagged_user_id: [] )
  end
  
  # Fall 2023: To add Comments
  def comment_params
    params.require(:comment).permit(:body)
  end
end