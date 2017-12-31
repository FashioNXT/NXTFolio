class LoginInfo < ApplicationRecord
  validates_presence_of :email
  validates_presence_of :password
  validates_confirmation_of :password
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates_uniqueness_of :email

  attr_accessor :password_confirmation




  def self.search searchArg

    if searchArg[:email_regex]==nil or searchArg[:email_regex]==''
      return LoginInfo.where("email ILIKE ?",searchArg[:email])
    end

    if searchArg[:email_regex].present? and searchArg[:email_regex]!='' and searchArg[:email].present? and searchArg[:email]!=''
      if searchArg[:email_regex]=='Contains'
        searchArg[:email]="%"+searchArg[:email]+"%"
      else if searchArg[:email_regex]=='Starts With'
             searchArg[:email]=searchArg[:email]+"%"
           else if searchArg[:email_regex]=='Ends With'
                  searchArg[:email]="%"+searchArg[:email]
                else if searchArg[:email_regex]=='Exactly Matches'
                       searchArg[:email]=searchArg[:email]
                     end
                end
           end

      end
    else
      searchArg[:email]="%"
    end
    return LoginInfo.where("email ILIKE ?",searchArg[:email])
  end

end

