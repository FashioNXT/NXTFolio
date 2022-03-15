Given('I am on the new appointment page') do
  visit new_appointment_path
end

When('I fill in {string} for {string}') do |value, field|
  fill_in(field, with: value)
end

When('I press {string}') do |button|
  click_button(button)
end

Then('I should see {string}') do |text|
  expect(page).to have_content(text)
end

When('I select {string} as the {string} date and time') do |datetime, selector|
  select_datetime(datetime, from: selector)
end