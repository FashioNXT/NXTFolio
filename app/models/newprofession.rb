class Newprofession < ApplicationRecord
  has_many :general_infos, dependent: :destroy
end
