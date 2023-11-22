

Given(/^I am a valid admin user$/) do
    name = "Admin"
    fake_password = "Admin123!"
    job = "Model"

    first_name = "Admin"
    last_name = "Admin"
    userkey = SecureRandom.hex(10)
    login_info = LoginInfo.new
    login_info.email = "admin@gmail.com"
    login_info.password = fake_password
    login_info.password_confirmation = fake_password
    login_info.userKey = userkey
    login_info.save!


    general_info = GeneralInfo.new
    #general_info.profession = user['profession']
    general_info.id = 1
    general_info.first_name = first_name
    general_info.last_name = last_name
    general_info.userKey = userkey
    general_info.company = "TestInc"
    general_info.industry = "Fashion"
    general_info.job_name = job

    general_info.highlights = "Test"

    general_info.country = "United States"
    general_info.city = "City"
    general_info.state = "State"
    general_info.emailaddr = "admin@gmail.com"
    general_info.save!
  end

  
When(/^I log in$/) do
    visit 'login_info/login'
    fill_in "Your Email", :with => "admin@gmail.com"
    fill_in "Your Password", :with => "Admin123!"
    
    click_button "SIGN IN"
  end

When(/^I visit landing page$/) do
    visit 'admin'

end

When("I select {string} from the {string} dropdown") do |option, field|
    select option, from: field
end