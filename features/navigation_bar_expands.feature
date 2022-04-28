Feature: The navigation bar for the different types of professionals on
         the home page expands horizontally when the arrow is clicked, and vice versa.

   As an application user,
   So that I can see all the categories under a certain
   group of professionals (e.g., creators, service, makers) on the home page,
   I want to click on the “>>” button located next to the navigation bar of
   a certain group of professionals and have all type of professionals under that category
   to be displayed horizontally, covering the rest of the categories of professionals
   until the “<<” button is pressed again.


  Scenario: When Clicking on the “>>” button on the right side of group
    Given I am a professional or searching for professionals in a group
    When I click on the “>>” button
    Then Other categories will be hidden and all professions under this category will be shown

#  Scenario: When Clicking on the “<<” button on the left side of group
#    Given I am a professional wanting to go back to home page with all three categories
#    When I click on the “<<” button
#    Then All three category are shown with three or four professions in each category.

