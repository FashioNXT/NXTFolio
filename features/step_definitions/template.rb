# Create Profile Step Definitions

Given(/^I am on the home page$/) do
    visit root_path
end

Then(/^I should be able to visit Template page$/) do
  visit '/template'
end

Then(/^I should see a message "(.*?)"$/) do |message|
  case message
    when "ADD A NEW PROFESSION"
      page.has_content?('ADD A NEW PROFESSION')
  end
end