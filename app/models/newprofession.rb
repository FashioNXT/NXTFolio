class Newprofession < ApplicationRecord
  has_many :general_info, dependent: :destroy
end
