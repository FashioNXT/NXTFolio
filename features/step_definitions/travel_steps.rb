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
    fill_in 'city', :with => 'Seattle'
    fill_in 'start', :with => '05/01/2023'
    fill_in 'end', :with => '05/10/2023'
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
  
  Given(/^I am a professional and I add my travel information$/) do
    visit root_path
    click_on "Sign In"
    fill_in "Your Email", :with => "Anthony.Gray@example.com"
    fill_in "Your Password", :with => "Test1234!"
    click_on "SIGN IN"
    visit "/show_profile"
    page.find('a', :text => 'Edit Profile').hover
    sleep(inspection_time=2)
    click_on "Edit Travel Info"
    expect(current_path).to include('general_info/edit_travel')
    select 'United States', from: 'country'
    select 'Massachusetts', from: 'state'
    select 'Boston', from: 'city'
    fill_in 'start', :with => '05/01/2023'
    fill_in 'end', :with => '10/01/2023'
    fill_in 'travel_details', :with => 'Visiting family. Connect with me!'
    click_button('SAVE and GO TO PROFILE')
    expect(page).to have_content("Visiting family. Connect with me!")
  end
  
  # yet to be implemented
  When(/^another user visits my profile$/) do
    click_on 'Log out'
    visit root_path
    click_on "Sign In"
    fill_in "Your Email", :with => "Andrea.Piacquadio@example.com"
    fill_in "Your Password", :with => "Test1234!"
    click_on "SIGN IN"
    fill_in "Search for keywords or name", :with => "Anthony Gray"
    click_button('search_submit')
    click_button('show_page_button')
    expect(page).to have_content("Anthony Gray")
    # page.find('a', :id => 'photo-hover', :text => 'Edit Profile').hover
    # expect(page).to have_content("Anthony Gray")
    # sleep(10)
    # visit 
  end
  
  Then(/^that user should be able to see my travel information$/) do
  
  end