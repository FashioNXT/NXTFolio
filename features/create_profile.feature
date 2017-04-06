# Create Profile Feature

Feature: Create a Profile

  As a fashion industry professional
  So that I can share my profile with other fashion industry professionals
  I want to add a profile to the FashioNXT: Match My Fashion database
  
Scenario: When a user attempts to create a profile, account creation is successful
  
  Given I am on the Match My Fashion home page
  When I sign up for an account
  Then I should see a message that says "Account Created!"
  And I should be on the general info page
  
Scenario: When a user attempts to create a profile, account creation fails
  
  Given I am on the Match My Fashion home page
  When I sign up for an account
  Then I should see a message that says "Invalid Password! Please try again."
  And I should be on the login page
  
Scenario: When a user creates an account, the general information page is submitted

  Given I have signed up for an account
  When I fill in all fields for general information
  And I select "Designer" or "Model" or "Photographer"
  Then I should see the designer page or model page or photographer page
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