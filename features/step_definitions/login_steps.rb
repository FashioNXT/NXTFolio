# Login Step Definitions

Given(/^I am a valid user$/) do
   @login_info = LoginInfo.create!({
      :email => "hellofriend@gmail.com",
      :password => "password",
      :password_confirmation => "password"
    })
   @general_info = GeneralInfo.create!({
      :first_name => "Ive",
      :last_name => "Yi",
      :month_ofbirth => "January",
      :day_ofbirth => "23",
      :year_ofbirth => "1990",
      :country => "United States",
      :state => "TX",
      :city => "College Station",
      :phone => 82711
    })
end

Given(/^I am a valid admin user$/) do
  @login_info = LoginInfo.create!({
        :email => "admin@gmail.com",
        :password => "password",
        :password_confirmation => "password",
        :is_admin => "true"
    })
  @general_info = GeneralInfo.create!({
        :first_name => "Ive",
        :last_name => "Yi",
        :month_ofbirth => "January",
        :day_ofbirth => "23",
        :year_ofbirth => "1990",
        :country => "United States",
        :state => "TX",
        :city => "College Station",
        :phone => 8271
    })
end


Given(/^I am an invalid user$/) do
   @login_info = nil
end

When(/^I log in$/) do
  visit 'login_info/login'
  fill_in "email", :with => @login_info.email
  fill_in "password", :with => @login_info.password
  click_button "Login"
end

When(/^I try to log in$/) do
  visit 'login_info/login'
  fill_in "email", :with => nil
  fill_in "password", :with => nil
  click_button "Login"
end

Then(/^I should see "(.*?)"$/) do |field_name|
  case field_name
  when "Logged In!"
    page.has_content?("Logged In!")
  when "Incorrect Email!"
    page.has_content?("Incorrect Email")
  when "Incorrect Password"
    page.has_content?("Incorrect Password")
  end
end

Then(/^I should be on the Match My Fashion home page$/) do
  visit root_url
end

Then(/^I should be on the login page$/) do
  visit login_info_login_path 
end
