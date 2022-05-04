class LoginInfo < ApplicationRecord
  validates_presence_of :email
  validates_presence_of :password
  validates_confirmation_of :password
  validate :password_requirements_are_met #not needed for FB or Google login
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates_uniqueness_of :email
  validates :email, presence: true

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
  def password_requirements_are_met
    rules = {
      " must contain at least one lowercase letter"  => /[a-z]+/,
      " must contain at least one uppercase letter"  => /[A-Z]+/,
      " must contain at least one digit"             => /\d+/,
      " must contain at least one special character" => /[^A-Za-z0-9]+/
    }
  
    rules.each do |message, regex|
      errors.add( :password, message ) unless password.match( regex )
    end
  end

  def validate_pwd
    return validate :password_requirements_are_met #not needed for FB or Google sign up
  end

end

