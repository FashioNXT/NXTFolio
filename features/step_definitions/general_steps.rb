require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

Given(/the following users exist/) do |users_table|
  users_table.hashes.each do |user|
    name = user['name'].split(".")
    fake_password = user['password']

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
    general_info.job_name = "Model"
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

Given(/^I am on (.+)$/) do |page_name|
  visit path_to(page_name)
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
