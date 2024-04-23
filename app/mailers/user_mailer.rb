class UserMailer < ApplicationMailer
    def welcome_email(userGeneral, userLogin)
        @userG = userGeneral
        @userL = userLogin
        mail(to: @userL["email"], subject: 'Welcome to NXTFolio')
    end
end
