Feature: Add a new Profession Template

  As a website administrator, I want to create new templates
  So my users can select the appropriate profession



  Scenario: Logged in as admin, Create a job and update and delete
    Given I am a valid admin user
    When I log in
    When I visit landing page
    Then I should see "Create Job"
    When I click on "Create Job"
    Then I should see "Enter Job Name"
    When I fill in "job_name" with "Testjob"
    And I click on "Create"
    Then I visit landing page

    And I click on "Edit Job"
    Then I select "Testjob" from the "job_name" dropdown
    Then I select "Add" from the "attr_action" dropdown
    Then I fill in "attr_name" with "Attr1"
    Then I click on "Edit"

    Then I visit landing page
    And I click on "Edit Job"
    Then I select "Testjob" from the "job_name" dropdown
    Then I select "Remove" from the "attr_action" dropdown
    Then I fill in "attr_name" with "Attr1"
    Then I click on "Edit"

    Then I visit landing page
    And I click on "Delete Job"
    Then I select "Testjob" from the "job_name" dropdown
    Then I click on "Delete"

    
  Scenario: Not logged in as admin, Go to landing page
    Given I am a valid user
    When I visit landing page

    Scenario: When logged in as admin, option to add template exists

    Given I am a valid admin user
    When I log in
    Then I should see "Logged In!"
    And I should be on the home page

  Scenario: Logged in as admin, Go to landing page
    Given I am a valid admin user
    When I log in
    When I visit landing page
    Then I should see "Create Job"
    

