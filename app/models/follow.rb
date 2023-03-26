class Follow < ApplicationRecord
  belongs_to :follower, :class_name => :GeneralInfo
  belongs_to :followee, :class_name => :GeneralInfo
end
