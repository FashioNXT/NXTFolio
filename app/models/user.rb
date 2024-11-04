class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, omniauth_providers: %i[instagram]

#  scope :all_except, -> (user) { where.not(id: user)}

#  def self.new_with_session(params, session)
#    super.tap do |user|
#      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
#        user.email = data["email"] if user.email.blank?
#      end
#    end

#  end

#  def self.from_omniauth(auth)
#    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
#      user.email = auth.info.email
#      user.password = Devise.friendly_token[0,20]
#      user.name = auth.info.name   # assuming the room model has a name
#      user.image = auth.info.image # assuming the room model has an image
      #room.skip_confirmation!
#    end
#  end

def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.username = auth.info.nickname
    user.image_url = auth.info.image
    user.access_token = auth.credentials.token
  end
end

#For instagram-integration
def instagram_photos
  # This method should use the Instagram API to fetch photos
  # Ensure you have the access token stored in the user model
  access_token = self.instagram_access_token
  response = HTTParty.get("https://graph.instagram.com/me/media?fields=id,caption,media_type,media_url,thumbnail_url&access_token=#{access_token}")
  photos = response.parsed_response["data"]
  photos || []
end

end
