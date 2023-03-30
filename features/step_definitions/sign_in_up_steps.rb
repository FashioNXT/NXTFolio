
# Create Profile Step Definitions

# Given(/^I am on the landing page$/) do
#   visit root_path
# end

When(/^I fill in "([^"]*)" text field with "([^"]*)"$/) do |field, value|
  fill_in(field, :with => value)
end

# Then(/^I should be directed to the "([^"]*)" page$/) do |page_name|
#   visit path_to(page_name)
#   current_path = URI.parse(current_url).path
#   expect(current_path).to eq(path_to(page_name))
# end

Then(/^"([^"]*)" should be added to the GeneralInfo database$/) do |firstname|
  expect(GeneralInfo.exists?(:first_name => firstname)).to be(true)
  GeneralInfo.find_by(first_name: firstname).destroy
end

Then(/^"([^"]*)" should not be added to the GeneralInfo database$/) do |firstname|
  expect(GeneralInfo.exists?(:first_name => firstname)).to be(false)
end
