class Review < ApplicationRecord
  belongs_to :general_info
  belongs_to :gallery
end
