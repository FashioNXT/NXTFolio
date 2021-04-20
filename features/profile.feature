# Profile Feature

Feature: See a Profile

  As a user
  I want to be able to see my profile page

  Scenario: When a user creates a profile, and I go to the profile page, I can see my profile informations

    Given I am on the home page
    Given I am a valid user
    When I log in
    Then I should be on the home page
    When I press and go to my profile
    Then I should see my first name
    When I press and go to edit profile
    Then I should be on the edit page


#  Scenario: When a user attempts to create a profile, account creation fails
#
#    Given I am on the Match My Fashion home page
#    When I sign up for an account
#    Then I should see a message that says "Invalid Password! Please try again."
#    And I should be on the login page
#
#  Scenario: When a user creates an account, the general information page is submitted
#
#    Given I have signed up for an account
#    When I fill in all fields for general information
#    And I select "Designer" or "Model" or "Photographer"
#    Then I should see the designer page or model page or photographer page
