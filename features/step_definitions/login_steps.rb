# Login Step Definitions

Given(/^I am a valid user$/) do
   @login_info = LoginInfo.create!({
      :email => "hellofriend@gmail.com",
      :password => "password",
      :password_confirmation => "password"
    })
end

When(/^the user logs in$/) do
  visit 'login_info/login'
  fill_in "Email", :with => @login_info.email
  fill_in "Password", :with => @login_info.password
  click_button "Login"
end

When(/^the user tries to log in$/) do
  visit 'login_info/login'
  fill_in "Email", :with => nil
  fill_in "Password", :with => nil
  click_button "Login"
end

Then(/^the user should see "(.*?)" or "(.*?)" $/) do |
  page.has_content?('.flashinfo')
end

When(/^I fill in "(.*?)" field with "(.*?)"$/) do |field_name, value|
  case field_name
  when "emailaddress"
      fill_in "Email", :with => value
  when "password"
      fill_in "Password", :with => value
  else
      puts "invalid field name"
  end
end

Then(/^I should be on the Match My Fashion home page$/) do
  visit root_url
end

Given(/^I am an invalid user$/) do
   @login_info = nil
end

Then(/^I should see a warning$/) do
  page.has_content?('.flashwarning')
end

Then(/^I should be on the login page$/) do
  visit login_info_login_path 
end