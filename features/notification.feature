# Feature: Receive notifications while logged in to the Application

#    As a professional and application user
#	So that I can see all the notifications sent to me while I am logged into the application.
#    I want to see all my important notifications in a single place when I log in.

# Scenario: When a user has unread messages, they will receive notifications

#    Given I am a valid user
#    And I am logged in
#    When I click the "notification" button
#    Then I should see a "dropdown menu with notifications"

# Scenario: When a user has no notifications, the notifications button will tell them that

#    Given I am logged in
#    And I don't have notifications
#    When I click the "notification" button
#    Then I should see "You're all caught up!"

# Scenario: When a user has a notification, clicking the notification will bring them to the DM

#    Given I am logged in
#    And I have a notification
#    When I click the "notification" button
#    And I click on a notification
#    Then I should redirect to the DM

# Scenario: When a user has a notificiation, clicking the notifcation will clear that notifcation from the notifcations menu

#    Given I am logged in
#    And I have a notification
#    When I click the "notification" button
#    And I click on a notification
#    Then I should have no more notifcations
