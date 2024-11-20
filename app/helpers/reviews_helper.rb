module ReviewsHelper
    def format_rating(rating)
        "★" * rating + "☆" * (5 - rating)
      end
    
      def review_status_class(rating)
        case rating
        when 4..5
          "positive"
        when 3
          "neutral"
        else
          "negative"
        end
      end
    
      
end
