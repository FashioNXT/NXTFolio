Feature: Travel Feature
  As a professional
  I want to share my upcoming travel details
  So that others can see my travel plans

  Scenario: I can save my travel details
    Given I am a professional and want to add my travel information
    And I want to add my travel information
    When I click on "Edit Travel Info" from the menu
    Then I should be able to see the travel info edit page
    When I fill in the travel form with details
    And I click on "SAVE and GO TO PROFILE" button
    Then I should see my travel details on my profile page
    And my travel details should include "United States, Washington, Seattle, 2023-04-01, 2023-05-01, Attending a conference. Reach out to me!"