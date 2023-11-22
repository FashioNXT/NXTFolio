# features/step_definitions/password_resets_steps.rb
require 'active_job'
include ActiveJob::TestHelper
include ActionMailer::TestHelper

  When(/^I visit the password reset page$/) do
    # visit 'password/reset'
    visit password_reset_path
    # visit root_path
  end
  
  And(/^I enter my email "(.*?)" for password reset$/) do |email|
    fill_in 'email', with: email
  end
  
  And(/^I submit the password reset form$/) do
    click_button 'Reset Password'
  end
  
  Then(/^I should see a success message$/) do
    expect(page).to have_content('If an account exists with this email, We have sent a link to reset the password')
  end
  
  And(/^an email should be sent to "(.*?)" with a password reset link$/) do |email|
    # You can add additional assertions here based on the email content
    last_email = ActionMailer::Base.deliveries.last
    expect(last_email.subject).to include("NXTFolio: Password Reset Request")
    # expect(last_email.body.text_part.body.to_s).to include(password_reset_edit_path(token))
    expect(last_email.text_part.body.to_s).to include(password_reset_edit_path(@token))

  end

  Then(/^I should see a notice message$/) do
    expect(page).to have_content("If an account exists with this email, We have sent a link to reset the password")
  end
  
  Given(/^I have received a password reset email with a valid token$/) do
    # Simulate receiving a password reset email and store the token for later use
    @valid_token = receive_password_reset_email('user@example.com')
  end
  
  When(/^I click the password reset link in the email$/) do
    # Implement logic to visit the password reset link with the stored valid token
    visit edit_password_reset_path(@valid_token)
  end
  
  And(/^I enter a new password "(.*?)"$/) do |new_password|
    fill_in 'password', with: new_password
  end
  
  Then(/^my password should be updated$/) do
    # Implement logic to verify that the password has been updated
    user = find_user_by_email('user@example.com')
    expect(user.authenticate('new_password')).to be_truthy
  end
  
  Given(/^I have received a password reset email with an invalid token$/) do
    # Simulate receiving a password reset email with an invalid token
    @invalid_token = 'invalid_token'
  end
  
  When(/^I click an invalid password reset link in the email$/) do
    # Implement logic to visit the password reset link with the stored invalid token
    visit password_reset_edit_path(@invalid_token)
  end
  
  Then(/^I should see an error message$/) do
    expect(page).to have_content("The Password Reset Link is Expired! Please Try Again")
  end
  