Feature: Travel Feature
  As a professional
  I want to tag other users in my projects
  So that we can collaborate on projects

  Background: users in database
    Given the following users exist
    | name              | password  | job          |
    | Andrea.Picardo    | Test1234! | Model        |
    | Anthony.Gray      | Test1234! | Photographer |
    | Jack.Sparrow      | Test1234! | Model        |
    | James.Lawrence    | Test1234! | Model        |
    
    Given that 3 projects exist

  
  Scenario: I can see collaborated projects on other users profile
    Given I am a professional and I am on my profile page
    When I add James Lawrence as collaborator in my project
    And I visit their profile
    Then I should see my project in their collaborated projects
