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
    Then I should see my gender
    Then I should see my last name
    When I press and go to edit profile
    Then I should be on the edit page
