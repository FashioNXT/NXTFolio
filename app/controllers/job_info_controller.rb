class JobInfoController < ApplicationController
    # Variable that holds a params/object with all the attributes filled in
    def list
        @general_infos = JobInfo.all
    end

    def jobshow
        # @general_info = JobInfo.find(params[:id])
    end

    
    def new 
        @job_info = JobInfo.new
    end 


    def show 

    end


    def create 

    end 
  






     
  
    

   
  
    
  end
  