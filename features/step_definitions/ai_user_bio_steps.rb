Then("I should see an about me message saying {string}") do |text|
  expect(page).to have_selector("*", text: text, visible: :all)
end
