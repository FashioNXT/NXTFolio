module Admin
  class AdminController < ApplicationController
    # Probably some code here for if you have permission, but otherwise just links to other pages are here.
    # Maybe all the other pages could get consolidated here and seperated under tabs.
    
    def create

      @potentialJob = params[:job_name].to_s
      
      
      if(@potentialJob != nil && @potentialJob != "")
        @potentialJob = @potentialJob.parameterize(separator: '_').upcase_first
        if(GeneralInfo.check_Job?(@potentialJob) == false)
	  GeneralInfo.create_Job(@potentialJob)
          flash[:notice] = @potentialJob.titleize + " has been created."
	else
          flash[:notice] = params[:job_name].titleize + " already exists."
	end 
      elsif(params[:job_name] == "")
        flash[:notice] = "Please enter a non-empty value."
      end
      
     # else
      # Probably fetching page

      
    end

    def edit

      @jobs = Array.new

      GeneralInfo.see_Jobs.each do |i|
        @jobs.push i.titleize
      end
      
      if(params[:job_name] != nil && params[:attr_action] != nil && params[:attr_name] != nil)
        @job = params[:job_name].parameterize(separator: '_').upcase_first
        @job_Obj = params[:job_name].parameterize(separator: '_').upcase_first.constantize
        @action = params[:attr_action]
        @attr = params[:attr_name]

        if(GeneralInfo.check_Job?(@job))
          if(@action == 'Add')
            @job_Obj.add_Attr(@attr)
            flash[:notice] = "Attribute " + @attr + " added to " + @job + "---" + @job + "\'s current attributes are " + @job_Obj.view_Attr.inspect
          elsif(@action == 'Remove')
            @job_Obj.delete_Attr(@attr)
            flash[:notice] = "Attribute " + @attr + " removed from " + @job + "---" + @job + "\'s current attributes are " + @job_Obj.view_Attr.inspect
          end
          
        else
          flash[:notice] = "Job " + @job.titleize + " not found."
        end
         	  
      else
        flash[:notice] = "Error: One or more empty fields"
      end
    end
    def delete

      @jobs = Array.new
      
      
      if(params[:job_name] != nil)
         @potentialJob = params[:job_name].to_s.parameterize(separator: '_').upcase_first
        if(GeneralInfo.check_Job?(@potentialJob))
	   GeneralInfo.delete_Job(@potentialJob)
           flash[:notice] = params[:job_name].titleize + " has been deleted."
	end
      #else
        # Probably fetching page
      end

      GeneralInfo.see_Jobs.each do |i|
        @jobs.push i.titleize
      end
	
    end
  end
end
