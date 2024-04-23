class JobNotificationMailer < ApplicationMailer
    def job_notification_email(email, name, job)
        @name = name
        @title = job.title
        @url = visitor_job_info_url(:id => job.id)
        mail(to: email, subject: "New job you may be interested in")
    end
end
