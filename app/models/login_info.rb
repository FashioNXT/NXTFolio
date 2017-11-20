class LoginInfo < ApplicationRecord
  validates_presence_of :email
  validates_presence_of :password
  validates_confirmation_of :password
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  
  attr_accessor :password_confirmation
end
