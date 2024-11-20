module ReviewsHelper
    def format_rating(rating)
        "★" * rating + "☆" * (5 - rating)
      end
    
      
end
