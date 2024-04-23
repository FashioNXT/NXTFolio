
class Gallery < ApplicationRecord
#It is weired that I need to block the line below to make the function work.
    belongs_to :general_info, optional: true
    has_many :reviews

    # NXTFolio : Added in Spring 2023 for tagging feature.
    has_many :gallery_taggings, dependent: :destroy
    has_many :tagged_users, through: :gallery_taggings, source: :general_info

    validates_presence_of :gallery_title
    validates_presence_of :gallery_description
    validates_presence_of :gallery_picture
    validates_presence_of :GeneralInfo_id
    mount_uploaders :gallery_picture, GalleryUploader

    mount_uploaders :test_picture, GalleryUploader

    # NXTFolio: Added in Fall 2023 : Piyush Sharan
    has_many :comments, dependent: :destroy

    #NXTFolio: Added in Winter 2024: Sai Chandhrasekhar
    has_many :tags, dependent: :destroy

    def get_similar_galleries
        all_galleries = Gallery.all
        similar_galleries = {}
        all_galleries.each do |gallery|
            if gallery.GeneralInfo_id != self.GeneralInfo_id
                my_tags = self.tags.pluck(:body)
                other_tags = gallery.tags.pluck(:body)
                shared_tags = my_tags.intersection(other_tags)
                all_tags = my_tags + other_tags
                similarity = shared_tags.length.to_f / all_tags.length.to_f 
                similar_galleries[gallery] = similarity 
            end
        end
        similar_galleries.reject! { |key, val| val.nan? }
        Hash[similar_galleries.sort_by { |key, val| val }.reverse]
    end

end
    