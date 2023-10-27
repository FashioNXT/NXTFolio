Given(/^I am a content creator and I want to learn how to set up fashion portfolio$/) do
  visit root_path
end

And(/^I want to go to the ai chatbot page$/) do
  click_on "AI Chatbot"
end

When(/^I enter "Hi" message and click send$/) do
  fill_in "Type your message...", :with => "Hi"
  click_on "Send"
end

Then(/^I should see assistant's reply$/) do
  expect(page).to have_content("Hello! How can I assist you today?")
end
