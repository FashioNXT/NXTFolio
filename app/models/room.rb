class Room < ApplicationRecord
  validates_uniqueness_of :name
  scope :public_rooms, -> {where(is_private: false)}
  has_many :messages

  def self.create_private_room(users, room_name)
    single_room = Room.create(name: room_name)
    single_room
  end
end
