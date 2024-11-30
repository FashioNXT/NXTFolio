Then("I should see an about me message saying {string}") do |text|
  expect(page).to have_selector("*", text: text, visible: :all)
end

# features/step_definitions/ai_user_bio_steps.rb
Then('the {string} button should be active') do |button_text|
  button = find_button(button_text)
  expect(button).to be_visible     # Check if the button is visible
  expect(button[:disabled]).to eq("false")  # Check if the button is enabled
end

