
# Create Profile Step Definitions

Given(/^I am on the landing page$/) do
  visit root_path
end

And(/^I fill in "([^"]*)" text field with "([^"]*)"$/) do |field, value|
  fill_in(field, :with => value)
end

And(/^I press "([^"]*)" button$/) do |button|
  click_link_or_button(button)
end

Then(/^I should be directed to the "([^"]*)" page$/) do |page_name|
  visit path_to(page_name)
  current_path = URI.parse(current_url).path
  expect(current_path).to eq(path_to(page_name))
end
Then(/^"([^"]*)" should be added to the GeneralInfo database$/) do |firstname|
  expect(GeneralInfo.exists?(:first_name => firstname)).to be(true)
end