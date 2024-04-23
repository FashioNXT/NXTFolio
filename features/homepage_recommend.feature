# Homepage Recommending Feature
# Feature: Recommending projects on homepage
#  As a fashion industry professional
#  I want to be able to see some recommending projects with high average rating.

#  Background: galleries in database




#    Given the following users exist
#    | name              | password  | job | city | state | highlights |
#    | Andrea.Picardo   | Test1234! | Model | Houston | TX | test |
    

#    Given the following galleries exist
#  | title | description | total  | id|  num|
#  | t10    | high1       | 20     |  1  | 4 |
#  | t20    | high2       | 20     |   2  | 4|
#  | t30    | low1        | 4     |   3  |  4|
#  | t40    | low2        | 4     |   4  |  4|
    

#  Scenario: When a user on the homepage, he should see some recommending projects
#    Given I am on the home page
#    And I should see "Projects you may be interested in:"
#    And I should see "t10"
#    And I should see "5"
#    And I should see "t20"
#    And I should see "5"

# Scenario: When a user on the homepage, he should not see some low-rating projects
#    Given I am on the home page
#    And I should see "Projects you may be interested in:"
#    And I should not see "t3"
#    And I should not see "1.0"
#    And I should not see "t4"
#    And I should not see "1.0"
    

