class Country < ApplicationRecord
    has_many :states
    has_many :cities, through: :states

    validates :capital, :currency, :region, :latitude, :longitude, :subregion, allow_blank: true, presence: true
    validates :name, :iso3, presence: true
    validates :iso3, uniqueness: true
    # validates :phone_code, format: { with: /\A[\d-]+\z/, message: "must be in the format '[country code]'" }
    # validates :phone_code, allow_blank: true, presence: true
end
