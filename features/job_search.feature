Feature: Job Search 
  As a professional
  I want to search for jobs based on keywords, profession and location information
  So that relevant jobs show up and irrelevant ones do not

  Background: users in database
    Given the following users exist
    | name              | password  | job          | state | city            | highlights |
    | Andrea.Picardo    | Test1234! | Model        | Texas | college station | test1 | 
    | Anthony.Gray      | Test1234! | Photographer | Texas | college station | test2 |
    | Jack.Sparrow      | Test1234! | Model        | Texas | college station | test |

    Given the following jobs exist
    | title   | description  | category   | profession | country    | state | city | low_salary | high_salary |
    | Model 1 | Male model | Services | Model | United States | Iowa | Iowa City | 1000 | 2000 |
    | Model 2 | Female model | Services | Model | United States | Iowa | Iowa City | 1000 | 2000 |
    | Model 3 | Female model | Services | Model | United States | Texas | Houston | 1000 | 2000 |
    | Photographer 1 | Photographer for animals, e.g. cats, dogs, etc.  | Services | Photographer | United States | Texas | Houston | 1000 | 2000 |
    | Photographer 2 | Photographer for children  | Services | Photographer | United States | Texas | Houston | 1000 | 2000 |

    Scenario: When a user searches with empty keyword and none of the options is selected, then all existing jobs show up
        Given I am logged in as "Andrea.Picardo" 
        And I go to job_info_search
        Then I should click on the job search button 
        Then I should see "Search Results For Jobs"
        Then I should see "Model 1"
        Then I should see "Model 2"
        Then I should see "Model 3"
        Then I should see "Photographer 1"
        Then I should see "Photographer 2"


    Scenario: When a user searches with a valid keyword, jobs with matches in titles or descriptions should show up
        Given I am logged in as "Andrea.Picardo" 
        And I go to job_info_search
        When I fill in the following:
         | search               | model  |
        Then I should click on the job search button 
        Then I should see "Model 1"
        Then I should see "Model 2"
        Then I should see "Model 3"
        Then I should not see "Photographer 1"
        Then I should not see "Photographer 2"
        When I fill in the following:
         | search               | animal  |
        Then I should click on the job search button 
        Then I should see "Photographer 1"


    Scenario: When a user searches with location information, then jobs with matching location should show up
        Given I am logged in as "Andrea.Picardo" 
        And I go to job_info_search
        When I select "United States" from "country"
        And I select "Texas" from "state"
        Then I should click on the job search button 
        Then I should see "Model 3"
        Then I should see "Photographer 1"
        Then I should see "Photographer 2"
        Then I should not see "Model 1"
        Then I should not see "Model 2"


    Scenario: When a user searches with a keyword that has no match to the existing jobs, then a no result message should show up
        Given I am logged in as "Andrea.Picardo" 
        And I go to job_info_search
        When I fill in the following:
         | search               | designer  |
        Then I should click on the job search button 
        Then I should see "No Results For This"


    




