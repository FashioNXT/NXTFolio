# Search Profile Feature

Feature: Search a Profile

  As a fashion industry professional
  I want to be able to search professionals seeking jobs in the domain of fashion.
  I want to be able to search based on name, city, state, etc

  Scenario: When a user creates a profile, and I go to the search page to search, I can see the search results

    Given I am a valid user
    When I click on search button and search by email id
    Then I should see "No matches"
    When I click on search button and search by fields
    Then I should see "No matches"


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
  Scenario: When a user creates a profile, and I go to the search page to search, I can see the search results
    Given I am a valid user
    When I click on search button and search by fields
    Then I should see "No matches"
