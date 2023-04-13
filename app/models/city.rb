class City < ApplicationRecord
  belongs_to :state
  has_one :country, through: :state

  validates :latitude, :longitude, allow_blank: true, presence: true
  validates :name, presence: true
  # validates :name, uniqueness: { scope: :state_id, message: "should be unique within a state" }
end
