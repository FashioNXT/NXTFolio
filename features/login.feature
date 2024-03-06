# Login Feature

# Feature: Login to Application

#  As a fashion industry professional
#  So I can login to application
#  I want to enter a correct email address and password combination
  
# Scenario: When correct login information is entered a user logs in successfully

#  Given I am a valid user
#  When I log in
#  Then I should see "Logged In!"
#  And I should be on the home page

# Scenario: When incorrect password is entered, a user cannot log in

#  Given I am not logged in
#  And I am on the home page
#  When I follow "Login"
#  And I fill in "email" with "hellofriend@gmail.com"
#  And I fill in "password" with "notmypassword"
#  And I press "Login"
#  Then I should see "Incorrect Password"
  
# Scenario: When incorrect email is entered, a user cannot log in

#  Given I am not logged in
#  And I am on the home page
#  When I follow "Login"
#  And I fill in "email" with "test"
#  And I press "Login"
#  Then I should see "Incorrect Email"
  