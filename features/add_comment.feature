Feature: add a comment in a project
  As a valid collaborator with a project
  I want to add a comment in the project


  Background: galleries in database

  Given the following users exist
    | name              | password  | job | city | state | id | highlights |
    | Andrea.Picardo   | Test1234! | Model | Houston | TX | 2 | test | 

  Given the following galleries for testing delete exist
  | title | description | total  | id|  num|
  | t1    | high1       | 20     |  2  | 4 |


   Given the following galleries exist
  | title | description | total  | id|  num|
  | t2    | high2       | 20     |   2  | 4|

Scenario: Users can successfully submit a comment on a portfolio posting
  Given I am a logged-in user on a portfolio posting page
  And there is a comment box and a submit button
  When I fill in the comment box with "Great work on this portfolio!"
  And I click the "Submit Comment" button
  Then I should see a success message "Comment submitted successfully"
  Then I should be on the home page
  And the new comment "Great work on this portfolio!" should be displayed

Scenario: Users cannot submit an empty comment on a portfolio posting
  Given I am a logged-in user on a portfolio posting page
  And there is a comment box and a submit button
  When I leave the comment box empty
  And I click the "Submit Comment" button
  Then I should see an error message "Comment cannot be empty"
  And the comment should not be posted

