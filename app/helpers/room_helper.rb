module RoomHelper
    def format_room_name(name)
        name.strip.split.map(&:capitalize).join(' ')
    end
end
