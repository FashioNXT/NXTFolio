Given(/^I am a professional and want to edit my profile$/) do
  visit root_path
  click_on "Sign In"
  fill_in "Your Email", :with => 'fashionxt101@gmail.com'
  fill_in "Your Password", :with => 'Abc123!'
  click_button "SIGN IN"
  sleep(inspection_time=20)
  visit "/show_profile"

end

When(/^I click one page$/) do
  click_on "Register Your Business"
end

Then(/^I should be able to  2 times to register$/) do
  fill_in "email", :with => 'fashionxt101@gmail.com'
  fill_in "password", :with => 'Abc123!'
  fill_in "confirm", :with => 'Abc123!'
end

And(/^I should be redirected to the fientry page$/) do
  click_button "commit"
  expect(current_path).to include('general_info/new')
end


Given(/^I am a profeersonal data$/) do
  visit root_path
  click_on "Register Your Business"
  fill_in "email", :with => 'fashionxt102@gmail.com'
  fill_in "password", :with => 'Abc123!'
  fill_in "confirm", :with => 'Abc123!'
  click_button "commit"
  expect(current_path).to include('general_info/new')
end

When(/^I submitted all the reation$/) do
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

Then(/^After save I page and provide information and submit$/) do

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

And(/^I will bee detail page$/) do
  expect(current_path).to include('show_profile')
end



