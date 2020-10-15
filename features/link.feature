Feature: Able to access the links on the buttom of home page
  
  As a user, I want to be able to access about us, contact us, job and help links
  
  Scenario: When logged in as user, 
    
    Given I am on the FashioNxt home page
    When I click on about us link 
    Then I should see the about us page of FashioNxt website
    When I click on contact us link
    Then I should see the contact us page of FashioNxt website
  #  When I click on jobs link
  #  Then I should see the linkedin jobs page of FashioNxt 
  #  When I click on help link
  #  Then I should see the help page of FashioNxt