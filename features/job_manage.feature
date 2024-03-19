#Feature: Job Manage 
#  As a professional
#  I want to manage jobs  

#  Background: users in database
#    Given the following users exist
#    | name              | password  | job          | state | city            | highlights |
#    | Andrea.Picardo    | Test1234! | Model        | Texas | college station | test1 | 
#    | Anthony.Gray      | Test1234! | Photographer | Texas | college station | test2 |
#    | Jack.Sparrow      | Test1234! | Model        | Texas | college station | test |

#  Scenario: I can delete job 
#    Given I am a professional and want to post a new job 
#    And I want to go to the jobs page 
#    When I click on "Post Job" from the menu
#    When I fill in the job posting form with details
#    And I click on "SAVE and Post Job" button
#    And I want to go to the job management page 
#    And I want to see more infos of one specific job 
#    And I want to delete the specific job 
#    Then I should not see "test edit job title"
  
#  Scenario: I can access job posting page 
#    Given I am a professional and want to post a new job 
#    And I want to go to the jobs page 
#    When I click on "Post Job" from the menu
#    Then I should be able to see the job posting page
#    When I fill in the job posting form with details
#    And I click on "SAVE and Post Job" button
#    Then I should see job post success message

  # show all the jobs 
  #  And I want to go to the job management page 
  #  Then I should see all the jobs that I posted 

  # check details of one job 
  #  And I want to see more infos of one specific job 

  # edit the job 
    # And I want to edit the infos of the specific job 
    # And I enter the new infos of the specific job 
    # Then I should see the job's info is updated

  




