# Profile Step Definitions

Then(/^I should see my first name$/) do
    page.has_content?(@general_info.first_name)
end

Then(/^I should see my gender$/) do
  page.has_content?(@general_info.gender)
end

Then (/the first name of "([^"]*)" should be "([^"]*)"/) do |member, first_name|
  @general_info.find_by_first_name(first_name).first_name == first_name
end

When(/^I press and go to my profile$/) do
  visit '/show_profile'
end

When(/^I press and go to edit profile$/) do
  visit '/general_info/edit'
end

When (/^(?:|I )fill in "([^"]*)" with "([^"]*)"$/) do |field, value|
  @general_info.update(first_name: value)
end