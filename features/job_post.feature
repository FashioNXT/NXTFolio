#Feature: Job Post 
#  As a professional
#  I want to post a new job 
#  So that others can see the new posted job 

#  Background: users in database
#    Given the following users exist
#    | name              | password  | job          | state | city            | highlights |
#    | Andrea.Picardo    | Test1234! | Model        | Texas | college station | test1 | 
#    | Anthony.Gray      | Test1234! | Photographer | Texas | college station | test2 |
#    | Jack.Sparrow      | Test1234! | Model        | Texas | college station | test |

#  Scenario: I can access job posting page 
#    Given I am a professional and want to post a new job 
#    And I want to go to the jobs page 
#    When I click on "Post Job" from the menu
#    Then I should be able to see the job posting page
#    When I fill in the job posting form with details
#    And I click on "SAVE and Post Job" button
#    Then I should see job post success message
