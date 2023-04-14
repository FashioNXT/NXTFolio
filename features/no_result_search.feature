# Search when no matching profile

Feature: Search a Profile
  As a fashion industry professional
  I want to be able to search professionals seeking jobs in the domain of fashion.
  I want to be able to search based on name, city, state, etc

  # NXTFolio Spring 2023, Iteration 2
  Background: users in database
    Given the following users exist
    | name              | password  | job | city | state |
    | Andrea.Picardo   | Test1234! | Model | Houston | TX |
    | Leonardo.Picardo    | Test1234! | Model | Houston | TX |
    | Leonardo.Secondo   | Test1234! | Manufacturing | College Station | TX |
    | Andrea.Secondo    | Test1234! | Manufacturing | Columbus | OH |
  # NXTFolio Spring 2023, Iteration 3
  Scenario: When a user searches for Brand Owners when there are no profiles, it should see no matching profiles and some recommend proflies
    When I am a valid user
    Given I am on the home page
    When I click on "Brand Owner"
    Then I should be on the search engine page
    And I should see "You May Also Like:"

    And I should see "Andrea Picardo"
    And I should see "Leonardo Picardo"
    And I should see "Leonardo Secondo"
    And I should not see "Andrea Secondo"
    And I should see "No matching profiles"

  
  #Scenario: When a user searches for Brand Owners when there are no profiles, it should see no matching profiles
    #Given I am on the home page
    #When I click on "Brand Owner"
    #Then I should be on the search engine page
    #And I should see "You May Also Like:"
    #And I should see "No matching profiles"

  