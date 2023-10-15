# features/step_definitions/admin_steps.rb
require 'factory_bot'

Given("I am in the Index Page") do
  visit art_pieces_path
end

Then("I should see the details of all the Art Pieces") do
  art_pieces = ArtPiece.all
  art_pieces.each do |art_piece|
    expect(page).to have_content(art_piece.name)
    expect(page).to have_content(art_piece.description)
    expect(page).to have_content(art_piece.artist)
    # Add additional assertions as needed
  end
end

Given("I am in the Index page") do
  visit art_pieces_path
end

When("I click on the new art piece link") do
  click_link('New art piece')
end

Then("I should be redirected to the page") do
  expect(current_path).to eq(new_art_piece_path)
end

And("it should be uploaded to the database within {int} seconds") do |seconds|
  art_piece = ArtPiece.last
  expect(art_piece.name).to eq('New Art')
  expect(art_piece.address).to eq('123 Main St')
end

Given("I am in the show art piece with id {int}") do |id|
  @artPiece = ArtPiece.create(id:id, name:'Dummy', address:'Dummy')
  visit show_art_piece_path(id)
end

When("I click the Edit this art piece link") do
  find("#edit").click
end

Then("I should be redirected to the updating page") do
  expect(page).to have_content("Editing art piece")
end

And("I should be able to change any aspect of the Art Piece") do
  fill_in 'Address', with: 'New Address'
  fill_in 'Description', with: 'New Description'
end

And("it should be updated in the database within {int} seconds") do |second|
  
  element = ArtPiece.find_by(id: @artPiece.id)
  expect(element.address).to eq("New Address")
end

Given("I am on the Index page") do
  visit art_pieces_path
end

And("I have a piece with id {int}") do |id|
  ArtPiece.create(id:id, name:'Dummy', address:'Dummy')
end

When("I click on show this art piece with id {int}") do |id| 
  visit show_art_piece_path(id)
end

Then("I should be able to see all the details of a certain art piece") do
  art_piece = ArtPiece.first
  expect(page).to have_content(art_piece.name)
  expect(page).to have_content(art_piece.description)
  expect(page).to have_content(art_piece.artist)
  # Add additional assertions as needed
end

Given('I am in the edit art piece page with id {int}') do |id|
  @artPiece = ArtPiece.create(id:id, name:'Dummy', address:'Dummy')
  visit edit_art_piece_path(id)
end

When('I attach {string} to {string}') do |file, field|
  page.attach_file field, File.join(Rails.root, 'test', file)
end

When('I click on {string}') do |string|
  click_button(string)
end

Then('I should be redirected to the show art piece page with id {int}') do |id|
  expect(current_path).to eq(show_art_piece_path(id))
end

Then('I should see the image {string}') do |image|
  expect(page).to have_xpath("//img[contains(@src, \"#{image}\")]")
end

Given('I have uploaded {string} as an icon for art piece ID {int}') do |file, id|
  step %{I am in the edit art piece page with id #{id}}
  step %{I attach "#{file}" to "art_icon_upload_field"}
  step %{I click on "Upload Icon"}
end

Given('I go to the edit art piece page with id {int}') do |id|
  visit edit_art_piece_path(id)
end

Given('I go to the art pieces page') do
  visit art_pieces_path
end
