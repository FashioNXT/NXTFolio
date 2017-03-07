class LoginInfo < ApplicationRecord
    has_one :general_info
    
    validates_presence_of :email
    validates_presence_of :password
end
