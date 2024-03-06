Feature: Search a Profile with algorithm
  As a fashion industry professional
  I want to be able to search based on name, city, state, etc in a logic order

  # NXTFolio Spring 2023, Iteration 5
  Background: users in database
    Given the following users exist
    | name              | password  | job | city | state | highlights |
    | Andrea.Picardo   | Test1234! | Model | Houston | TX |  painting |
    | Leonardo.Picardo    | Test1234! | Model | Houston | TX | drawing |
    | Leonardo.Secondo   | Test1234! | Manufacturing | College Station | TX | able |
    | Andrea.Secondo    | Test1234! | Manufacturing | Columbus | OH |  painting |

    
    Scenario: When a user searches, the search result will list with same city/state/country first.
    Given I am logged in as "Andrea.Picardo" 
    And I am on the home page
    When I click on "Manufacturing"
    Then I should be on the search engine page
    And I should see "Leonardo Secondo" to the left of "Andrea Secondo"


    Scenario: When a user searches using keyword, the search result can match the profile's highlight info
    Given I am logged in as "Andrea.Picardo" 
    Given I am searching 
    When I fill in the following:
      | search               | painting  |

    Then I click the button with id "show_page_button"
    
    And I should see "Search Results:" 
    And I should see "Andrea Picardo" to the left of "Andrea Secondo"
    


    Scenario: When a user searches with empty parameters and no keyword, the page should render itself
    Given I am logged in as "Andrea.Picardo" 
    Given I am searching
    Then I click the button with id "show_page_button"
    And I should see "What are you looking for?" 

    # Scenario: When a user searches with keyword which is stop words, it should be no result
    # Given I am logged in as "Andrea.Picardo" 
    # Given I am searching 
    # When I fill in the following:
    #   | search               | able  |
    # Then I click the button with id "show_page_button"

    # And I should not see "Leonardo Secondo "

    # And I should see "No Results For This" 
