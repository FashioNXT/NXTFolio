# NXTFolio Spring 2023, Iteration 2
Feature: Chat
    As a user
    So that I can chat with other users
    I want to be able to send and receive messages

    # NXTFolio Spring 2023, Iteration 2
    Background: users in database
        Given the following users exist
        | name              | password  | job | city | state | id | highlights |
        | Andrea.Picardo    | Test1234! | Model | Houston | TX | 1  | test |
        | Anthony.Gray    | Test1234! | Model | College Station | TX | 2  |  test |

    # NXTFolio Spring 2023, Iteration 2
    Scenario: As a user I should be available to access the chat and see other users
        Given I am logged in as "Andrea.Picardo" 
        And I am on the home page
        When I click on "dm"
        Then I should be on the DM page
        And I should see "No users to message!"

    #  NXTFolio Fall 2024, Sprint 2
    Scenario: I should be able to search for users to chat with
        Given I am logged in as "Andrea.Picardo"
        And I am on the DM page
        When I click on "search_button"
        And I fill in "user_search" with "Anthony"
        Then I should see "Anthony Gray - Model"

    # NXTFolio Fall 2024, Sprint 2
    Scenario: I should be able to send messages to other users
        Given I am logged in as "Andrea.Picardo"
        And I am on the DM page
        When I click on "search_button"
        And I fill in "user_search" with "Anthony"
        Then I should see "Anthony Gray - Model"
        When I select "Anthony Gray" chat
        And I fill in "body" with "Hello, this is a test"
        And I click on "Send"
        Then I should see "Hello, this is a test"

    # NXTFolio Spring 2023, Iteration 2
    Scenario: I should be able to receive messages
        Given "Andrea.Picardo" sends a message to "Anthony.Gray" saying "Hello, this is a test"
        And I am logged in as "Anthony.Gray"
        And I am on the DM page
        When I select "Andrea Picardo" chat
        Then I should see "Hello, this is a test"

    # NXTFolio Spring 2023, Iteration 2
    #Scenario: I should receive a notification when I receive a message
    #    Given "Andrea.Picardo" sends a message to "Anthony.Gray" saying "Hello, this is a test"
    #    And I am logged in as "Anthony.Gray"
    #    And I am on the home page
    #    When I click on "notif"
    #    Then I should see "Andrea Picardo sent you a message"
    #    When I click on "Andrea Picardo sent you a message"
    #    Then I should visit chat with "Andrea.Picardo"
    #    And I should see "Hello, this is a test"
    #    When I fill in "body" with "Test passed"
    #    And I click on "Send"
    #    Then I should see "Test passed"

    # New Scenarios - Fall 2024, Sprint 2
    Scenario: I should be able to send a message with an attachment
        Given I am logged in as "Andrea.Picardo"
        And I am on the DM page
        When I click on "search_button"
        And I fill in "user_search" with "Anthony"
        Then I should see "Anthony Gray - Model"
        When I select "Anthony Gray" chat
        And I fill in "body" with "Please see the attached file"
        And I attach the file "path/to/file.txt" to "files[]"
        And I click on "Send"
        Then I should see the file "4.jpg"

    Scenario: I should be able to search and see no users found when I search for non-existent user
        Given I am logged in as "Andrea.Picardo"
        And I am on the DM page
        When I click on "search_button"
        And I fill in "user_search" with "Daniel"
        Then I should see "No users found"