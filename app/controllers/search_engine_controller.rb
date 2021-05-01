class SearchEngineController < ApplicationController
    def show
        ############################MY NEW CODE############################################
        @params_args = params #has all the params, such as first name, job_name, gender, country, experience, etc...
        country_f = @params_args["country"]
        state_f = @params_args["state"]
        profession_f = "Designer" #Can be Model, Photographer #change this later
        @filtered_users = GeneralInfo.filterBy country_f, state_f, profession_f

        @filtered_users.each do |user|
            puts "users are: #{user[:first_name]}"
        end

        # Search Users' general info and profession detail for the keyword
        @keyword = "davinci" #"asian" #change this later
        @final_users = []
        @filtered_users.each do |user|
            if profession_f == "Designer"
                specific_user = SpecificDesigner.find_by(user_key: user[:userKey])
            elsif profession_f == "Model"
                specific_user = SpecificModel.find_by(user_key: user[:userKey])
            else
                specific_user = SpecificPhotographer.find_by(user_key: user[:userKey])
            end
            user_data = specific_user.inspect.downcase.gsub(/[^a-z0-9\s]/i, '')
            user_data << user.inspect.downcase.gsub(/[^a-z0-9\s]/i, '')
            puts "User data: #{user_data}"
            if user_data.include? @keyword
                @final_users << user
            end
        end

        puts "Final users are: "
        @final_users.each do |final|
            puts final[:first_name]
        end
        ###################################################################################
    end
end