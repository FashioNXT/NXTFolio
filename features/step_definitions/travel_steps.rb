Given(/^I am a professional and want to add my travel information$/) do
    visit root_path
    click_on "Sign In"
    fill_in "Your Email", :with => "Anthony.Gray@example.com"
    fill_in "Your Password", :with => "Test1234!"
    click_on "SIGN IN"
    visit "/show_profile"
  end

  And(/^I want to add my travel information$/) do
    visit "/show_profile"
  end

  When(/^I click on "Edit Travel Info" from the menu$/) do
    page.find('a', :text => 'Edit Profile').hover
    sleep(inspection_time=2)
    click_on "Edit Travel Info"
  end

  Then(/^I should be able to see the travel info edit page$/) do
    expect(current_path).to include('general_info/edit_travel')
  end
  
  When(/^I fill in the travel form with details$/) do
    select 'United States', from: 'country'
    select 'Washington', from: 'state'
    select 'Seattle', from: 'city'
    fill_in 'start', :with => '04/01/2023'
    fill_in 'end', :with => '05/01/2023'
    fill_in 'travel_details', :with => 'Attending a conference. Reach out to me!'
  end
  
  And(/^I click on "SAVE and GO TO PROFILE" button$/) do
    click_button('SAVE and GO TO PROFILE')
  end

  Then(/^I should see my travel details on my profile page$/) do
    expect(page).to have_content("Attending a conference. Reach out to me!")
  end

  And(/^my travel details should include "([^"]*)"$/) do |travel_details|
    expect(page).to have_content(travel_details)
  end
