module MessagesHelper
    def format_message_time(time)
        time.strftime("%l:%M %p").strip
      end
    
      def truncate_message(message, length)
        if message.length > length
            message[0...(length - 3)] + "..."
          else
            message
        end
      end
    
      def message_status_class(is_read)
        is_read ? "read" : "unread"
      end
end
