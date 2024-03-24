class Review < ApplicationRecord
  belongs_to :general_info
  belongs_to :gallery

  validates_presence_of :gallery_id
  validates_presence_of :rating
end
