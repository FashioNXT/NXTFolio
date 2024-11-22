module RoomsHelper
    def format_room_number(number)
    "Room #{number.to_s.rjust(3, '0')}"
  end

  def room_capacity_label(capacity)
    case capacity
    when 0..5
      "Small"
    when 6..15
      "Medium"
    else
      "Large"
    end
  end

  def room_availability_status(available)
    available ? "Available" : "Occupied"
  end
end
