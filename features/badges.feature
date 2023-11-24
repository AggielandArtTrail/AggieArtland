Feature: Badges
    As a user,
    So that I can see a preview of my collected badges,
    I want to see a row of my most recent badges in my profile.

Background: users in database
Given the following users exist:
    | email             | password_digest | name  |
    | abc@gmail.com     | abc123          | Abet  |
    | xyz@gmail.com     | asj438f84       | Kayla |
    | and123@yahoo.com  | password01      | Syd   |
    | pete@gmail.com    | idk1234         | Pete  |
And the following art pieces exist:
    | name       | address   | latitude    | longitude    |
    | Zachry     | 125 Spence St, College Station, TX 77843 | 30.6214878  | -96.3403293  |
    | Zachry 2     | 125 Spence St, College Station, TX 77843 | 30.6214878  | -96.3403293  |
    | Zachry 3     | 125 Spence St, College Station, TX 77843 | 30.6214878  | -96.3403293  |
    | Zachry 4     | 125 Spence St, College Station, TX 77843 | 30.6214878  | -96.3403293  |
    | Kleberg    | foobar    | 30.6108349  | -96.3476426  |
    | Piece A    | foobar    | 30.6108349  | -96.3476426  |
    | Piece B    | foobar    | 30.6108349  | -96.3476426  |
And the following badges exist:
    | name         | badge_type  | requirement    |
    | One stamp    | stamps      | 1              |
    | Two stamps   | stamps      | 2              |
    | Three stamps | stamps      | 3              |

    Scenario: Badges in profile
        Given I have signed up with email "billybob@gmail.com", name "Billy Bob", and password "bobbobbob"
        And I am logged in with email "billybob@gmail.com" and password "bobbobbob"
        And I visit my profile
        Then I should see "Billy Bob"
        And I should see "Badges"

    Scenario: No one-stamp badge in profile by default
        Given I have signed up with email "billybob@gmail.com", name "Billy Bob", and password "bobbobbob"
        And I am logged in with email "billybob@gmail.com" and password "bobbobbob"
        And I visit my profile
        Then I should not see "One stamp"

    Scenario: Receive one-stamp badge from check-in
        Given I check in to art piece 1
        Then I should see "You've earned the badge 'One stamp'!"

    Scenario: See one-stamp badge in profile
        Given I check in to art piece 1
        And I visit my profile
        Then I should see "One stamp"

    Scenario: See one-stamp badge icon in profile
        Given I check in to art piece 1
        And I visit my profile
        Then I should see the image "default_art.png"

    Scenario: One-stamp badge marked as complete
        Given I check in to art piece 1
        And I go to badge 1
        Then I should see "COMPLETE"

    Scenario: Three-stamp badge has progress
        Given I check in to art piece 1
        And I go to badge 3
        Then I should see "1/3"

    Scenario: Receive three-stamp badge from three check-ins
        Given I check in to art piece 1
        And I check in to art piece 2
        And I check in to art piece 3
        Then I should see "You've earned the badge 'Three stamps'!"

    Scenario: Do not receive badges multiple times
        Given I check in to art piece 1
        And I check in to art piece 2
        Then I should not see "You've earned the badge 'One stamp'!"

    Scenario: Reset badges
        Given I check in to art piece 1
        And I visit my badges
        And I click "Clear my badges"
        And I visit my profile
        Then I should not see "One stamp"

