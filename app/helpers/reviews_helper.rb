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
    
      def truncate_review(review, length)
        if review.length > length
            review[0...(length - 3)].strip + "..."
          else
            review
          end
      end
end
