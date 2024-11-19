require 'rails_helper'

RSpec.describe 'User Signup', type: :feature do
  scenario 'New user successfully creates an account with email confirmation' do
    # Step 1: Navigate to the signup page
    visit new_user_registration_path

    # Step 2: Fill in the signup form
    fill_in 'user[email]', with: 'test@example.com'
    fill_in 'user[password]', with: 'Test1234!'
    fill_in 'user[password_confirmation]', with: 'Test1234!'
    
    # Step 3: Submit the form
    click_button 'Sign up'

    # Step 4: Check that the confirmation message is displayed
    expect(page).to have_content('A message with a confirmation link has been sent to your email address.')

    # Step 5: Verify that the confirmation email was sent
    expect(ActionMailer::Base.deliveries.count).to eq(1)

    # Step 6: Verify the email content
    mail = ActionMailer::Base.deliveries.last
    expect(mail.to).to include('test@example.com')
    expect(mail.subject).to eq('Confirmation instructions')
  end

  scenario 'Generate About Me button is visible on edit2 after signup' do
    # Step 1: Navigate to the signup page
    visit new_user_registration_path

    # Step 2: Fill in the signup form
    fill_in 'user[email]', with: 'test_about_me@example.com'
    fill_in 'user[password]', with: 'Test1234!'
    fill_in 'user[password_confirmation]', with: 'Test1234!'

    # Step 3: Submit the form
    click_button 'Sign up'

    # Step 4: Confirm the account
    user = User.find_by(email: 'test_about_me@example.com')
    user.update(confirmed_at: Time.now)

    # Step 5: Log in with the confirmed user
    visit new_user_session_path
    fill_in 'user[email]', with: 'test_about_me@example.com'
    fill_in 'user[password]', with: 'Test1234!'
    click_button 'Log in'

    # Step 6: Navigate to the edit2 page
    visit general_info_edit2_path

    # Step 7: Check that the "Generate About Me" button is visible
    expect(page).to have_button('Generate About Me')
  end
end
