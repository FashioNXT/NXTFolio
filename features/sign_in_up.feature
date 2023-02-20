# Sign in and up Feature

Feature:
  As a fashion industry professional
  So that I can share my profile with other fashion industry professionals
  I want to create and login my account with Facebook or Google

  Scenario: When new user attempts to create an account, account should be successfully created
    Given I am on the landing page
    When I press "sign_in_up" button
    Then I should be directed to the "login" page
    # When I press "facebook" button # there is no facebook button
    Then I should be directed to the "new_general_info" page
    When I fill in "first_name" text field with "Nabil"
    And I fill in "last_name" text field with "Chris"
    And I fill in "birth_month" text field with "Apr"
    And I fill in "birth_day" text field with "20"
    And I fill in "birth_year" text field with "1990"
    And I fill in "gender" text field with "Male"
    And I fill in "country" text field with "USA"
    And I fill in "state" text field with "TX"
    And I fill in "city" text field with "CStat"
    And I fill in "compensation" text field with "Any"
    And I press "save_and_cont" button
    Then "Nabil" should be added to the GeneralInfo database


#Scenario: When new user attempts to create an account, account creation fails
#  Given I am on the landing page
#  When I follow "Sign in/up" button
#  And I press fashionxt logo
#  Then I should not be added to the GeneralInfo database

#Scenario: When existing user attempts to sign in, sign in successfully processes
#  Given I am on the landing page
#  When I follow "Sign in/up button
#  And I press "facebook" button
#  Then My username should appear in the landing page

#Scenario: When existing user attempts to sign in, sign in fails
#  Given I am on the landing page
#  When I follow "Sign in/up button
#  And I press "facebook" button
#  Then My username should appear in the landing page