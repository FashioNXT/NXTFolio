class GalleryTagging < ApplicationRecord
    belongs_to :gallery
    belongs_to :general_info
   
    # def destroy
    #   @gallery_tagging = GalleryTagging.find(params[:id])
    #   @gallery_tagging.destroy
    #   redirect_to :back, notice: 'Collaborator removed successfully.'
    # end
    
  end