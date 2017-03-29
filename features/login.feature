# Login Feature

Feature: Login to Application

  As a fashion industry professional
  So I can login to application
  I want to enter a correct email address and password combination
  
Scenario: When correct login information is entered a user logs in successfully

  Given I am a valid user
  When the user logs in 
  Then the user should see "Logged In!"
  And I should be on the Match My Fashion home page
  
Scenario: When incorrect login information is entered, a user cannot log in

  Given I am an invalid user
  When the user tries to log in
  Then the user should see "Incorrect Password" or "Incorrect Email"
  And I should be on the login page