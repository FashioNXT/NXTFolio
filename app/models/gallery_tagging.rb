class GalleryTagging < ApplicationRecord
    belongs_to :gallery
    belongs_to :general_info
   
  end