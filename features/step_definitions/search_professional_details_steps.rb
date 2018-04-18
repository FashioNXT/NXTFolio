# Search Professional Details Step Definitions

When(/^I click on search button and search by profession/) do
  
end

Then(/I should see "No matches"/) do

end

When(/^I click on search button and search by tags/) do
  
end

When(/^I click on search button/) do

end

Given I am a valid user
  When I click on search button and search by profession
  Then I should see "No matches"
  When I click on search button and search by tags
  Then I should see "No matches"

  Given I am an invalid user
  When I click on search butt
  Then I should be on the login page

When(/^I click on search button and search by email id$/) do
  visit 'search_profile/search'
  fill_in "email", :with => 'hellofriend@gmail.com'
  click_button "Submit"
end

When(/^I click on search button and search by fields$/) do
  visit 'search_profile/search'
  fill_in "First Name", :with => 'avinash'
  click_button "Submit"
end

# When(/^I try to log in$/) do
#   visit 'login_info/login'
#   fill_in "email", :with => nil
#   fill_in "password", :with => nil
#   click_button "Login"
# end
#

#
# Then(/^I should be on the Match My Fashion home page$/) do
#   visit root_url
# end
#
# Then(/^I should be on the login page$/) do
#   visit login_info_login_path
# end
