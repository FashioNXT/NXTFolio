# Search Profile Feature

Feature: Search a Profile

  As a fashion industry professional
  I want to be able to search professionals seeking jobs in the domain of fashion.
  I want to be able to search based on name, city, state, etc

  Scenario: When a user creates a profile, and I go to the search page to search, I can see the search results

    Given I am on the Match My Fashion home page
    When I sign up for an account
    Then I should see a message that says "Account Created!"
    And I should be on the general info page
    When I fill in "general_info_first_name" with "Avinash"
    When I fill in "general_info_last_name" with "Saxena"
    When I select "Jan" from "general_info_month_ofbirth"
    When I select "01" from "general_info_day_ofbirth"
    When I select "2000" from "general_info_year_ofbirth"
    When I select "Male" from "general_info_gender"
    When I select "United States" from "general_info_country"
    When I fill in "general_info_state" with "Texas"
    When I fill in "general_info_city" with "College Station"
    And press "Next"
    Then I should be on the designer information page
    And press "Submit"
   # When I go to search page


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