class LoginInfo < ApplicationRecord
    has_one :general_info
    
    #self.primary_key = :userKey
    validates_presence_of :email
    validates_presence_of :password
    
    
end
