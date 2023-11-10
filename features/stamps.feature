Feature: Stamps and Badges
    As a user,
    So that I can see a preview of my collected badges and stamps,
    I want to see a row of my most recent badges and stamps in my profile.

Background: users in database
Given the following users exist:
    | email             | password_digest | name  |
    | abc@gmail.com     | abc123          | Abet  |
    | xyz@gmail.com     | asj438f84       | Kayla |
    | and123@yahoo.com  | password01      | Syd   |
    | pete@gmail.com    | idk1234         | Pete  |
And the following art pieces exist:
    | name       | address   |
    | Piece A    | foobar    |
    | Piece B    | foobar    |
    | Piece C    | foobar    |
    | Piece D    | foobar    |

    Scenario: Stamps in profile
        Given I have signed up with email "billybob@gmail.com", name "Billy Bob", and password "bobbobbob"
        And I am logged in with email "billybob@gmail.com" and password "bobbobbob"
        And I visit my profile
        Then I should see "Billy Bob"
        And I should see "STAMPS"

    Scenario: No Piece A stamp in profile by default
        Given I have signed up with email "billybob@gmail.com", name "Billy Bob", and password "bobbobbob"
        And I am logged in with email "billybob@gmail.com" and password "bobbobbob"
        And I visit my profile
        Then I should not see "Piece A"

    Scenario: Check in to art piece once
        Given I have signed up with email "billybob@gmail.com", name "Billy Bob", and password "bobbobbob"
        And I am logged in with email "billybob@gmail.com" and password "bobbobbob"
        And I go to the first art piece
        And I click "Check-in to this art piece"
        #Then I should see "Checked in to art piece Piece A!"
        Then I should see "You need to be within"


    Scenario: Check in to art piece twice
        Given I have signed up with email "billybob@gmail.com", name "Billy Bob", and password "bobbobbob"
        And I am logged in with email "billybob@gmail.com" and password "bobbobbob"
        And I go to the first art piece
        And I click "Check-in to this art piece"
        And I click "Check-in to this art piece"
        #And I should see "You've already checked in to art piece Piece A!"
        Then I should see "You need to be within"

    Scenario: No Piece A stamp in profile by default
        Given I have signed up with email "billybob@gmail.com", name "Billy Bob", and password "bobbobbob"
        And I am logged in with email "billybob@gmail.com" and password "bobbobbob"
        And I visit my profile
        Then I should not see "Piece A"

    Scenario: Get stamp from art piece check-in
        Given I have signed up with email "billybob@gmail.com", name "Billy Bob", and password "bobbobbob"
        And I am logged in with email "billybob@gmail.com" and password "bobbobbob"
        And I go to the first art piece
        And I click "Check-in to this art piece"
        And I visit my profile
        #Then I should see "Piece A"
        Then I should not see "Piece A"

