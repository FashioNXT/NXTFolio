Feature: User Bio Generation

# NXTFolio Fall 2024, Iteration 2
Background: users in database
    Given the following users exist
    | name              | password  | job | city | state | id | highlights |
    | Andrea.Picardo    | Test1234! | Model | Houston | TX | 1  | test |
    | Anthony.Gray    | Test1234! | Model | College Station | TX | 2  |  test |

#Scenario: Successfully generate user bio
#  Given the user is on the "New Bio" page
#  When the user fills in "Profession" with "Graphic Designer"
#  And the user fills in "Experience Level" with "5 years"
#  And the user fills in "Keywords" with "Photoshop, Illustration"
#  And the user clicks "Generate Bio"
#  Then the API should generate a bio using the provided input
#  And the user should see the generated bio displayed on the "Edit Bio" page

#Scenario: Invalid user input for bio generation
#  Given the user is on the "New Bio" page
#  When the user submits the form without filling in "Profession"
#  Then the user should see an error message "Profession can't be blank"
#  And the form should remain on the "New Bio" page

#Scenario: API failure during bio generation
#  Given the user is on the "New Bio" page
#  When the user fills in "Profession" with "Graphic Designer"
#  And the user fills in "Experience Level" with "5 years"
#  And the user fills in "Keywords" with "Photoshop, Illustration"
#  And the API call fails or times out
#  Then the user should see an error message "Unable to generate bio. Please try again later."
#  And the user should remain on the "New Bio" page

#Scenario: Bio successfully updated
#  Given the user is on the "Edit Bio" page
#  And the user has received a generated bio
#  When the user makes changes to the bio
#  And the user clicks "Save Bio"
#  Then the bio should be successfully updated in the database
#  And the user should see a success message "Your bio has been updated!"
#  And the user should be redirected to the "Profile" page

Scenario: Should See AI Enhance Button
  Given I am logged in as "Andrea.Picardo"
  And I am on general_info_edit2
  Then I should see "Enhance with AI"

Scenario: Should See AI Enhance Button
  Given I am logged in as "Anthony.Gray"
  And I am on general_info_edit2
  And I press "Enhance with AI"
  Then I should see "AI Response:"

