class GeneralInfo < ApplicationRecord
    has_one :login_info
    validates_presence_of :first_name
    validates_presence_of :last_name
    validates_presence_of :phone
    validates_presence_of :month_ofbirth
    validates_presence_of :day_ofbirth
    validates_presence_of :year_ofbirth
    validates_presence_of :country
    validates_presence_of :state
    validates_presence_of :city

    validates :phone, numericality: true

    mount_uploader :profile_picture, AvatarUploader
    mount_uploader :cover_picture, CoverUploader
    mount_uploaders :gallery_pictures, GalleryUploader

    geocoded_by :address
    after_validation :geocode

    def address
      [city, state, country].compact.join(", ")
    end

  def self.search searchArg
    query = GeneralInfo.all

    if searchArg[:first_name].present?
      if searchArg[:first_name_regex] == 'Contains'
        searchArg[:first_name] = "%" + searchArg[:first_name] + "%"
      elsif searchArg[:first_name_regex] == 'Starts With'
        searchArg[:first_name] = searchArg[:first_name] + "%"
      elsif searchArg[:first_name_regex] == 'Ends With'
        searchArg[:first_name] = "%" + searchArg[:first_name]
      elsif searchArg[:first_name_regex] == 'Exactly Matches'
        searchArg[:first_name] = searchArg[:first_name]
      end
      query = query.where("first_name ILIKE ?", searchArg[:first_name])
    end

    if searchArg[:last_name].present?
      if searchArg[:last_name_regex]=='Contains'
        searchArg[:last_name]="%"+searchArg[:last_name]+"%"
      elsif searchArg[:last_name_regex]=='Starts With'
        searchArg[:last_name]=searchArg[:last_name]+"%"
      elsif searchArg[:last_name_regex]=='Ends With'
        searchArg[:last_name]="%"+searchArg[:last_name]
      elsif searchArg[:last_name_regex]=='Exactly Matches'
        searchArg[:last_name]=searchArg[:last_name]
      end
      query = query.where("last_name ILIKE ?", searchArg[:last_name])
    end

    if searchArg[:gender].present? and searchArg[:gender] != 'Any'
      query = query.where("gender ILIKE ?", searchArg[:gender])
    end

    if searchArg[:state].present? and searchArg[:state]!=''
      query = query.where("state ILIKE ?", searchArg[:state])
    end

    if searchArg[:city].present? and searchArg[:city]!=''
      if searchArg[:city_regex]=='Contains'
        searchArg[:city]="%"+searchArg[:city]+"%"
      elsif searchArg[:city_regex]=='Starts With'
        searchArg[:city]=searchArg[:city]+"%"
      elsif searchArg[:city_regex]=='Ends With'
        searchArg[:city]="%"+searchArg[:city]
      elsif searchArg[:city_regex]=='Exactly Matches'
        searchArg[:city]=searchArg[:city]
      end
      query = query.where("city ILIKE ?", searchArg[:city])
    end

    if searchArg[:compensation].present? and searchArg[:compensation] != 'Any'
      searchArg[:compensation]="%"+searchArg[:compensation]+"%"
      query = query.where("compensation ILIKE ?", searchArg[:compensation])
    end

    return query
  end
  
  # Sets appearance of profile view attributes
  def attribute_values 
    @attribute_values = Hash.new
    @attribute_values[:name] = "Name: " + self.first_name.to_s + " " + self.last_name.to_s
    @attribute_values[:phone]= "Phone: "+self.phone.to_s
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
