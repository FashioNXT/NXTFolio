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
    
    mount_uploader :profile_picture, AvatarUploader
    mount_uploader :cover_picture, CoverUploader
    mount_uploaders :gallery_pictures, GalleryUploader
    
    
  def self.search searchArg
    #http://stackoverflow.com/questions/35414443/search-through-another-model
    #(2.2) -http://guides.rubyonrails.org/active_record_querying.html#array-conditions 
    #Takes in an array corresponding to certain aspects of general info.
    #joins(:pacient).where("id ILIKE ? OR pacients.name ILIKE ?", "%{search}%", "%{search}%")
    return GeneralInfo.where("first_name ILIKE ? OR last_name ILIKE ? OR gender ILIKE ? OR state ILIKE ? OR city ILIKE ? OR compensation ILIKE ?", searchArg[:first_name], searchArg[:last_name], searchArg[:gender], searchArg[:state], searchArg[:city], searchArg[:compensation])
  end
  
  def attribute_values 
    @attribute_values = Hash.new
    @attribute_values[:name] = "Name: " + self.first_name.to_s + " " + self.last_name.to_s
    @attribute_values[:birthday] = "Birthday: " + self.month_ofbirth.to_s + " / " + self.day_ofbirth.to_s + " / " + self.year_ofbirth.to_s  
    @attribute_values[:gender] = "Gender: " + self.gender.to_s
    @attribute_values[:location] = "Location: " + self.city.to_s + ", " + self.state.to_s + ", " + self.country.to_s
    @attribute_values[:compensation] = "Compensation: " + self.compensation.to_s 
    @attribute_values[:facebook_link] = "Facebook: " + self.facebook_link.to_s
    @attribute_values[:linkedIn_link] = "LinkedIn: " + self.linkedIn_link.to_s
    @attribute_values[:instagram_link] = "Instagram: " + self.instagram_link.to_s
    @attribute_values[:personalWebsite_link] = "Personal website: " + self.personalWebsite_link.to_s
    @attribute_values[:bio] = "Biography: " + self.bio.to_s
    @attribute_values
  end
end
