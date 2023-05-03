# the first several steps can be found in travel_steps.rb
  
#   Then(/^I go to the search engine show page$/) do
#     visit "/search/show"
#   end

  And(/^I want to type in the search details$/) do 
    select 'United States', from: 'country'
    select 'Washington', from: 'state'
    fill_in 'city', :with => 'Seattle'
  end

  Then(/^I should click on the search button$/) do 
    click_button "show_page_button"
  end

  Then(/^I should see "([^"]*)" in the search results$/) do |name|
    expect(page).to have_content(name)
  end
  

  When(/^I fill in the travel form with new details$/) do
    select 'United States', from: 'country'
    select 'Washington', from: 'state'
    fill_in 'city', :with => 'Seattle'
    fill_in 'start', :with => '08/01/2023'
    fill_in 'end', :with => '08/10/2023'
    fill_in 'travel_details', :with => 'Attending a conference. Reach out to me!'
  end
  