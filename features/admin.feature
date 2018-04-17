Feature: Add a new Profession Template

  As a website administrator, I want to create new templates
  So my users can select the appropriate profession

  Scenario: When logged in as admin, option to add template exists

    Given I am a valid admin user
    When I log in
    Then I should see "Logged In!"
    And I should be on the home page
    And I should see "Add Profession"
