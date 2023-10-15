Given /the following users exist/ do |users_table|
    users_table.hashes.each do |user|
      User.create user
    end
  end

Given('I am on the login page') do
    visit login_path
end

When('I click on the sign up button') do
    click_link("Sign up")
end

Then('I should be on the sign up page') do
    visit signup_path
end

Given('I am on the sign up page') do
    visit signup_path
end

When('I fill in {string} with {string}') do |field, value|
    fill_in(field, with: value)
end

When('I press {string}') do |button|
    click_button(button)
end
When('I click {string}') do |link|
    click_link(link)
end

Then('I should be on the user page') do
    visit "/users/1"
end

Then('I should see {string}') do |text|
    expect(page).to have_content(text)
end

Given('I have signed up with email {string}, name {string}, and password {string}') do |email, name, pwd|
    step %{I am on the sign up page}
    step %{I fill in "Email" with "#{email}"}
    step %{I fill in "Name" with "#{name}"}
    step %{I fill in "Password" with "#{pwd}"}
    step %{I fill in "Password confirmation" with "#{pwd}"}
    step %{I press "Sign Up"}
end

Given('I am on the user page') do ||
  visit "/users/1"
end

Then('I should see the login page') do ||
  expect(page).to have_current_path(login_path)
end

Then('I should see a notice {string}') do |string|
    expect(page).to have_content(string)

end

Then('I should receive an email to {string}') do |string|
  expect { UserMailer.forgot_password(User.find_by(email:string)).deliver }.to change { ActionMailer::Base.deliveries.count }.by(1)
end

Given('I am on the reset password page') do ||
    visit password_reset_edit_path
end


