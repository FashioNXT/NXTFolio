Given(/^I am a professional and trying to search another professional$/) do
  visit root_path
end

When(/^I type "test user" and click on search button$/) do
  visit root_path
  fill_in "Initkey", :with => 'test'
  click_button "search_submit"
end

Then(/^I should be redirected to advanced_search_show page$/) do
  current_path = URI.parse(current_url).path
  expect(current_path).to include('search_engine/show')
end

And(/^with "test" as search string$/) do
  expect(page).to have_field('Keyword', with: 'test')
end


# Scenario 2

Given(/^I am a professional and search a professional from show page$/) do
  visit root_path
  click_button "search_submit"
end

When(/^I type "test" and click on search button from show page$/) do
  #visit root_path
  fill_in "Keyword", :with => 'test'
  click_button "show_page_button"
end

Then(/^I should be redirected to advanced_search_search page$/) do
  current_path = URI.parse(current_url).path
  expect(current_path).to include('search_engine/search')
end


Given(/^I can create an individual$/) do
  visit root_path
  click_button "search_submit"
end



