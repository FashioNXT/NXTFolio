class JobInfo < ApplicationRecord
    
    def self.filterByUserKey userKey 

        #filter by userKey
        @filteredJobInfos = userKey.present? ? JobInfo.where(userKey: userKey) : JobInfo.all
        
    end
end
  
  