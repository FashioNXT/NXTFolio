class State < ApplicationRecord
  belongs_to :country
  has_many :cities

  validates :latitude, :longitude, allow_blank: true, presence: true
  validates :name, :state_code, presence: true
  validates :state_code, uniqueness: { scope: :country_id, message: "should be unique within a country" }
end
