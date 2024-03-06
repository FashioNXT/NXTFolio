
Feature: Able to access the links on the buttom of home page
  
  As a user, I want to be able to access about us, contact us, job and help links
  
  Scenario: When logged in as user, 
    
    Given I am at FashioNxt home page

    When I click on about us link 
    Then I should see the about us page of FashioNxt website

    When I click on jobs link
    Then I should see the linkedin jobs page of FashioNxt 

    When I click on contact us link
    Then I should see the contact us page of FashioNxt website

    # When I click on what are you looking for link
    # Then I should redirect to search page

    # When I click on help link
    # Then I should see the help page of FashioNxt

    # When I click on the facebook icon on the bottom left corner
    # Then I should redirect to the facebook page 

    # When I click on the twitter icon on the bottom left corner
    # Then I should redirect to the twitter page 

    # When I click on the pinterest icon on the bottom left corner
    # Then I should redirect to the pinterest page 

    # When I click on the instagram icon on the bottom left corner
    # Then I should redirect to the instagram page 

    # When I click on the linkedin icon on the bottom left corner
    # Then I should redirect to the linkedin page 