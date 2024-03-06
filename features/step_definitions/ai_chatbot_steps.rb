Given(/^I am a content creator and I want to learn how to set up fashion portfolio$/) do
  visit "/chat"
end

When(/^I enter "Hi" message and click send$/) do
  fill_in "Type your message...", :with => "Hi"
  click_on "Send"
end

Then(/^I should see assistant's reply$/) do
  pending
  #expect(page).to have_content("Hello! How can I assist you today?")
end
