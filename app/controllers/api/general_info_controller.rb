class Api::GeneralInfoController < ApplicationController
    def index
        user_activities = UserActivityDetail.all
        user_activities = user_activities.map do |user_activity|
            user = GeneralInfo.find_by(id: user_activity[:user_id])
            email = user[:emailaddr]
            id = user[:id]
            location = user[:city] + ',' + user[:state] + ',' + user[:country]
            name = user[:first_name] + ' ' + user[:last_name]
            access_enabled = true # !user.deactivated
            app = "NXTFolio"
            average_minutes_used_last_30_days = (user_activity[:time_spent_on_website]/60.to_i)%43200
            user_type = user.job_name || "Unknown"
            initial_access = user.created_at.strftime("%Y-%m-%d %H:%M:%S")
            last_access = user_activity.last_active_at ? user_activity.last_active_at.strftime("%Y-%m-%d %H:%M:%S") : "null"
            updated_at = user_activity.updated_at.strftime("%Y-%m-%d %H:%M:%S")
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
            updated_at: updated_at
            }
        end
    
        render json: { user_info: user_activities }
    end
  end
