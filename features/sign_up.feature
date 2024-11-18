Feature: Sign up
  As a fashion industry professional
  So that I can create an account and share my profile
  I want to sign up with my email

  Background: users and countries in the database
    Given the following users exist
      | name           | password  | job   | city   | state | id | highlights |
      | Andrea.Picardo | Test1234! | Model | Austin | Texas | 0  | test       |
    And the following countries exist
      | country       | state | city   |
      | United States | Texas | Austin |

    @javascript
  Scenario: New user successfully creates an account with email confirmation
    Given I am on the signup page
    When I fill in the following:
    | user[email]                 | test@example.com |
    | user[password]              | Test1234!        |
    | user[password_confirmation] | Test1234!        |
    
    And I click on "Sign up"
    And I store the email "test@example.com" for later verification
    Then I should see an email confirmation message
    And I should receive a confirmation email with a link to confirm my account
    When I follow the email confirmation link
    Then I should be on new_general_info
    When I fill in the following:
      | first_name | Test        |
      | last_name  | Testable    |
      | company    | Test Inc    |
      | highlights | Detail-oriented professional |
      | emailaddr  | test@example.com |
      | city       | Austin      |
    And I select "Creator" from "general_info_industry"
    And I select "Designer" from "general_info_job_name"
    And I select "United States" from "country"
    And I select "Texas" from "state"
    And I click on "SAVE AND CONTINUE"
    Then I should be on the second signup page
    When I fill in the following:
      | specialization | some specialization |
      | profdetails    | some profdetails    |
      | bio            | some bio            |
      | experience     | 5                   |
    And I select "Salary" from "general_info_compensation"
    And I click on "SAVE and GO TO PROFILE"
    Then I should be on the profile page
    And "Test" should be added to the GeneralInfo database