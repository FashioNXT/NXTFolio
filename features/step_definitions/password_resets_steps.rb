# features/step_definitions/password_resets_steps.rb
require 'active_job'
require 'nokogiri'
include ActiveJob::TestHelper
include ActionMailer::TestHelper

def extract_password_reset_token_from_email(email_address)
  puts ActionMailer::Base.deliveries
  last_email = ActionMailer::Base.deliveries.last
  email_body = last_email.html_part.body.to_s  # Assuming the token is in the HTML part of the email

  doc = Nokogiri::HTML(email_body)
  
  # Extract the href attribute from the link in the HTML
  reset_link = doc.at_css('a:contains("Reset Password")')['href']

  # Extract the token from the reset link using regular expression
  match_data = reset_link.match(/password\/reset\/edit\?token=(\w+)/)

  if match_data
    return match_data[1]
  else
    raise 'Token not found in the email'
  end
end

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

  Then(/^I should see a success change message$/) do
    expect(page).to have_content('  Your Password has been reset Successfully!')
  end

  And(/^an email should be sent to "(.*?)" with a password reset link$/) do |email|
    # You can add additional assertions here based on the email content
    # puts ActionMailer::Base.deliveries
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
    visit password_reset_path
    fill_in 'email', with: 'hellofriend2@gmail.com'
    click_on "Reset Password"
    @valid_token = extract_password_reset_token_from_email('hellofriend2@gmail.com')
  end
  
  When(/^I click the password reset link in the email$/) do
    # Implement logic to visit the password reset link with the stored valid token
    visit password_reset_edit_path(@valid_token)
  end
  
  And(/^I enter a new password "(.*?)"$/) do |new_password|
    fill_in 'login_info_password', with: new_password
  end
  
  And(/^I enter the confirmation password "(.*?)"$/) do |confirmation_password|
    fill_in 'login_info_password_confirmation', with: confirmation_password
  end

  Then(/^my password should be updated$/) do
    # Implement logic to verify that the password has been updated
    user = find_user_by_email('hellofriend@gmail.com')
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
  