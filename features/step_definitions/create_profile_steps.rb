# Create Profile Step Definitions

Given(/^I am on the Match My Fashion home page$/) do
    visit root_path
end

When(/^I sign up for an account$/) do
    @login_info = LoginInfo.create!({
      :email => "hellofriend@gmail.com",
      :password => "password",
      :password_confirmation => "password"
    })
end

Then(/^I should see a message that says "(.*?)"$/) do |message|
  case message
  when "Account Created!"
      page.has_content?('Account Created!')
  when "Invalid Password! Please try again."
      page.has_content?('Invalid Password! Please try again.')
  else
      puts "Did not see message."
  end
end

Then(/^I should be on the general info page$/) do
  visit general_info_new_path
end

Then(/^I should be on the login page$/) do
  visit login_info_login_path 
end
