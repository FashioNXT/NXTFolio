Feature: User Bio Generation

# NXTFolio Fall 2024, Iteration 2
Background: users in database
    Given the following users exist
    | name              | password  | job | city | state | id | highlights |
    | Andrea.Picardo    | Test1234! | Model | Houston | TX | 1  | test |
    | Anthony.Gray    | Test1234! | Model | College Station | TX | 2  |  test |

Scenario: Should See AI Enhance Button
  Given I am logged in as "Andrea.Picardo"
  And I am on general_info_edit2
  Then I should see "Generate About Me"
  Then the "Generate About Me" button should be active

#Scenario: Should See AI Enhance Button
#  Given I am logged in as "Anthony.Gray"
#  And I am on general_info_edit2
#  And I press "Generate About Me"
#  Then I should see an about me message saying "About Me generated successfully"

