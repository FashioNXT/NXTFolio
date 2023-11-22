# Profile Step Definitions

Then(/^I should see my first name$/) do
    page.has_content?(@general_info.first_name)
end

Then(/^I should see my last name$/) do
  page.has_content?(@general_info.last_name)
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

# When (/^(?:|I )fill in "([^"]*)" with "([^"]*)"$/) do |field, value|
#   @general_info.update(first_name: value)
# end

Then(/^I should see delete option$/) do
  page.has_content?('Delete This Project')
end

When (/^I delete my gallary$/) do
  # click_on 'Delete This Project'
  visit 'show_profile/destroy/100'
end

Given(/^I am a valid user with specific_profile_id one$/) do
  @login_info = LoginInfo.create!({
     :email => "hellofriend@gmail.com",
     :password => "Apple12345*",
     :password_confirmation => "Apple12345*"
   })
  @general_info = GeneralInfo.create!({
     :first_name => "Ive",
     :last_name => "Yi",
     :month_ofbirth => "January",
     :day_ofbirth => "23",
     :year_ofbirth => "1990",
     :country => "United States",
     :state => "TX",
     :city => "Houston",
     :phone => 82711,
     :industry => "Professional",
     :company => "Test company",
     :emailaddr => "ive.yi@gmail.com",
     :highlights => "dummy",
     :specific_profile_id => 1
   })
end