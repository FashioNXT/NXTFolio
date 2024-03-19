class JobInfo < ApplicationRecord
    
    validates_presence_of :country
    validates_presence_of :city
    validates_presence_of :state
    validates_presence_of :profession

    def self.filterByUserKey userKey

        #filter by userKey
        @filteredJobInfos = userKey.present? ? JobInfo.where(userKey: userKey) : JobInfo.all
        
    end

    def self.filterByFeature category, profession, country, state, city 

        # @filteredJobInfos = category.present? ? JobInfo.where(category: category) : JobInfo.all
        # @filteredJobInfos = profession.present? ? @filteredJobInfos.where(profession: profession) : @filteredJobInfos

        @filteredJobInfos = profession.present? ? JobInfo.where(profession: profession) : JobInfo.all
        @filteredJobInfos = country.present? ? @filteredJobInfos.where(country: country) : @filteredJobInfos
        @filteredJobInfos = state.present? ? @filteredJobInfos.where(state: state) : @filteredJobInfos
        @filteredJobInfos = city.present? ? @filteredJobInfos.where(city: city) : @filteredJobInfos

        return @filteredJobInfos
    end
end
  
  