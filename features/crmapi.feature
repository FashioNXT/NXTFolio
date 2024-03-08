#Feature: CRM API Feature
#  As the owner of NXTFolio
#  I want to see usage statistics of all users on website
#  So that I understand their interaction with my website.

#  Background: users in database
#    Given the following users exist
#    | name              | password  | job          | city | state | id | highlights |
#    | Andrea.Picardo    | Test1234! | Model        | Houston | TX | 1  | test |
#    | Anthony.Gray      | Test1234! | Photographer | College Station | TX | 2  | test |
#    | Jack.Sparrow      | Test1234! | Model        | Bryan | TX | 3  | test |
#    | James.Lawrence    | Test1234! | Model        | Houston | TX | 4  | test |

#  Scenario: I can view usage statistics
#    Given no usage statistics exist
#    When James Lawrence login to account
#    And perform some activities and logs out
#    When Andrea Picardo login to account
#    And perform some activities and logs out
#    When Jack Sparrow login to account
#    And perform some activities and logs out
#    When I visit /api/users page
#    Then I should see their usage time
