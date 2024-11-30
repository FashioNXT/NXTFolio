Feature:  Change the Category Classification and Reflect it on Create, edit profile, home page and search


  As a professional and application user,

  So that I want to see the updated category classification as per specification. I want to see profession will be auto
  populated while searching, adding, and editing profiles



  # Scenario: Updated category on home page
  #  Given I am a professional and want to see the category on home page
  #  When I landed on home page
  #  Then I should be able to see updated category buttons in the home page


  Scenario: profession list auto populated based on category in search pages
    Given I am a professional and want to search for a profile
    When I select the category "Services"
    Then only service related profession will be populated in dropdown

  # Scenario: profession list auto populated based on category in add page
  #   Given I am a professional and want to add my profile
  #   When I select the category "Services" in add profile page
  #   Then only service related profession will be populated in dropdown in add profile

  # Scenario: profession list auto populated based on category in edit page
  #  Given I am a professional and want to see autopopulation in edit profile option
  #  When I select the category "Services" in edit profile page
  #  Then only service related profession will be populated in dropdown in edit profile




