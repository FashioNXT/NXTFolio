class SearchEngineController < ApplicationController

    def show
        @searchQuery = params[:Initkey]
        if session[:current_user_key]
            current_user = GeneralInfo.find_by(userKey: session[:current_user_key])
            @username = current_user[:first_name]
        end
    end

    def search
        if session[:current_user_key]
            current_user = GeneralInfo.find_by(userKey: session[:current_user_key])
            @username = current_user[:first_name]
        end

        @params_args = params #parameters passed from view
        country = "United States" # change country to industry later (need to modify filterBy as well)
        state = @params_args[:State]
        city= @params_args[:City]


        @stateInfo=state
        profession = @params_args[:Profession]
        @filtered_users = GeneralInfo.filterBy state, profession, city

        #puts "Filtered users are: "
        #@filtered_users.each do |user|
        #    puts user[:first_name]
        #end

        # Search Users' general info and profession detail for the keyword
        @keyword = @params_args[:Keyword]
        @EnteredKw=@keyword
        @keyword= @keyword.downcase
        @keywordArr=@keyword.split(" ")
        @final_users = []
        if @keyword.present?
            @filtered_users.each do |user|
                if user[:job_name] == "Designer"
                    specific_user = SpecificDesigner.find_by(user_key: user[:userKey])
                elsif user[:job_name] == "Model"
                    specific_user = SpecificModel.find_by(user_key: user[:userKey])
                else
                    specific_user = SpecificPhotographer.find_by(user_key: user[:userKey])
                end
                user_data = specific_user.inspect.downcase.gsub(/[^a-z0-9\s]/i, '')

                user_data << user.inspect.downcase.gsub(/[^a-z0-9\s]/i, '')

                userdataString=user_data.split(" ")

                #previous check --user_data.include? @keyword
                if (userdataString & @keywordArr).any?
                    logger.info("Tanvir Checking")
                    logger.debug(user_data.inspect)
                    @final_users << user
                end
            end
        else
            @final_users = @filtered_users
        end

        puts "Final users are: "
        @final_users.each do |final|
            puts final
        end

    end
end