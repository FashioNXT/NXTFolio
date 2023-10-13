  # Check
# Scenario: User can view the add comment button in their gallery
Given(/^I am logged in as (.*) (.*)$/) do |first_name, last_name|
  visit root_path
  click_on "Sign In"
  fill_in "Your Email", :with => first_name + "." + last_name + "@example.com"
  fill_in "Your Password", :with => "Test1234!"
  click_on "SIGN IN"
end
  
Given("I am a valid gallery user") do
  # Example code to set up a valid gallery user
  create_gallery_user
end

Given("I am on the home page") do
  # Example code to visit the home page
  visit_home_page
end

When(/^I click on "(.*?)"$/) do |element|
  # Example code to click on the specified element
  click_on_element(element)
end

Then(/^I should see "(.*?)"$/) do |text|
  # Example code to check if the specified text is visible
  expect(page).to have_content(text)
end

# Scenario: Users can successfully submit a comment on a portfolio posting
And("I click the {string}") do |string|
  # Example code to click the specified element
  click_element(string)
end

Then("I should be able to see the comment page") do
  # Example code to verify the comment page is displayed
  expect(page).to have_selector(".comment-page")
end

When("I fill in the comment box with details") do
  # Example code to fill in the comment box
  fill_in("comment_box", with: "Great work on this portfolio!")
end

And("I click on {string} button") do |string|
  # Example code to click on the specified button
  click_button(string)
end

And("the new comment {string} should be displayed") do |string|
  # Example code to verify the new comment is displayed
  expect(page).to have_content(string)
end

When("I leave the comment box empty") do
  # Example code to leave the comment box empty
  fill_in("comment_box", with: "")
end

Then("I should see an error message {string}") do |string|
  # Example code to verify the error message is displayed
  expect(page).to have_content(string)
end

And("no new comment should not be posted") do
  # Example code to verify that no new comment is posted
  expect(page).not_to have_selector(".comment")
end
