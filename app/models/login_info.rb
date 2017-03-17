class LoginInfo < ApplicationRecord
  ### Initial add by Shaeeta and Willer
  has_one :general_info
  
  #self.primary_key = :userKey
  validates_presence_of :email
  validates_presence_of :password
  validates_confirmation_of :password
  
  attr_accessor :password_confirmation
  # attr_protected :password
  
  
  ### Added for BCrypt
  # attr_accessible :email, :password, :password_confirmation

  # attr_accessor :password
  # before_save :encrypt_password
  
  # validates_confirmation_of :password
  # validates_presence_of :password, :on => :create
  # validates_presence_of :email
  # validates_uniqueness_of :email
  
  # def self.authenticate(email, password)
  #   login_info = find_by_email(email)
  #   if login_info && login_info.password_hash == BCrypt::Engine.hash_secret(password, login_info.password_salt)
  #     login_info
  #   else
  #     nil
  #   end
  # end
  
  # def encrypt_password
  #   if password.present?
  #     self.password_salt = BCrypt::Engine.generate_salt
  #     self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  #   end
  # end
end
