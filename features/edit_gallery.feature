#Feature: Edit project information
#
#  As a creator
#  So that I can update my project information
#  Want to edit and save changes to published projects
#
#Background: project in database
#
#  Given the following project exist:
#  | gallery_title        | gallery_description | gallery_picture |
#  | BigProject           | Here is a project   | "test_pic.jpg" |
#
#Scenario: Enter the page to edit a project
#  Given I am on the details page for "BigProject"
#  When I follow "Edit This Project"
#  And I should see "Edit Gallery Details"
#
#Scenario: Edit title of a project
#  Given I am on the edit page for "BigProject"
#  When I fill in "Gallery title" with "ArtConnect"
#  When I click on "Updated Project"
#  And I should see "ArtConnect"
#  And I should not see "BigProject"
#
#Scenario: Edit description of a project
#  Given I am on the edit page for "BigProject"
#  When I fill in "Gallery description" with "an online art platform designed to create an interactive space for artists"
#  When I click on "Updated Project"
#  And I should see "an online art platform designed to create an interactive space for artists"
#  And I should not see "Here is a project"
#
#Scenario: Edit image of a project
#  Given I am on the edit page for "BigProject"
#  When I upload a file "sample.png"
#  And I click on "Updated Project"
#  And I should see exactly 2 images
#  When I follow "Edit This Project"
#  And I click on "Delete"
#  And I click on "Updated Project"
#  And I should see exactly 1 images
#
