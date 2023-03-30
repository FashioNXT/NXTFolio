require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

Given(/the following users exist/) do |users_table|
  users_table.hashes.each do |user|
    name = user['name'].split(".")
    fake_password = user['password']
    job = user['job']

    first_name = name[0]
    last_name = name[1]
    userkey = SecureRandom.hex(10)
    login_info = LoginInfo.new
    login_info.email = "#{first_name}.#{last_name}@example.com"
    login_info.password = fake_password
    login_info.password_confirmation = fake_password
    login_info.userKey = userkey
    login_info.save!

    general_info = GeneralInfo.new
    general_info.first_name = first_name
    general_info.last_name = last_name
    general_info.userKey = userkey
    general_info.company = "TestInc"
    general_info.industry = "Fashion"
    general_info.job_name = job
    general_info.highlights = "Just a test User"
    general_info.country = "United States"
    general_info.state = "Texas"
    general_info.city = "College Station"
    general_info.emailaddr = "#{first_name}.#{last_name}@example.com"
    general_info.save!
  end
end

# a handy debugging step you can use in your scenarios to invoke 'pry' mid-scenario and poke around
When /I debug/ do
  binding.pry
end

Then(/^I should be on (.+)$/) do |page_name|
  current_path = URI.parse(current_url).path
  expect(current_path).to eq(path_to(page_name))
end

Given(/^I am logged in$/) do
  visit 'login_info/login'
  fill_in "email", :with => @login_info.email
  fill_in "password", :with => @login_info.password
  click_button "Login"
end

Given(/^I am logged in as "(.+)"$/) do |user|
  # get user info
  name = user.split(".")
  email = "#{name[0]}.#{name[1]}@example.com"
  login_info = LoginInfo.find_by(email: email)

  # login as user
  visit 'login_info/login'
  fill_in "login_email", :with => login_info.email
  fill_in "login_password", :with => login_info.password
  click_button "SIGN IN"
end

Given(/^I am on (.+)$/) do |page_name|
  visit path_to(page_name)
end

When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |field, value|
  fill_in(field, :with => value)
end

When /^(?:|I )fill in the following:$/ do |fields|
  fields.rows_hash.each do |name, value|
    fill_in(name, :with => value)
  end
end

Then /^(?:|I )should see the following fields:$/ do |fields|
  fields.rows_hash.each do |name, value|
    expect(find_field(name).value).to eq(value)
  end
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

When /^(?:|I )select "([^"]*)" from "([^"]*)"$/ do |value, field|
  select(value, :from => field)
end

When(/^I click on "([^"]*)"$/) do |button|
  click_link_or_button(button)
end

Then(/^(?:|I )should see "([^"]*)"$/) do |text|
  expect(page).to have_content(text)
end

Then(/^(?:|I )should not see "([^"]*)"$/) do |text|
  expect(page).not_to have_content(text)
end

# untested method
Then /^(?:|I ) should see "([^"]*)" in the (.+) section/ do |expected_text, section_selector|
  expect(page).to have_selector(section_selector, text: expected_text)
end

# untested method
When(/^I hover over the "([^"]*)" element$/) do |element|
  # find the element using Selenium WebDriver
  target_element = find(:xpath, "//*[@id='#{element}']")

  # use the Selenium WebDriver 'action' object to hover over the element
  page.driver.browser.action.move_to(target_element.native).perform
end

Given /"(.+)" sends a message to "(.+)" saying "(.+)"/ do |from_user, to_user, msg|
  step "I am logged in as \"#{from_user}\""
  visit path_to "the DM page"
  step "I select \"#{to_user.gsub('.', ' ')}\" chat"
  fill_in("body", :with => msg)
  click_link_or_button "send"
  click_link_or_button "Log out"



  # todo! create a message
  # from_name = from_user.split(".")
  # from_email = "#{from_name[0]}.#{from_name[1]}@example.com"
  # from_info = GeneralInfo.find_by(email: from_email)

  # to_name = to_user.split(".")
  # to_email = "#{to_name[0]}.#{to_name[1]}@example.com"
  # to_info = GeneralInfo.find_by(email: to_email)



  # users = [from_user.id, to_user.id].sort
  # room_name = "private_#{users[0]}_#{users[1]}"
  # @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, @chatting_with], @room_name)

  # @message = Message.create(general_info_id: @user[:id], room_id: @single_room[:id], body: params[:body], chatting_with: @chatid)
end
