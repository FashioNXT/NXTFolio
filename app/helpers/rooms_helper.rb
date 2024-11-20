module RoomsHelper
    def format_room_number(number)
        "Room #{number.to_s.rjust(3, '0')}"
      end
    
     
end
