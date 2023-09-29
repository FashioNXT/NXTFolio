Given(/^I am logged in$/) do
    visit "/login_info/logout"
  end

  When(/^I press profile.svg go to my profile$/) do
    visit '/show_profile'
  end

  When(/^I press search.svg go to search$/) do
    visit '/show_profile'
    # For now it just goes to the show_profile
  end