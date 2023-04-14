Feature: delete single image in the gallery
  As a valid user with gallery
  I want to delete single image in the gallery


  Background: galleries in database

  Given the following users exist
    | name              | password  | job | city | state | id |
    | Andrea.Picardo   | Test1234! | Model | Houston | TX | 0 |

  Given the following galleries for testing delete exist
  | title | description | total  | id|  num|
  | t1    | high1       | 20     |  1  | 4 |


   Given the following galleries exist
  | title | description | total  | id|  num|
  | t2    | high2       | 20     |   1  | 4|

Scenario: User can delete image in their gallery
  Given I am a valid gallery user
  Given I am on the home page
  When I click on "t1"
  Then I should see "Delete1"
  When I click on "Delete1"
  Then I should see "The image has been removed from the gallery!"


Scenario: User can only delete gallery if there is only one image
  Given I am a valid gallery user
  Given I am on the home page
  When I click on "t2"
  Then I should not see "Delete1"
  Then I should see "Delete This Project"
  


Scenario: User add images to their gallery (at most 5 in the gallery)
  Given I am a valid gallery user
  Given I am on the home page
  When I click on "t1"
  When I click on "Add pictures"
  Then I should see "Add images (No more than 5 images pre gallery!)"
  When I upload an image
  When I click on "Add images"
  Then I should see "Images uploaded!"
  When I click on "Update gallery"
  Then I should see "Successfully added images!"


Scenario: User cannot add images to their gallery when the total amount is more than 5
  Given I am a valid gallery user
  Given I am on the home page
  When I click on "t1"
  When I click on "Add pictures"
  When I upload multiple images
  When I click on "Add images"
  When I click on "Update gallery"
  Then I should not see "Successfully added images!"
  Then I should see "You can not have more than 5 images in a gallery!"


Scenario: User cannot add 0 image to their gallery 
  Given I am a valid gallery user
  Given I am on the home page
  When I click on "t1"
  When I click on "Add pictures"
  When I click on "Add images"
  Then I should not see "Images uploaded!"
  Then I should see "Add at least 1 image!"


  


  
