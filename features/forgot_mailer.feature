Feature: Forgot and Reset Password

  Background: users in database
    Given the following users exist
    | name              | password  | job          | city | state | id | highlights |
    | Andrea.Picardo    | Test1234! | Model        | Houston | TX | 1  | test |
    | Anthony.Gray      | Test1234! | Photographer | College Station | TX | 2  | test |
    | Jack.Sparrow      | Test1234! | Model        | Bryan | TX | 3  | test |
    | James.Lawrence    | Test1234! | Model        | Houston | TX | 4  | test |
    
  Scenario: I forgot my password and want to reset
    Given I want to reset my password
    When I fill in the email
