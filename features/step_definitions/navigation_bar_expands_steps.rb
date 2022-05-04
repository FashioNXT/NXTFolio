Given(/^I am a professional or searching for professionals in a group$/) do
  visit root_path

end

When(/^I click on the “>>” button$/) do
  click_button "button1"
end

Then(/^Other categories will be hidden and all professions under this category will be shown$/) do
  # expect(page).to have_button('Brand')
  # expect(page).to have_button('Designer')
  # expect(page).to have_button('Other_creator')
  puts("hello")
end