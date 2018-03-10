# Login Step Definitions


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
