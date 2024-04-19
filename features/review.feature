#Feature: add a review in a project
#  As a valid user with a project
#  I want to add a review in another project


#  Background: galleries in database

#  Given the following users exist
#    | name              | password  | job | city | state | id | highlights |
#    | Andrea.Picardo   | Test1234! | Model | Houston | TX | 2 | test | 
#    | Anthony.Gray   | Test1234! | Model | Houston | TX | 3 | test | 
#    | Emma.Watson   | Test1234! | Model | Houston | TX | 4 | test | 
#    | John.Doe       | Test1234!  | Model | Houston | TX    | 5  | test      |
#    | Jane.Smith     | Test1234!  | Model | Houston | TX    | 6  | test      |

#  Given the following galleries for testing delete exist
#  | title | description | total  | id|  num|
#  | t1    | high1       | 20     |  2  | 4 |
#  | t2    | high2       | 15    | 3  | 3   |
#  | t4    | high4       | 5     | 5  | 1   |
#  | t5    | high5       | 2     | 6  | 0   |
#  | t6    | high6       | 3     | 4  | 5   |

#  Given the following tagging exist
#  | gallery | user_id |
#  | t1      | 4       |
#  | t2      | 4       |
#  | t4      | 4       |
#  | t5      | 5       |

# Scenario: User can view the add rating button in other project(s)
#  Given I am logged in as "Emma.Watson"
#  Given I am a valid gallery user
#  Given I am on the home page
#  When I click on "t1"
#  When I click on "See project owner's profile"
#  When I click on "Add Review"
#  Then I fill in the rating field with 5
#  When I click on "Create Review"
#  Then I should be able to view the Rating

# Scenario: User can view the edit rating button in other project(s)
#  Given I am logged in as "Emma.Watson"
#  Given I am a valid gallery user
#  Given I am on the home page
#  When I click on "t1"
#  When I click on "See project owner's profile"
#  When I click on "Add Review"
#  Then I fill in the rating field with 5
#  When I click on "Create Review"
#  Then I should be able to view the Rating
#  When I click on "Edit Your Rating"    
#  Then I fill in the rating field with 4
#  When I click on "Update Review"
#  Then I should be able to view the updated Rating