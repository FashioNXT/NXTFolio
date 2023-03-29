Feature: Travel Feature
  As a professional
  I want to tag other users in my projects
  So that we can collaborate on projects

  Background: users in database
    Given the following users exist
    | name              | password  |
    | Andrea.Picardo    | Test1234! |
    | Anthony.Gray      | Test1234! |
    | Jack.Sparrow      | Test1234! |
    
    Given that 3 projects exist

  Scenario: I can add collaborators in my projects
    Given I am a professional and I am on my profile page
    And I want to add collaborators in one of my projects
    When I select other users name in the list for that project
    And I click on tag button
    Then I should be able to see collaborators added to my project

  Scenario: I can view collaborators of any project if they exist
    Given I am a professional
    And I visit profile page of some other user
    Then I can see their projects
    And the collaborators of their projects

  Scenario: I cannot add collaborators in projects of other users
   Given I am a professional and I am on profile page of some other user who has projects
   Then I should not be able to see the option to tag collaborators in their project

  Scenario: I cannot add collaborators in any project if I am not logged in
    Given I am a professional but not logged in
    Then I should not be able to see the option to tag collaborators in projects

   

   Scenario: I can invite unregistered people to be a collaborator on my project
    Given I am a professional with projects and I am on my project page
    And I want to add a collaborator who is not registered
    When I write their email in the invite users textbox
    And I click on tag button
    Then they should receive invitation mail
