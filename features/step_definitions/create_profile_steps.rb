# Create Profile Step Definitions

Given(/^I am on the Match My Fashion home page$/) do
    visit root_path
end

Given(/^I am on the profile page$/) do
  visit '/show_profile'
end

When(/^I sign up for an account$/) do
    @login_info = LoginInfo.create!({
      :email => "hellofriend@gmail.com",
      :password => "Apple12345*",
      :password_confirmation => "Apple12345*"
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

Then(/^I should be on the designer information page$/) do
  visit '/specific_designer/new'
end

#When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
#  fill_in(field, :with => value)
#end
