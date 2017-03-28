# Login Step Definitions

Given(/^I am a valid user$/) do
   @login_info = LoginInfo.create!({
      :email => "hellofriend@gmail.com",
      :password => "password",
      :password_confirmation => "password"
    })
end

When(/^I go to the login page$/) do
  visit 'login_info#login'
end

When(/^I fill in "(.*?)" field with "(.*?)"$/) do |field_name, value|
  visit 'login_info#login' 
  case field_name
  when "email"
      fill_in "Email", :with => value
  when "password"
      fill_in "Password", :with => value
  else
      puts "invalid field name"
  end
end

When(/^I press login button$/) do
    visit 'login_info#login'
end

Then(/^I should see a confirmation alert$/) do
  page.has_content?('.flashinfo')
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