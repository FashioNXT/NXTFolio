Given(/the following jobs exist/) do |jobs_table|
    jobs_table.hashes.each do |job|

        job_info = JobInfo.new

        userkey = SecureRandom.hex(10)

        job_info.title = job['title']
        job_info.description = job['description']
        job_info.profession = job['profession']
        job_info.country = job['country']
        job_info.state = job['state']
        job_info.city = job['city']
        job_info.low_salary = job['low_salary']
        job_info.high_salary = job['high_salary']

        job_info.userKey = userkey

        job_info.save!

    end
end

    # "title"
    # t.string "description"
    # t.string "category"
    # t.string "profession"
    # t.string "country"
    # t.string "state"
    # t.string "city"
    # t.string "type"
    # t.integer "low_salary"
    # t.integer "high_salary"
    # t.datetime "created_at", precision: 6, null: false
    # t.datetime "updated_at", precision: 6, null: false
    # t.string "userKey"


    # users_table.hashes.each do |user|
    #   name = user['name'].split(".")
    #   fake_password = user['password']
    #   job = user['job']
  
    #   first_name = name[0]
    #   last_name = name[1]
    #   userkey = SecureRandom.hex(10)
    #   login_info = LoginInfo.new
    #   login_info.email = "#{first_name}.#{last_name}@example.com"
    #   login_info.password = fake_password
    #   login_info.password_confirmation = fake_password
    #   login_info.userKey = userkey
    #   login_info.save!
  
  
    #   general_info = GeneralInfo.new
    #   #general_info.profession = user['profession']
    #   general_info.id = user['id']
    #   general_info.first_name = first_name
    #   general_info.last_name = last_name
    #   general_info.userKey = userkey
    #   general_info.company = "TestInc"
    #   general_info.industry = "Fashion"
    #   general_info.job_name = job
  
    #   general_info.highlights = user['highlights']
  
    #   general_info.country = "United States"
    #   #general_info.state = "Texas"
    #   #general_info.city = "College Station"
    #   general_info.city = user['city']
    #   general_info.state = user['state']
    #   general_info.emailaddr = "#{first_name}.#{last_name}@example.com"
    #   general_info.save!
    # end


# Given (/I should click on the job search button/) do
#     click_button "job_search_button"
# end

Then(/^I should click on the job search button$/) do 
    click_button "job_search_button"
  end