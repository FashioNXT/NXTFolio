class JobInfoController < ApplicationController
    # Variable that holds a params/object with all the attributes filled in
    def list
        @general_infos = JobInfo.all
    end

    def jobshow
        # @general_info = JobInfo.find(params[:id])
    end

    def get_user_keys array
        @return_array = Array.new
        array.each do |element,index|
        @return_array.push(element[:userKey])
        end

        return @return_array
    end


    # # # Associated with the view used for create
    # def new
    #     # get default email from session if available
    #     @job_info ||= JobInfo.new
    #     # @job_info.emailaddr = session[:current_login_user]["email"] if session.has_key? :current_login_user
    # end



    def new_job 
      @job_info = JobInfo.new
    end


    def post_job 

        
        # @job_info ||= JobInfo.new()
        @job_info = JobInfo.new(job_info_params)
        
        if @job_info.save
            flash[:success_post_job] = "   Job info created successfully"
            redirect_to job_search_jobshow_path
        else
            flash[:error_post_job] = "Error creating job info"
            render 'new'
        end

    end


    # Params used to create the JobInfo object
    def job_info_params
        # cannot use the first line, b/c currently the job_info is nil/missing
        params.require(:job_info).permit(:title, :description, :category, :profession, :country, :state, :city, :type, :low_salary, :high_salary)
        # params.permit(:title, :description, :category, :profession, :country, :state, :city, :type, :low_salary, :high_salary)
    end






    # def create
    #     @possible_Jobs = GeneralInfo.see_Jobs
    #     # Check to see if the required params are filled in
    #     @general_info = GeneralInfo.new(general_info_params)
    #     error_statement = ""
    #     if params[:general_info][:first_name] == ""
    #       error_statement += "First Name, "
    #     end
    #     if params[:general_info][:highlights] == ""
    #       error_statement += "Highlights, "
    #     end
    #     if params[:general_info][:last_name] == ""
    #       error_statement += "Last Name, "
    #     end
    #     if params[:general_info][:company] == ""
    #       error_statement += "Company"
    #     end
    #     if params[:general_info][:industry] == ""
    #       error_statement += "Industry"
    #     end
    #     if params[:general_info][:job_name] == ""
    #       error_statement += "Profession"
    #     end
    #     if params[:general_info][:country] == ""
    #       error_statement += "Country, "
    #     end
    #     if params[:general_info][:state] == ""
    #       error_statement += "State, "
    #     end
    #     if params[:general_info][:city] == ""
    #       error_statement += "City, "
    #     end
    #     if params[:general_info][:emailaddr] == ""
    #       error_statement += "Email, "
    #     end
    
    #     if error_statement.length > 0
    #       error_statement = error_statement[0, error_statement.length-2]
    #       error_statement += " are required."
    #       flash[:notice] = error_statement
    #       render :new and return
    #     end
    
    #     # Add room to LoginInfo DB here to
    #     # synchronize with GeneralInfo DB
    #     current_user = session[:current_login_user]
    #     login_user = LoginInfo.new(
    #       :email => params[:general_info][:emailaddr], 
    #       :password => current_user["password"], 
    #       :password_confirmation => current_user["password"]
    #     )
    #     userKey = SecureRandom.hex(10)
    #     login_user.userKey = userKey
    #     login_user.save!
    #     session[:current_user_key] = userKey
    
    #     # Creates a GeneralInfo object & assigns userKey to be the session key of the current room
    #     @general_info = GeneralInfo.new(general_info_params)
    #     logger.info("Hey I am here")
    #     logger.debug(@general_info.inspect)
    #     @general_info.userKey = session[:current_user_key]
    #     @general_info.is_admin = false
    
    #     $template_name = params[:general_info][:job_name]
    
    #     if GeneralInfo.any?
    #       @general_info.is_admin = false
    #       if(@general_info.job_name == 'Admin' || @general_info.job_name == 'admin')
    #         @general_info.job_name = 'Photographer'
    #       end
    #     else
    #       @general_info.job_name = 'Admin'
    #       @general_info.is_admin = true
    #     end
    
    #     unless @general_info.save!
    #       flash[:error] = "Unknown error when saving: try again later"
    #       render :action => 'new' and return
    #     end
    
    #     # Send Verification Email upon successful sign-up
    #     #UserMailer.welcome_email(@general_info,current_user).deliver_now! #works
    #     if params[:select_one]
    #       session.delete(:current_login_user)
    #       redirect_to "/general_info/new2"
    #     elsif params[:select_two]
    #       redirect_to "/search_engine/show"
    #     end
        
    #     # Redirect to specific profession edit page
    #     #if $template_name == "Designer"
    #       #@general_info.update_attribute(:specific_profile_id,1)
    #       #redirect_to "/specific_designer/edit"
    #       #elsif $template_name == "Model"
    #       #@general_info.update_attribute(:specific_profile_id,2)
    #       #redirect_to "/specific_model/edit"
    #       #elsif $template_name == "Photographer"
    #       #@general_info.update_attribute(:specific_profile_id,3)
    #       #redirect_to "/specific_photographer/edit"
    #     #end
    #   end
    
     
  
    


    def search 

        
        @params_args = params #parameters passed from view
        # country = "United States" # change country to industry later (need to modify filterBy as well)
        # state = @params_args[:State]
        # city= @params_args[:City]


        # @stateInfo=state
        # profession = @params_args[:Profession]
        # @filtered_users = GeneralInfo.filterBy state, profession, city

        @filtered_users = JobInfo.all 

        #puts "Filtered users are: "
        #@filtered_users.each do |room|
        #    puts room[:first_name]
        #end

        # # Search Users' general info and profession detail for the keyword
        # @keyword = @params_args[:Keyword]
        # @EnteredKw=@keyword
        # @keyword= @keyword.downcase
        # @keywordArr=@keyword.split(" ")
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
        #         if (userdataString & @keywordArr).any?
        #             logger.info("Tanvir Checking")
        #             logger.debug(user_data.inspect)
        #             @final_users << user
        #         end
        #     end
        # else
        #     @final_users = @filtered_users
        # end

        @final_users = @filtered_users

        puts "Final users are: "

    end

   
  
    
  end
  