class Api::GeneralInfoController < ApplicationController
    def index
        # user_activities = UserActivityDetail.all
        users = GeneralInfo.all
        # user_activities = user_activities.map do |user_activity|
        user_info = users.map do |user|
            # user = GeneralInfo.find_by(id: user_activity[:user_id])
            email = user[:emailaddr]
            id = user[:id]
            location = user[:city] + ',' + user[:state] + ',' + user[:country]
            name = user[:first_name] + ' ' + user[:last_name]
            access_enabled = true # !user.deactivated
            fees_last_30_days = 0
            app = "NXTFolio"
            user_activities = UserActivityDetail.where(user_id: id).first
            if user_activities
                average_minutes_used_last_30_days = (UserActivityDetail.where("user_id = ? AND created_at >= ?", id, 30.days.ago).average(:time_spent_on_website).to_i)/60
                last_access = user_activities.last_active_at ? user_activities.last_active_at.strftime("%Y-%m-%d %H:%M:%S") : "null"
            else
                average_minutes_used_last_30_days = 0
                last_access = "null"
            end

            user_type = user.job_name || "Unknown"
            initial_access = user.created_at.strftime("%Y-%m-%d %H:%M:%S")

            updated_at = user.updated_at.strftime("%Y-%m-%d %H:%M:%S")
            {
            access_enabled: access_enabled,
            app: app,
            average_minutes_used_last_30_days: average_minutes_used_last_30_days,
            created_at: initial_access,
            email: email,
            id: id,
            location: location,
            name: name,
            user_type: user_type,
            initial_access: initial_access,
            last_access: last_access,
            updated_at: updated_at,
            fees_last_30_days: fees_last_30_days
            }
        end
    
        render json: user_info
    end
  end
