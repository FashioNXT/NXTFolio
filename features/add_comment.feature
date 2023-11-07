Feature: add a comment in a project
  As a valid collaborator with a project
  I want to add a comment in the project


  Background: galleries in database

  Given the following users exist
    | name              | password  | job | city | state | id | highlights |
    | Andrea.Picardo   | Test1234! | Model | Houston | TX | 2 | test | 
    | Anthony.Gray   | Test1234! | Model | Houston | TX | 3 | test | 
    | Emma.Watson   | Test1234! | Model | Houston | TX | 4 | test | 
    | John.Doe       | Test1234!  | Model | Houston | TX    | 5  | test      |
    | Jane.Smith     | Test1234!  | Model | Houston | TX    | 6  | test      |

  Given the following galleries for testing delete exist
  | title | description | total  | id|  num|
  | t1    | high1       | 20     |  2  | 4 |
  | t2    | high2       | 15    | 3  | 3   |
  | t3    | high3       | 10    | 4  | 2   |
  | t4    | high4       | 5     | 5  | 1   |
  | t5    | high5       | 2     | 6  | 0   |
  | t6    | high6       | 3     | 3  | 5   |

  Given the following tagging exist
  | gallery | user_id |
  | t1      | 4       |
  | t2      | 2       |
  | t3      | 2       |
  | t4      | 2       |
  | t5      | 2       |
  | t6      | 4       |

Scenario: User can view the add comment button in their gallery
  Given I am logged in as "Andrea.Picardo"
  Given I am a valid gallery user
  Given I am on the home page
  When I click on "t1"
  Then I should see "Enter a comment"

Scenario: Users can successfully submit a comment on their portfolio posting
  Given I am logged in as "Andrea.Picardo"
  Given I am a valid gallery user
  Given I am on the home page
  When I click on "t1"
  Then I should see "Enter a comment"
  And I click the "Enter a comment"
  Then I should be able to see the comment page
  When I fill in the comment box with details
  And I click on "Submit Comment" button
  And the new comment "Great work on this portfolio!" should be displayed
  
Scenario: Users cannot submit a blank comment on a portfolio posting
  Given I am logged in as "Andrea.Picardo"
  Given I am a valid gallery user
  Given I am on the home page
  When I click on "t1"
  Then I should see "Enter a comment"
  And I click the "Enter a comment"
  Then I should be able to see the comment page
  When I leave the comment box empty
  And I click on "Submit Comment" button
  And no new comment should be posted

Scenario: Non-collaborators cannot submit a comment on a portfolio posting
  Given I am logged in as "Anthony.Gray"
  Given I am a valid gallery user
  Given I am on the home page
  When I click on "t1"
  Then I should not see "Enter a comment"

Scenario: Collaborators can comment on a portfolio posting where they are tagged
  Given I am logged in as "Andrea.Picardo"
  Given I am a valid gallery user
  Given I am on the home page
  When I click on "t2"
  Then I should see "Enter a comment"

Scenario: Collaborators can comment on all portfolio postings if they are tagged in more than three projects
  Given I am logged in as "Andrea.Picardo"
  Given I am a valid gallery user
  Given I am on the home page
  When I click on "t1"
  Then I should see "Enter a comment"
  When I click on "t6"
  Then I should see "Enter a comment"


