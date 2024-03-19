require 'set'
class SearchEngineController < ApplicationController

    def show
        @searchQuery = params[:Initkey]
        if session[:current_user_key]
            current_user = GeneralInfo.find_by(userKey: session[:current_user_key])
            @username = current_user[:first_name]
        end
    end

    # spring 2023 keywords matching
    # def filter_words(string)
    #     file = File.open("app/assets/stop_words_english.txt", "r")
    #     text = file.read
    #     file.close
    #     stopwords_list = text.split

    #     res = Set.new
    #     for word in string.split(/\W+/) do
    #         if !stopwords_list.include?(word.downcase.gsub(/\W+/, ''))
    #             res.add(word.downcase.gsub(/\W+/, ''))
    #         end
    #     end
    #     return res
    # end

    def search
        if session[:current_user_key]
            current_user = GeneralInfo.find_by(userKey: session[:current_user_key])
            @username = current_user[:first_name]
        end
        file = File.open("app/assets/stop_words_english.txt", "r")
        text = file.read
        file.close
        stopwords_list = text.split

        @params_args = params #parameters passed from view
        #country = "United States" # change country to industry later (need to modify filterBy as well)
        country =@params_args[:Country]
        state = @params_args[:State]
        city= @params_args[:city]






        @stateInfo=state
        profession = @params_args[:Profession]
        @filtered_users = GeneralInfo.filterBy country, state, profession, city

        #puts "Filtered users are: "
        #@filtered_users.each do |room|
        #    puts room[:first_name]
        #end

        # Search Users' general info and profession detail for the keyword
        @keyword = @params_args[:Keyword]
        puts city  
        @EnteredKw=@keyword
        if @keyword != nil
            @keyword= @keyword.downcase
        end

        #cata =

        # if country == nil && state == nil && city == nil && profession == nil && @keyword == nil
        #     puts('empty!!!!!!!')
        #     render 'search_engine/show?utf8=✓&Initkey='
        # end

        if country.nil?  && state.nil?  && city.nil?  && profession.nil?  && @keyword.nil?
            #'search_engine/show?'
            @final_users = []
            render 'search_engine/show'
        end

        #@keywordArr=@keyword.split(" ")
        @final_users = []
        # if @keyword.present?
        #     @filtered_users.each do |user|
        #         if user[:job_name] == "Designer"
        #             specific_user = SpecificDesigner.find_by(user_key: user[:userKey])
        #         elsif user[:job_name] == "Model"
        #             specific_user = SpecificModel.find_by(user_key: user[:userKey])
        #         else
        #             specific_user = SpecificPhotographer.find_by(user_key: user[:userKey])
        #         end
        #         user_data = specific_user.inspect.downcase.gsub(/[^a-z0-9\s]/i, '')


        #         user_data << user.inspect.downcase.gsub(/[^a-z0-9\s]/i, '')

        #         userdataString=user_data.split(" ")

        #         #previous check --user_data.include? @keyword
        #         # if (userdataString & @keywordArr).any?
        #         #     logger.info("Tanvir Checking")
        #         #     logger.debug(user_data.inspect)
        #         #     #@final_users << user
        #         # end
        #         # puts(user.highlights)
        #         # puts(user.specialization)
        #         # puts(user.profdetails)
        #         # puts(user.compensation)
        #         # puts(user.bio)
        #         text_info = Set.new

        #         if user.first_name != nil
        #             text_info += filter_words(user.first_name)
        #         end

        #         if user.last_name != nil
        #             text_info += filter_words(user.last_name)
        #         end


        #         if user.highlights != nil
        #             text_info += filter_words(user.highlights)
        #         end

        #         if user.specialization != nil
        #             text_info += filter_words(user.specialization)
        #         end

        #         if user.profdetails != nil
        #             text_info += filter_words(user.profdetails)
        #         end

        #         if user.compensation != nil
        #             text_info += filter_words(user.compensation)
        #         end

        #         if user.bio != nil
        #             text_info += filter_words(user.bio)
        #         end


        #         @keyword_set = filter_words(@keyword)

        #         for word in text_info
        #             for keyword in @keyword_set
        #                 if word.include?(keyword)
        #                     @final_users << user
        #                 end
        #             end
        #         end



        #     end
        # else
        @final_users = @filtered_users
        # end

        puts "Final users are: "
        @final_users.each do |final|
            puts final
        end

    end
end
