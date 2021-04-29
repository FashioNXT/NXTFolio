class Gallery < ApplicationRecord
#    belongs_to :general_info

    mount_uploaders :gallery_picture, GalleryUploader
end
