class RatingMailer < ApplicationMailer
    def gallery_rating_email(email, owner_name, reviewer_name, project_name, rating)
        @owner_name = owner_name
        @reviewer_name = reviewer_name
        @project_name = project_name
        @rating = rating
        mail(to: email, subject: 'One of your projects has been rated')
    end
end
