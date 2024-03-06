Feature: Search Feature Bug Fix and Refactor

  As a professional and application user.
  So that I can search for professionals from the search page and can do advanced search from the landing page if necessary.
  I want to search a professional’s profile from the home page and my search string will be copied on the advanced search page
  I also want search by full name, first name, last name in lower and upper case


  # Scenario: Search from Home Page
  #  Given I am a professional and trying to search another professional
  #  When I type "test user" and click on search button
  #  Then I should be redirected to advanced_search_show page
  #  And with "test" as search string

  Scenario: Show landing advanced search page from show page
    Given I am a professional and search a professional from show page
    When I type "test" and click on search button from show page
    Then I should be redirected to advanced_search_search page
    And with "test" as search string

  Scenario: test user create
    Given I can create an individual


