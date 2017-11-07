# Profile Step Definitions

Then(/^I should see my first name$/) do
    page.has_content?(@general_info.first_name)
end

When(/^I press and go to my profile$/) do
  visit '/show_profile'
end