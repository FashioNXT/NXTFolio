# Feature: Travel Feature
#  As a professional
#  I want to share my upcoming travel details
#  So that others can see my travel plans

#  Background: users in database
#    Given the following users exist
#    | name              | password  | job          | state | city            | highlights |
#    | Andrea.Picardo    | Test1234! | Model        | Texas | college station | test       |
#    | Anthony.Gray      | Test1234! | Photographer | Texas | college station | test1      |
#    | Jack.Sparrow      | Test1234! | Model        | Texas | college station | test2      |

#  Scenario: I can search based on travel information
#    Given I am a professional and want to add my travel information
#    And I want to add my travel information
#    When I click on "Edit Travel Info" from the menu
#    Then I should be able to see the travel info edit page

#    When I fill in the travel form with details
#    And I click on "SAVE and GO TO PROFILE" button

#    Then I go to search_engine_show
#    And I want to type in the search details 
#    Then I should click on the search button 
#    Then I should see "Anthony" in the search results

# when travel date is not within 30 days, search should not include this guy 
#  Scenario: I can search based on travel information 2
#    Given I am a professional and want to add my travel information
#    And I want to add my travel information
#    When I click on "Edit Travel Info" from the menu
#    Then I should be able to see the travel info edit page

#    When I fill in the travel form with new details
#    And I click on "SAVE and GO TO PROFILE" button

#    Then I go to search_engine_show
#    And I want to type in the search details 
#    Then I should click on the search button 
#    Then I should see "No matching profiles" in the search results

    