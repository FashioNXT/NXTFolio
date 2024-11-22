class UserActivityDetail < ApplicationRecord
#   belongs_to :general_info
  
#   validates :activity_type, presence: true
#   validates :activity_time, presence: true

  scope :recent, -> { order(created_at: :desc) }
end
