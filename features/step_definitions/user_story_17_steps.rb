Given(/^I am a professional and want to edit my profile$/) do
  visit root_path
  click_on "Sign In"
  fill_in "Your Email", :with => 'fashionxt102@gmail.com'
  fill_in "Your Password", :with => 'Abc123!'
  click_button "SIGN IN"
  visit "/show_profile"


end

When(/^I click on "Edit Personal Info" from the menu$/) do
  page.first('a', :text => 'Edit Profile').hover
  sleep(inspection_time=2)
  click_on "Edit Personal Info"
end

Then(/^I should be able to see the personal info edit page$/) do
  expect(current_path).to include('general_info/edit')
end

And(/^I can save any information and click the save button to go to profile page$/) do
  fill_in "first_name", :with => 'editTest'
  select 'United States', from: 'country'
  select 'Texas', from: 'state'
  select 'College Station', from: 'city'
  click_button('UPDATE AND CONTINUE')

end

And(/^I can see the edited data on my profile page$/) do
  expect(page).to have_content("editTest")
end


Given(/^I am a professional and want to edit my professional data$/) do
  visit root_path
  click_on "Sign In"
  fill_in "Your Email", :with => 'fashionxt102@gmail.com'
  fill_in "Your Password", :with => 'Abc123!'
  click_button "SIGN IN"
  visit "/show_profile"

end

When(/^I click on "Edit Professional Info" from the menu$/) do
  page.first('a', :text => 'Edit Profile').hover
  sleep(inspection_time=2)
  click_on "Edit Professional Info"
  #sleep(inspection_time=10)
end

Then(/^I should be able to see the professional info edit page$/) do

  expect(current_path).to include('general_info/edit2')
end

And(/^I can save any information and click the save button on professional page to go to profile page$/) do
  fill_in "bio", :with => 'editbio'
  click_button('SAVE and GO TO PROFILE')
  #sleep(inspection_time=10)
end

And(/^I can see the edited professional data data on my profile page$/) do
  expect(page).to have_content("editbio")
end



