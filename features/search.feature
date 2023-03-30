# Search Profile Feature

Feature: Search a Profile
  As a fashion industry professional
  I want to be able to search professionals seeking jobs in the domain of fashion.
  I want to be able to search based on name, city, state, etc

  # NXTFolio Spring 2023, Iteration 2
  Background: users in database
    Given the following users exist
    | name              | password  | job |
    | Andrea.Picardo    | Test1234! | Model |
    | Leonardo.Picardo    | Test1234! | Model |
    | Leonardo.Secondo    | Test1234! | Photographer |
    | Andrea.Secondo    | Test1234! | Photographer |

  # NXTFolio Spring 2023, Iteration 2
  Scenario: When a user searches for Brand Owners when there are no profiles, it should see no matching profiles
    Given I am on the home page
    When I click on "Brand Owner"
    Then I should be on the search engine page
    And I should see "No matching profiles"

  # todo! delete into
  # NXTFolio Spring 2023, Iteration 2
  Scenario: When a user searches for Brand Owners when there are no profiles, it should see no matching profiles
    Given I am on the home page
    When I click on "Brand Owner"
    Then I should be on the search engine page
    And I should see "No matching profiles"

  # NXTFolio Spring 2023, Iteration 2
  Scenario: When a user searches for Photographer, it should show the photographers
    Given I am on the home page
    When I click on "Photographer"
    Then I should be on the search engine page
    And I should see "Leonardo Secondo"
    And I should see "Andrea Secondo"
    And I should not see "Andrea Picardo"
    And I should not see "Leonardo Picardo"

  # NXTFolio Spring 2023, Iteration 2
  Scenario: When a user searches for Model, it should show the models
    Given I am on the home page
    When I click on "Model"
    Then I should be on the search engine page
    And I should not see "Leonardo Secondo"
    And I should not see "Andrea Secondo"
    And I should see "Andrea Picardo"
    And I should see "Leonardo Picardo"


## commented because this is not a functionality

# Scenario: When a user creates a profile, and I go to the search page to search, I can see the search results
  #   Given I am a valid user
  #   When I click on search button and search by email id
  #   Then I should see "No matches"
  #   When I click on search button and search by fields
  #   Then I should see "No matches"

  # Scenario: When a user creates a profile, and I go to the search page to search, I can see the search results
  #   Given I am a valid user
  #   When I click on search button and search by fields
  #   Then I should see "No matches"

#  Scenario: When I go to the search page to search by model, I can see the search results
#    Given I am a valid user
#    When I select model
#    And I click on the search button
#    And I click on the search button
#    Then I should see "No matches"


#  Scenario: When a user attempts to create a profile, account creation fails
#
#    Given I am on the Match My Fashion home page
#    When I sign up for an account
#    Then I should see a message that says "Invalid Password! Please try again."
#    And I should be on the login page
#
#  Scenario: When a user creates an account, the general information page is submitted
#
#    Given I have signed up for an account
#    When I fill in all fields for general information
#    And I select "Designer" or "Model" or "Photographer"
#    Then I should see the designer page or model page or photographer page
