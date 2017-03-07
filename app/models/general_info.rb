class GeneralInfo < ApplicationRecord
    belongs_to :login_info
    has_one :specific_designer
    has_one :specific_model
    has_one :specific_photographer
    
    validates_presence_of :first_name
    validates_presence_of :last_name
    validates_presence_of :month_ofbirth
    validates_presence_of :day_ofbirth
    validates_presence_of :year_ofbirth
    validates_presence_of :country
    validates_presence_of :state
    validates_presence_of :city
end
