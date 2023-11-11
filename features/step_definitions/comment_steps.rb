  # Check
# Scenario: User can view the add comment button in their gallery
Given(/^I am logged in as (.*) (.*)$/) do |first_name, last_name|
  visit root_path
  click_on "Sign In"
  fill_in "Your Email", :with => first_name + "." + last_name + "@example.com"
  fill_in "Your Password", :with => "Test1234!"
  click_on "SIGN IN"
end

# Scenario: Users can successfully submit a comment on a portfolio posting
And("I click the {string}") do |string|
  # Example code to click the specified element
  click_link(string)
end

Then("I should be able to see the comment page") do
  # Example code to verify the comment page is displayed
  expect(page).to have_selector(".form-group") # Change the selector to match the comment form
end

When("I fill in the comment box with details") do
  # Example code to fill in the comment box
  find(".form-control").set("Great work on this portfolio!") # Change the selector to match the comment input field
end

# Then("I should be able to see the comment page") do
#   # Example code to verify the comment page is displayed
#   expect(page).to have_selector(".comment-input")
# end

# When("I fill in the comment box with details") do
#   # Example code to fill in the comment box
#   # fill_in(".comment-input", with: "Great work on this portfolio!")
#   find(".comment-input").set("Great work on this portfolio!")
# end

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
  # find(".comment-input").set("")
  find(".form-control").set("") # Change the selector to match the comment input field
end

# Then("I should see an error message {string}") do |string|
#   # Example code to verify the error message is displayed
#   expect(page).to have_content(string)
# end

And("no new comment should be posted") do
  # Example code to verify that no new comment is posted
  expect(page).not_to have_selector(".comment")
end

Given ("the following tagging exist") do |taggings|
  taggings.hashes.each do |tagging|
    tagged_id = tagging['user_id']
    gallery_name = tagging['gallery']

    gallery = Gallery.find_by(gallery_title: gallery_name)

    gallery_tagging = GalleryTagging.new(gallery_id: gallery.id, general_info_id: tagged_id)
    gallery_tagging.save!

    current_user_id = gallery.GeneralInfo_id

    if Collaboration.where(general_info_id: current_user_id, collaborator_id: tagged_id).empty?
      collab = Collaboration.new(general_info_id: current_user_id, collaborator_id: tagged_id)
      collab.save!
    end

    if Collaboration.where(general_info_id: tagged_id, collaborator_id: current_user_id).empty?
      collab = Collaboration.new(general_info_id: tagged_id, collaborator_id: current_user_id)
      collab.save!
    end
  end
end