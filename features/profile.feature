# Profile Feature

Feature: See a Profile

  As a user
  I want to be able to see my profile page

    Background: users in database
    Given the following users exist
    | name              | password  | job          | state | city            | highlights |
    | Andrea.Picardo    | Test1234! | Model        | Texas | college station | test1 | 
    | Anthony.Gray      | Test1234! | Photographer | Texas | college station | test2 |
    | Jack.Sparrow      | Test1234! |        | Texas | college station | test |

#   Scenario: When a user creates a profile, and I go to the profile page, I can see my profile informations

#     Given I am at the profile page
#     Given I am a valid user
# # <<<<<<< HEAD
# #    When I log in
# #    Then I should be on the home page
# #    When I press and go to my profile
# #    Then I should be on the profile page
#     # When I press and go to edit profile
#     # Then I should be on the edit page


# #  Scenario: When a user attempts to create a profile, account creation fails
# #
# #    Given I am on the Match My Fashion home page
# #    When I sign up for an account
# #    Then I should see a message that says "Invalid Password! Please try again."
# #    And I should be on the login page
# #
# #  Scenario: When a user creates an account, the general information page is submitted
# #
# #    Given I have signed up for an account
# #    When I fill in all fields for general information
# #    And I select "Designer" or "Model" or "Photographer"
# #    Then I should see the designer page or model page or photographer page
#     When I log in
#     Then I should be on the home page
#     When I press and go to my profile
#     Then I should see my first name
#     Then I should see my gender
#     Then I should see my last name
#     # When I press and go to edit profile
#     # Then I should be on the edit page
# # =======
#     When I log in
#     Then I should be on the home page
#     When I press and go to my profile
#     Then I should see my first name
#     Then I should see my gender
#     Then I should see my last name
#     # When I press and go to edit profile
#     # Then I should be on the edit page
# # >>>>>>> test case fix


# Scenario: When a user creates a profile, and I go to the profile page, I can see my profile informations

    # Given I am at the profile page
    # Given I am a valid user
    # When I press and go to edit profile
    # Then I should be on the edit page

#    Given I am logged in as "Andrea.Picardo"
#    Then I should be on the home page
#    When I press and go to my profile
#    # Then I should see my first name
#    # Then I should see my gender
#    # Then I should see my last name
#    When I press and go to edit profile
#    Then I should be on the edit page


Scenario: Profile without job name
    Given I am logged in as "Jack.Sparrow"

Scenario: User can delete gallery
    Given I am logged in as "Andrea.Picardo"
    Given I am a valid gallery user
    Then I should be on the home page
    When I press and go to my profile
    Then I should see delete option
    Then I delete my gallary


# Scenario: Profile with specific_profile_id
#     # Given I am logged in as "Andrea.Picardo"
#     Given I am a valid user with specific_profile_id one
#     # When I log in
#     Then I should be on the home page
#     When I press and go to my profile
