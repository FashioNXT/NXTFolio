require "rails_helper"

RSpec.describe JobNotificationMailer, type: :mailer do
  #pending "add some examples to (or delete) #{__FILE__}"
  describe "job_notification_email" do
    let(:email) { "john@example.com" }
    let(:name) { "John Doe" }
    let(:job) do
      double("Job", 
        id: 1,
        title: "Fashion Photographer"
      )
    end
    let(:mail) { JobNotificationMailer.job_notification_email(email, name, job) }

    it "renders the headers" do
      expect(mail.subject).to eq("New job you may be interested in")
      expect(mail.to).to eq([email])
      expect(mail.from).to eq(["fashionxtllc@gmail.com"]) 
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(name)
      expect(mail.body.encoded).to match(job.title)
    end

    it "includes a link to view the job" do
      expect(mail.body.encoded).to include(visitor_job_info_url(id: job.id))
    end
  end
end
