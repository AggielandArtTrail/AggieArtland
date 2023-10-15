Feature: Authentication System
    As a registered user,
    So that I can access the resources of the website securely,
    I want to log into the website with my email and password.

Background: users in database
Given the following users exist:
    | email             | password_digest | name  |
    | abc@gmail.com     | abc123          | Abet  |
    | xyz@gmail.com     | asj438f84       | Kayla |
    | and123@yahoo.com  | password01      | Syd   |
    | pete@gmail.com    | idk1234         | Pete  |

    Scenario: Navigate to Create Account
        Given I am on the login page
        When I click on the sign up button
        Then I should be on the sign up page

    Scenario: Create Account
        Given I am on the sign up page
        When I fill in "Email" with "billybob@gmail.com"
        And I fill in "Name" with "Billy Bob"
        And I fill in "Password" with "bobbobbob"
        And I fill in "Password confirmation" with "bobbobbob"
        And I press "Sign Up"
        Then I should be on the user page
        And I should see "Billy Bob"
        And I should see "billybob@gmail.com"

    Scenario: Existing Account
        Given I am on the sign up page
        When I fill in "Email" with "pete@gmail.com"
        And I fill in "Name" with "Pete"
        And I fill in "Password" with "anything"
        And I fill in "Password confirmation" with "anything"
        And I press "Sign Up"
        Then I should be on the sign up page

    Scenario: Passwords don't match
        Given I am on the sign up page
        When I fill in "Email" with "newguy@gmail.com"
        And I fill in "Name" with "Newt"
        And I fill in "Password" with "mypass12"
        And I fill in "Password confirmation" with "mypass21"
        And I press "Sign Up"
        Then I should see a notice "Password confirmation doesn't match Password"


    Scenario: Log In
        Given I have signed up with email "billybob@gmail.com", name "Billy Bob", and password "bobbobbob"
        And I am on the login page
        When I fill in "Email" with "billybob@gmail.com"
        And I fill in "Password" with "bobbobbob"
        And I press "Log in"
        Then I should be on the user page
        And I should see "Billy Bob"
        And I should see "billybob@gmail.com"

    Scenario: Incorrect password
        Given I am on the login page
        When I fill in "Email" with "abc@gmail.com"
        And I fill in "Password" with "xyz1234"
        And I press "Log in"
        Then I should see a notice "Incorrect email or password"


    Scenario: User does not exist
        Given I am on the login page
        When I fill in "Email" with "abc@gmail.com"
        And I fill in "Password" with "xyz1234"
        And I press "Log in"
        Then I should see a notice "Incorrect email or password"


    Scenario: Logout
        Given I have signed up with email "billybob@gmail.com", name "Billy Bob", and password "bobbobbob"
        And I am on the user page
        When I click "Logout"
        Then I should see the login page

    Scenario: Send email for password Reset
        Given I am on the login page
        When I click "Forgot your password?"
        Then I should see "Email"
        And I fill in "Email" with "abc@gmail.com"
        

    Scenario: Reset password
        Given I am on the reset password page
        When I fill in "Password" with "newpass12"
        And I fill in "Password confirmation" with "newpass12"

