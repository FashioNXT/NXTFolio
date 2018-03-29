# Search Professional Details Feature

Feature: Search Professional Details

  As a recruiter
  So that I can find professionals in the field I'm looking for
  I would like to search by profession and by details of that profession

Given I am a valid user
When I click on search button and search by profession
Then I should see "No matches"
When I click on search button and search by tags
Then I should see "No matches"

Given I am an invalid user
When I click on search butt
Then I should be on the login page