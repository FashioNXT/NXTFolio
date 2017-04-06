class GeneralInfo < ApplicationRecord
    #belongs_to :login_info
    #has_one :specific_designer
    #has_one :specific_model
    #has_one :specific_photographer
    
    validates_presence_of :first_name
    validates_presence_of :last_name
    validates_presence_of :month_ofbirth
    validates_presence_of :day_ofbirth
    validates_presence_of :year_ofbirth
    validates_presence_of :country
    validates_presence_of :state
    validates_presence_of :city
    
  def self.search searchArg
    #http://stackoverflow.com/questions/35414443/search-through-another-model
    #(2.2) -http://guides.rubyonrails.org/active_record_querying.html#array-conditions 
    #Takes in an array corresponding to certain aspects of general info.
    #joins(:pacient).where("id ILIKE ? OR pacients.name ILIKE ?", "%{search}%", "%{search}%")
    return GeneralInfo.where("first_name ILIKE ? OR last_name ILIKE ? OR gender ILIKE ? OR state ILIKE ? OR city ILIKE ? OR compensation ILIKE ?", searchArg[:first_name], searchArg[:last_name], searchArg[:gender], searchArg[:state], searchArg[:city], searchArg[:compensation])
  end
end
