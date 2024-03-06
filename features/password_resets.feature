Feature: Password Resets

  Scenario: Requesting a password reset email for an existing user
    Given I am a valid user
    When I visit the password reset page
    And I enter my email "hellofriend@gmail.com" for password reset
    And I submit the password reset form
    Then I should see a success message
    And an email should be sent to "hellofriend@gmail.com" with a password reset link

# Scenario: Resetting the password with a valid token
# Given I have received a password reset email with a valid token
#  When I click the password reset link in the email
#  And I enter a new password "new_password"
#  And I submit the password reset form
#  Then I should see a success message
#  And my password should be updated

Scenario: Resetting the password with an invalid token
  Given I have received a password reset email with an invalid token
  When I click an invalid password reset link in the email
  Then I should see an error message

