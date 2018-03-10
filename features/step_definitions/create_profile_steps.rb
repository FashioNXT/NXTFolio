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

Then(/^I should be on the designer information page$/) do
  visit '/specific_designer/new'
end

When /^(?:|I )fill in the following:$/ do |fields|
  fields.rows_hash.each do |name, value|
    When %{I fill in "#{name}" with "#{value}"}
  end
end

When /^(?:|I )select "([^"]*)" from "([^"]*)"$/ do |value, field|
  select(value, :from => field)
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end

When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button(button)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end
