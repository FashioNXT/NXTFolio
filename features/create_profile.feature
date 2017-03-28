# Create Profile Feature

Feature: Create a Profile

  As a fashion industry professional
  So that I can share my profile with other fashion industry professionals
  I want to add a profile to the FashioNXT: Match My Fashion database

Scenario: When signup button is clicked, a user fails to sign up for an account
  
  Given I am on the Match My Fashion home page
  When I click on Sign Up button
  And I fill in "email" text field with "test@gmail.com"
  And I fill in "password" text field with "password"
  And I fill in "password confirmation" text field with "notTheSamePassword"
  And I hit the Submit button
  Then I should see a message that says "Invalid Email or Password! Please try again."
  
Scenario: When signup button is clicked, a user is taken to sign up page
  
  Given I am on the Match My Fashion home page
  When I click on Sign Up button
  And I fill in "email" text field with "test@gmail.com"
  And I fill in "password" text field with "password"
  And I fill in "password confirmation" text field with "password"
  And I hit the Submit button
  Then I should see a message that says "Account Created!"
  
# Scenario: When a user signs up for an account, they go to the edit general information page

#   Given I have signed up for an account
#   When I fill in "first_name" text field with "Nabil"
#   And I fill in "last_name" text field with "Chris"
#   And I fill in "birth_month" text field with "Apr"
#   And I fill in "birth_day" text field with "20"
#   And I fill in "birth_year" text field with "1990"
#   And I fill in "gender" text field with "Male"
#   And I fill in "country" text field with "USA"
#   And I fill in "state" text field with "TX"
#   And I fill in "city" text field with "CStat"
#   And I fill in "compensation" text field with "Any"
#   And I fill in "facebook" text field with "www.facebook.com/Nabil"
#   And I fill in "instagram" text field with "Nabillioner"
#   And I fill in "website" text field with "www.Nabil.h.com"
#   And I fill in "bio" text field with "Hi, my name is Nabil and I am a hand model"
#   And I hit the Create Profile button
#   Then I should see a message that says "Signed up!"