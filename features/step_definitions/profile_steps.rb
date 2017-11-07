# Profile Step Definitions

Given(/^I am on the home page$/) do
    visit root_path
end

Then(/^I should see my first name$/) do
    page.has_content?(@general_info.first_name)
end

When(/^I go to the profile page$/) do
  visit '/show_profile'
end