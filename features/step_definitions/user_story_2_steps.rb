Given(/^I am a professional and want to create my profile$/) do
  visit root_path
end

When(/^I click on "Register Your Business" in the home page$/) do
  click_on "Register Your Business"
end

Then(/^I should be able to provide username and password 2 times to register$/) do
  fill_in "email", :with => 'fashionxt101@gmail.com'
  fill_in "password", :with => 'Abc123!'
  fill_in "confirm", :with => 'Abc123!'
end

And(/^I should be redirected to the first profile data entry page$/) do
  click_button "commit"
  expect(current_path).to include('general_info/new')
end


Given(/^I am a professional and want to enter personal data$/) do
  visit root_path
  click_on "Register Your Business"
  fill_in "email", :with => 'fashionxt102@gmail.com'
  fill_in "password", :with => 'Abc123!'
  fill_in "confirm", :with => 'Abc123!'
  click_button "commit"
  expect(current_path).to include('general_info/new')
end

When(/^I submitted all the required personal information$/) do
  fill_in "first_name", :with => 'Test'
  fill_in "last_name", :with => 'User'
  fill_in "company", :with => 'Test Company'
  select 'Creators', from: 'general_info_industry'
  select 'Designer', from: 'general_info_job_name'
  fill_in "highlights", :with => 'highlights'
  select 'United States', from: 'country'
  select 'Texas', from: 'state'
  select 'College Station', from: 'city'
  fill_in "emailaddr", :with => 'fashionxt@gmail.com'
  #sleep(inspection_time=80)
  click_button('SAVE AND CONTINUE')
  #sleep(inspection_time=80)
  #expect(page).to have_button('SAVE and GO TO PROFILE')
end

Then(/^After save I redirct to professional detail page and provide information and submit$/) do

  expect(page).to have_button('SAVE and GO TO PROFILE')
  fill_in "specialization", :with => 'my specialization'
  fill_in "profdetails", :with => 'ProfessionalDetails'
  fill_in "bio", :with => 'About me'
  fill_in "general_info_facebook_link", :with => 'My facbook profile'
  fill_in "general_info_facebook_link", :with => 'My linkedin profile'
  fill_in "general_info_facebook_link", :with => 'My site address'
  select 'Salary', from: 'general_info_compensation'
  fill_in "experience", :with => '2'
  click_button "select_two"
  sleep(inspection_time=20)
end

And(/^I will be redirected to profile detail page$/) do
  expect(current_path).to include('show_profile')
end



