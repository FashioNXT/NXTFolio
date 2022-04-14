Given(/^I am a professional and search for another professional$/) do
  visit root_path
end

When(/^I wish to click on search button on home page for country and city check$/) do
  click_on "search_submit"
end

Then(/^I should be able to provide country and city information on that page$/) do
  select 'United States', from: 'country'
  select 'Texas', from: 'state'
  select 'College Station', from: 'city'
end

And(/^after clicking search, I can again provide country and city information on that page$/) do
  click_on "show_page_button"
  select 'United States', from: 'country'
  select 'Texas', from: 'state'
  select 'College Station', from: 'city'

end

Given(/^I am a professional and intend to click the search button$/) do
  visit root_path
end

When(/^I intend to click the search button on home page$/) do
  click_on "search_submit"
end

Then(/^Default country option united states should be selected$/) do
  sleep(inspection_time=5)
  expect(page).to have_select(
                    'country',         # locator
                    selected: 'United States' # option
                  )
end

And(/^After submitting this search page, I can again see united states as the default contry in search result page$/) do
  click_on "show_page_button"
  sleep(inspection_time=5)
  expect(page).to have_select(
                    'country',         # locator
                    selected: 'United States' # option
                  )
end

Given(/^I am a professional adding my profile$/) do
  visit root_path
  click_on "Register Your Business"
  fill_in "email", :with => 'fashionxt133@gmail.com'
  fill_in "password", :with => 'Abc123!'
  fill_in "confirm", :with => 'Abc123!'
  click_button "commit"

end

When(/^I am in profile addition page$/) do
  expect(current_path).to include('general_info/new')
end

Then(/^I will see United States as the default option$/) do
  sleep(inspection_time=5)
  expect(page).to have_select(
                    'country',         # locator
                    selected: 'United States' # option
                  )
end


Given(/^I am a professional editing my profile$/) do
  visit root_path
  click_on "Sign In"
  fill_in "Your Email", :with => 'fashionxt102@gmail.com'
  fill_in "Your Password", :with => 'Abc123!'
  click_button "SIGN IN"
  visit "/show_profile"
  page.first('a', :text => 'Edit Profile').hover
  sleep(inspection_time=2)
  click_on "Edit Personal Info"

end

When(/^I am in profile edition page$/) do
  expect(current_path).to include('general_info/edit')
end

Then(/^I will see United States as the default option in profile editon page$/) do
  sleep(inspection_time=5)
  expect(page).to have_select(
                    'country',         # locator
                    selected: 'United States' # option
                  )
end








