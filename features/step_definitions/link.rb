Capybara.default_driver = :selenium_chrome

Given(/^I am on the FashioNxt home page$/) do
    visit root_path
end

When (/^I click on about us link$/) do
    visit root_path
end 
Then (/^I should see the about us page of FashioNxt website$/) do
    visit 'https://fashionxt.com/agency/' 
end

When (/^I click on jobs link$/) do
    visit root_path
end
Then (/^I should see the linkedin jobs page of FashioNxt$/) do
    visit 'https://www.linkedin.com/company/fashionxt'
end

When (/^I click on contact us link$/) do
    visit root_path
end
Then (/^I should see the contact us page of FashioNxt website$/) do
    visit 'https://fashionxt.com/contact/' 
end

When (/^I click on what are you looking for link$/) do
    visit root_path
end
Then (/^I should redirect to search page$/) do
    visit search_profile_search_path
end

When (/^I click on help link$/) do
    visit root_path
end
Then (/^I should see the help page of FashioNxt$/) do 
    visit 'https://fashionxt.com/contact/'
end

When (/^I click on the facebook icon on the bottom left corner$/) do
    visit root_path
end
Then (/^I should redirect to the facebook page$/) do 
    visit 'https://www.facebook.com/fashionxtonline/'
end

When (/^I click on the twitter icon on the bottom left corner$/) do
    visit root_path
end
Then (/^I should redirect to the twitter page$/) do 
    visit 'https://twitter.com/fashionxtonline'
end

When (/^I click on the pinterest icon on the bottom left corner$/) do
    visit root_path
end
Then (/^I should redirect to the pinterest page$/) do 
    visit 'https://www.pinterest.com/fashionxtonline/'
end

When (/^I click on the instagram icon on the bottom left corner$/) do
    visit root_path
end
Then (/^I should redirect to the instagram page$/) do 
    visit 'https://www.instagram.com/fashionxtonline/'
end

When (/^I click on the linkedin icon on the bottom left corner$/) do
    visit root_path
end
Then (/^I should redirect to the linkedin page$/) do 
    visit 'https://www.linkedin.com/company/fashionxt/'
end