# Login Feature

Feature: Login to Application

  As a fashion industry professional
  So I can login to application
  I want to enter a correct email address and password combination
  
Scenario: When correct login information is entered a user logs in successfully

  Given I am a valid user
  When I go to the login page
#   And I fill in "email" field with "hellofriend@gmail.com"
#   And I fill in "password" field with "password123"
  And I press login button
  Then I should see a confirmation alert
  And I should be on the Match My Fashion home page
  
Scenario: When incorrect login information is entered, a user cannot log in

  Given I am an invalid user
  When I go to the login page
#   And I fill in "email" field with "hellofriend@gmail.com"
#   And I fill in "password" field with "password"
  And I press login button
  Then I should see a warning
  And I should be on the login page