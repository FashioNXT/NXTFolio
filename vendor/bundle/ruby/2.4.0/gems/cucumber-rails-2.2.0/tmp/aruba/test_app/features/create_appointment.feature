@javascript
Feature: Create appointments
  Scenario: Visit the Constitution on May 17
    Given I am on the new appointment page
    And I fill in "Norway's constitution" for "Name"
    And I select "2015-02-20 15:10:00 UTC" as the "When" date and time
    And I press "Create Appointment"
    Then I should see "Norway's constitution"
    And I should see "2015-02-20 15:10:00 UTC"