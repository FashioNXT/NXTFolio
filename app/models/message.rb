class Message < ApplicationRecord
  belongs_to :general_info
  belongs_to :room
end
