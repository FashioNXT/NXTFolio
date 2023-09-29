Feature: Mobile Navbar Testing

    Scenario: Testing the login / logout 
        Given I am logged in as Andrea.Picardo
        Then logout

    Scenario: Visiting the profile page
        When I press profile.svg go to my profile
        Then go to profile

    Scenario: Visiting and opening search
        When I press search.svg go to search
        Then go to search