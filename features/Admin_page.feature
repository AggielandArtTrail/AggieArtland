Feature: Admin Page
  As an admin
  I want to be able to manage the art pieces database
  So that I can keep the map upto date

  Scenario: List all the Art Pieces in the database
    Given I am in the Index Page
    Then I should see the details of all the Art Pieces

  Scenario: Create a New Art Piece
    Given I am in the Index page 
    When I click on the new art piece link
    Then I should be redirected to the page
    And I fill in "Name" with "New Art"
    And I fill in "Address" with "123 Main St"
    And I press "Create Art piece" 
    And it should be uploaded to the database within 10 seconds

  Scenario: Update an Existing Art Piece
    Given I am in the show art piece with id 1
    When I click the Edit this art piece link
    Then I should be redirected to the updating page 
    And I should be able to change any aspect of the Art Piece

  Scenario: Show this art piece
    Given I am on the Index page 
    And I have a piece with id 1
    When I click on show this art piece with id 1
    Then I should be able to see all the details of a certain art piece

  Scenario: Upload Art Piece Image
    Given I am in the edit art piece page with id 1
    When I click on "Upload Icon"
    And I choose a file from the file picker
    Then I should see the chosen file as the new art piece icon