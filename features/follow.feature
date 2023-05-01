Feature: Follow Feature

  Background: users in database
    Given the following users exist
    | name              | password  | job          | city | state | id |
    | Andrea.Picardo    | Test1234! | Model        | Houston | TX | 1  |
    | Anthony.Gray      | Test1234! | Photographer | College Station | TX | 2  |
    | Jack.Sparrow      | Test1234! | Model        | Bryan | TX | 3  |
    | James.Lawrence    | Test1234! | Model        | Houston | TX | 4  |
    
  Scenario: I can follow other users
    Given I am logged in as Anthony Gray
    And I visit the profile page of James Lawrence
    And I am not currently following James Lawrence
    When I click on the Follow button
    Then I should be added to the followers list of James Lawrence

  Scenario: I can unfollow other users
    Given I visit the profile page of James Lawrence
    And I am currently following James Lawrence
    When I click on the Unfollow button
    Then I should be removed from the followers list of James Lawrence


    
