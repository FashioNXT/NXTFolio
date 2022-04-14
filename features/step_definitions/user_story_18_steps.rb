Given(/^I am a professional and want to see the category on home page$/) do
  visit root_path
end

When(/^I landed on home page$/) do
  visit root_path
end

Then(/^I should be able to see updated category buttons in the home page$/) do
  expect(page).to have_content("Brand Owner")
  expect(page).to have_content("Other Creator")
  expect(page).to have_content("Influencer")
  expect(page).to have_content("Content Creator")
  expect(page).to have_content("Manufacturing")
  expect(page).to have_content("Materials")
end

Given(/^I am a professional and want to search for a profile$/) do
  visit root_path
end

When(/^I select the category "Services"$/) do
  click_on "search_submit"
  select 'Creators', from: 'general_info_industry'
  #sleep(inspection_time=10)
end

Then(/^only service related profession will be populated in dropdown$/) do
  expect(page).to have_content("Brand Owner")
end

Given(/^I am a professional and want to add my profile$/) do
  visit root_path
  click_on "Register Your Business"
  fill_in "email", :with => 'fashionxt131@gmail.com'
  fill_in "password", :with => 'Abc123!'
  fill_in "confirm", :with => 'Abc123!'
  click_button "commit"
  expect(current_path).to include('general_info/new')
end

When(/^I select the category "Services" in add profile page$/) do
  select 'Creators', from: 'general_info_industry'
end

Then(/^only service related profession will be populated in dropdown in add profile$/) do
  expect(page).to have_content("Brand Owner")
end

Given(/^I am a professional and want to see autopopulation in edit profile option$/) do
  visit root_path
  click_on "Sign In"
  fill_in "Your Email", :with => 'fashionxt102@gmail.com'
  fill_in "Your Password", :with => 'Abc123!'
  click_button "SIGN IN"
  visit "/show_profile"
  page.first('a', :text => 'Edit Profile').hover
  sleep(inspection_time=2)
  click_on "Edit Personal Info"
  expect(current_path).to include('general_info/edit')
end

When(/^I select the category "Services" in edit profile page$/) do
  select 'Creators', from: 'general_info_industry'
end

Then(/^only service related profession will be populated in dropdown in edit profile$/) do
  expect(page).to have_content("Brand Owner")
end














