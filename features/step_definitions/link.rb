Given(/^I am on the FashioNxt home page$/) do
    visit root_path
end

When (/^I click on about us link$/) do
    visit root_path
end    

Then (/^I should see the about us page of FashioNxt website$/) do
    visit 'https://fashionxt.com/agency/' 
end

When (/^I click on contact us link$/) do
    visit root_path
end

Then (/^I should see the contact us page of FashioNxt website$/) do
    visit 'https://fashionxt.com/contact/' 
end