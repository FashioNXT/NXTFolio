# Sign in and up Feature

Feature: Login and sign up
  As a fashion industry professional
  So that I can share my profile with other fashion industry professionals
  I want to create and login my account with Facebook or Google

  Background: users in database
    Given the following users exist
    | name              | password  | job | city | state | id | highlights |
    | Andrea.Picardo    | Test1234! | Model | Austin | Texas | 0 | test |
    And the following countries exist
    | country | state  | city |
    | United States | Texas  | Austin |

  # NXTFolio Spring 2023, Iteration 2
  Scenario: When I press log in button I should be redirected to login page
    Given I am on the home page
    When I click on "Sign In"
    Then I should be on the login page

  # NXTFolio Spring 2023, Iteration 2
  # Scenario: When new user attempts to create an account, account should be successfully created
  #   Given I am on the sign_up page
  #   When I fill in the following:
  #     | sign_up_email              | test@example.com  |
  #     | sign_up_password    | Test1234! |
  #     |   sign_up_confirm    |  Test1234!     |
  #   And I click on "SIGN UP"
  #   Then I should be on new_general_info
  #   When I fill in the following:
  #     | first_name | Test |
  #     | last_name | Testable |
  #     | company | Testing For Test |
  #     | highlights | Not much |
  #     | emailaddr | test@example.com |
  #     | city | Austin |
  #   And I select "Creator" from "general_info_industry"
  #   And I select "Designer" from "general_info_job_name"
  #   And I select "United States" from "country"
  #   And I select "Texas" from "state"
  #   # And I select "Austin" from "city"
  #   And I click on "SAVE AND CONTINUE"
  #   And I will be on the second signup page
  #   When I fill in the following:
  #     |specialization| some specialization|
  #     |profdetails| some profdetails|
  #     |bio| some bio|
  #     |experience| 5|
  #   And I select "Salary" from "general_info_compensation"
  #   And I click on "SAVE and GO TO PROFILE"
  #   Then I should be on the profile page
  #   And "Test" should be added to the GeneralInfo database

  # NXTFolio Spring 2023, Iteration 2
  # Scenario: When new user does not fill all fields, submit has an error but keeps text fields
  #   Given I am on the sign_up page
  #   When I fill in the following:
  #     | sign_up_email              | test@example.com  |
  #     | sign_up_password    | Test1234! |
  #     |   sign_up_confirm    |  Test1234!     |
  #   And I click on "SIGN UP"
  #   Then I should be on new_general_info
  #   When I fill in the following:
  #     | first_name | Test |
  #     | last_name | Testable |
  #     | company | Testing For Test |
  #     | highlights | Not much |
  #     | emailaddr | test@example.com |
  #   And I click on "SAVE AND CONTINUE"
  #   Then I should be on new_general_info
  #   And "Test" should not be added to the GeneralInfo database
  #   And should see the following fields:
  #     | first_name | Test |
  #     | last_name | Testable |
  #     | company | Testing For Test |
  #     | highlights | Not much |
  #     | emailaddr | test@example.com |

  # NXTFolio Spring 2023, Iteration 2
  # Scenario: When new user attempts to create an account with existing email, account creation should fail
  #   Given I am on the sign_up page
  #   When I fill in the following:
  #     | sign_up_email               | Andrea.Picardo@example.com  |
  #     | sign_up_password            | Test1234! |
  #     | sign_up_confirm             |  Test1234!     |
  #   And I click on "SIGN UP"
  #   Then I should be on the sign_up page 
  #   And I should see "Email already exists"

    # NXTFolio Fall 2023, Iteration 5
  # Scenario: When new user attempts to create an account with Invalid email format, account creation should fail
  #  Given I am on the login page
  #  When I fill in the following:
  #    | sign_up_email               | Andrea.Picardo.example.com  |
  #    | sign_up_password            | Test1234! |
  #    | sign_up_confirm             |  Test1234!     |
  #  And I click on "SIGN UP"
  #  Then I should be on the home page 
  #  And I should see "Failed Saving beause Email/Password format is not valid !"

    # NXTFolio Fall 2023, Iteration 5
  # Scenario: When new user attempts to create an account with different passwords, account creation should fail
  #  Given I am on the login page
  #  When I fill in the following:
  #    | sign_up_email               | Andrea.Picardo.example.com  |
  #    | sign_up_password            | Test1234! |
  #    | sign_up_confirm             |  Test1234     |
  #  And I click on "SIGN UP"
  #  Then I should be on the home page 
  #  And I should see "Passwords don't match! Please try again."
  
  # NXTFolio Fall 2023, Iteration 5
  # Scenario: When new user attempts to create an account with unentered passwords, account creation should fail
  #  Given I am on the login page
  #  When I fill in the following:
  #    | sign_up_email               | Andrea.Picardo.example.com  |
  #    | sign_up_password            |  |
  #    | sign_up_confirm             |       |
  #  And I click on "SIGN UP"
  #  Then I should be on the home page 
  #  And I should see "Enter your password! Please try again."

  # NXTFolio Spring 2023, Iteration 2
  Scenario: When existing user attempts to sign in with correct password, sign in successfully processes
    Given I am on the login page
    When I fill in the following:
      | login_email               | Andrea.Picardo@example.com  |
      | login_password            | Test1234! |
    And I click on "SIGN IN"
    Then I should be on the home page
    And I should see "You Have Successfully Logged In"
    And I should see "My Profile"

  # NXTFolio Spring 2023, Iteration 2
  Scenario: When existing user attempts to sign in with incorrect password, sign in successfully processes
    Given I am on the login page
    When I fill in the following:
      | login_email               | Andrea.Picardo@example.com  |
      | login_password            | Test1234fda!                |
    And I click on "SIGN IN"
    Then I should be on the login_info login page
    And I should see "The Credentials You Provided Are Not Valid"
    And I should not see "Andrea"

  # NXTFolio Fall 2023, Iteration 5
  Scenario: When existing user attempts to edit his password, editing successfully processes
    Given I am on the login page
    When I fill in the following:
      | login_email               | Andrea.Picardo@example.com  |
      | login_password            | Test1234! |
    And I click on "SIGN IN"
    Then I should be on the home page
    And I should see "You Have Successfully Logged In"
    And I should see "My Profile"
    And I click on "My Profile"
    When I move to Edit Profile and select Change Password
    Then I should land on the Change Password page
    When I fill in the following:
      | login_info_password               | Test1234fda!!  |
      | login_info_password_confirmation            | Test1234fda!!                |
    And I click on "SAVE"
    Then I should be on the profile page

  # NXTFolio Fall 2023, Iteration 5
  Scenario: When existing user attempts to edit his password, and does not provide matching passwords, edit is not successful
    Given I am on the login page
    When I fill in the following:
      | login_email               | Andrea.Picardo@example.com  |
      | login_password            | Test1234! |
    And I click on "SIGN IN"
    Then I should be on the home page
    And I should see "You Have Successfully Logged In"
    And I should see "My Profile"
    And I click on "My Profile"
    When I move to Edit Profile and select Change Password
    Then I should land on the Change Password page
    When I fill in the following:
      | login_info_password               | Test1234fda!!  |
      | login_info_password_confirmation            | Test1234fda!!!                |
    And I click on "SAVE"
    Then I should see "Passwords don't match!"

  #Scenario: When new user attempts to create an account, account creation fails
  #  Given I am on the landing page
  #  When I follow "Sign in/up" button
  #  And I press fashionxt logo
  #  Then I should not be added to the GeneralInfo database

  #Scenario: When existing user attempts to sign in, sign in fails
  #  Given I am on the landing page
  #  When I follow "Sign in/up button
  #  And I press "facebook" button
  #  Then My username should appear in the landing page
