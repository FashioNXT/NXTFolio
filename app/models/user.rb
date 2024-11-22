class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable

  devise :registerable, # Enables users to register (sign up) and edit their accounts.
       :validatable,  # Adds validations for email and password (e.g., presence, format, length).
       :confirmable,  # Requires email confirmation to activate accounts.
       :omniauthable, # Allows authentication through third-party providers like Facebook and Google.
       omniauth_providers: [:facebook, :google_oauth2] # Specifies the OmniAuth providers used.

   #For password validation
   validates :password, length: {minimum: 8}, if: :password_required?

   #For email validation
   validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

private

def password_required?
  new_record? || password.present
end  

end
