class Gallery < ApplicationRecord
#    belongs_to :general_info
    validates_presence_of :gallery_title
    validates_presence_of :gallery_description
    validates_presence_of :gallery_picture
    validates_presence_of :GeneralInfo_id

    mount_uploaders :gallery_picture, GalleryUploader
end
