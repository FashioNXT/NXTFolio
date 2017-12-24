class GeneralInfo < ApplicationRecord
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
    # http://stackoverflow.com/questions/35414443/search-through-another-model
    # (2.2) -http://guides.rubyonrails.org/active_record_querying.html#array-conditions 
    # Takes in an array corresponding to certain aspects of general info.
    # joins(:pacient).where("id ILIKE ? OR pacients.name ILIKE ?", "%{search}%", "%{search}%")

   # "first_name ILIKE ? AND last_name ILIKE ? AND gender ILIKE ? AND state ILIKE ? AND city ILIKE ? AND compensation ILIKE ?",

        #searchArg[:first_name], searchArg[:last_name], searchArg[:gender], searchArg[:state], searchArg[:city], searchArg[:compensation]

    query=""

    if searchArg[:first_name].present?
      searchArg[:first_name]="%"+searchArg[:first_name]+"%"
    else
      searchArg[:first_name]="%"
    end


    if searchArg[:last_name].present?
      searchArg[:last_name]="%"+searchArg[:last_name]+"%"
    else
      searchArg[:last_name]="%"
    end


    if searchArg[:gender].present?
      if searchArg[:gender]=='any' or searchArg[:gender]=='Any'
        searchArg[:gender]="%"
      else
        searchArg[:gender]="%"+searchArg[:gender]+"%"
      end
    else
      searchArg[:gender]="%"
    end


    if searchArg[:state].present?
      searchArg[:state]="%"+searchArg[:state]+"%"
    else
      searchArg[:state]="%"
    end


    if searchArg[:city].present?
      searchArg[:city]="%"+searchArg[:city]+"%"
    else
      searchArg[:city]="%"
    end

    if searchArg[:compensation].present?
      if searchArg[:compensation]=='any' or searchArg[:compensation]=='Any'
        searchArg[:compensation]="%"
      else
        searchArg[:compensation]="%"+searchArg[:compensation]+"%"
      end
    else
      searchArg[:compensation]="%"
    end

    return GeneralInfo.where("first_name ILIKE ?
                              AND last_name ILIKE ?
                              AND gender ILIKE ?
                              AND state ILIKE ?
                              AND city ILIKE ?
                              AND compensation ILIKE ?",
                              searchArg[:first_name],
                              searchArg[:last_name],
                              searchArg[:gender],
                              searchArg[:state],
                              searchArg[:city],
                              searchArg[:compensation])
  end
  
  # Sets appearance of profile view attributes
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
