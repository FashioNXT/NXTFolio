module Admin
  class AdminController < ApplicationController
    # Probably some code here for if you have permission, but otherwise just links to other pages are here.
    # Maybe all the other pages could get consolidated here and seperated under tabs.

    
    def landing
      @hasPermission = check_admin_permission
      if(@hasPermission == false)
        redirect_to "/login_info/login"
      end
    end
    
    def create
      @hasPermission = check_admin_permission
      @potentialJob = params[:job_name].to_s
    
      if @potentialJob.present?
        @potentialJob = @potentialJob.parameterize(separator: '_').upcase_first
        if GeneralInfo.check_Job?(@potentialJob) == false
          GeneralInfo.create_Job(@potentialJob)
          flash.now[:notice] = "#{@potentialJob.titleize} has been created.\nCurrent jobs are : #{GeneralInfo.see_Jobs.join(",")}"
        else
          flash.now[:notice] = "#{params[:job_name].titleize} already exists.\nCurrent jobs are : #{GeneralInfo.see_Jobs.join(",")}"
        end
      elsif @potentialJob.blank?
        flash.now[:notice] = "Please enter a non-empty value."
      end
    end

    def edit
      @hasPermission = check_admin_permission
      if @hasPermission == false
        redirect_to "/login_info/login" 
      end
      @jobs = GeneralInfo.see_Jobs.map(&:titleize)
    
      if params[:job_name].present? && params[:attr_action].present? && params[:attr_name].present?
        @job = params[:job_name].parameterize(separator: '_').upcase_first
        @job_Obj = @job.constantize
        @action = params[:attr_action]
        @attr = params[:attr_name]
    
        if GeneralInfo.check_Job?(@job)
          handle_attribute_action
        else
          flash.now[:notice] = "Job #{@job.titleize} not found."
        end
      else
        flash.now[:notice] = "Error: One or more empty fields"
      end
    end

    def delete
      @hasPermission = check_admin_permission
      if @hasPermission == false
        redirect_to "/login_info/login" 
      end
    
      @jobs = GeneralInfo.see_Jobs.map(&:titleize)
    
      if params[:job_name].present?
        @potentialJob = params[:job_name].to_s.parameterize(separator: '_').upcase_first
        if GeneralInfo.check_Job?(@potentialJob)
          GeneralInfo.delete_Job(@potentialJob)
          flash.now[:notice] = "#{params[:job_name].titleize} has been deleted."
        end
      end
    end

    private
    # Extracted method to check admin permission
    def check_admin_permission
      if session[:current_user_key].present? && GeneralInfo.exists?(userKey: session[:current_user_key])
        general_info = GeneralInfo.find_by(userKey: session[:current_user_key])
        general_info.is_admin
      else
        false
      end
    end

    # Extracted method to handle the Add/Remove actions for attributes
    def handle_attribute_action
      if @action == 'Add'
        add_attribute
      elsif @action == 'Remove'
        remove_attribute
      else
        flash.now[:notice] = "Attribute #{@attr} already in #{@job.titleize}---#{@job}'s current attributes are #{@job_Obj.view_Attr.inspect}"
      end
    end

    # Add attribute to job
    def add_attribute
      if @job_Obj.view_Attr.include?(@attr)
        flash.now[:notice] = "Attribute #{@attr} already in #{@job.titleize}---#{@job.titleize}'s current attributes are #{@job_Obj.view_Attr.inspect}"
      else
        @job_Obj.add_Attr(@attr)
        update_users_job_attributes
        flash.now[:notice] = "Attribute #{@attr} added to #{@job.titleize}---#{@job.titleize}'s current attributes are #{@job_Obj.view_Attr.inspect}"
      end
    end

    # Remove attribute from job
    def remove_attribute
      if @job_Obj.view_Attr.include?(@attr)
        original_location = @job_Obj.view_Attr.find_index(@attr)
        @job_Obj.delete_Attr(@attr)
        update_users_job_attributes_after_removal(original_location)
        flash.now[:notice] = "Attribute #{@attr} removed from #{@job.titleize}---#{@job.titleize}'s current attributes are #{@job_Obj.view_Attr.inspect}"
      else
        flash.now[:notice] = "Attribute #{@attr} not found in #{@job.titleize}."
      end
    end

    # Extracted method to update job attributes for all users
    def update_users_job_attributes
      GeneralInfo.find_each do |user|
        if user[:job_name] == @job_Obj.name
          Rails.logger.debug("user.job_attr is #{user.job_attr.class}")  # Log the class of job_attr
          if user.job_attr.is_a?(Array)
            user.job_attr += [@attr]
          elsif user.job_attr.is_a?(Hash)
            user.job_attr[@attr] = "Default"  # Or appropriate logic for a hash
          else
            Rails.logger.error("Unexpected type for job_attr")
          end
          user.save
        end
      end
    end

    # Extracted method to update job attributes for users after removing an attribute
    def update_users_job_attributes_after_removal(original_location)
      GeneralInfo.find_each do |user|
        if user[:job_name] == @job_Obj.name
          new_attributes = user[:job_attr]
          if new_attributes.is_a?(Array)
            new_attributes.delete_at(original_location)
            user.update_attribute(:job_attr, new_attributes)
          else
            Rails.logger.error("Expected Array for job_attr, but got #{new_attributes.class}")
          end
        end
      end
    end
  end
end
