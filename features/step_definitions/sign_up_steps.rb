
Given("I store the email {string} for later verification") do |email|
    @user_email = email
end

Then("I should receive a confirmation email with a link to confirm my account") do
    raise "Email not set" if @user_email.nil?
    open_email(@user_email)
    expect(current_email).to have_content("Confirm my account")
end

# Step to follow the confirmation link in the email
When("I follow the email confirmation link") do
    # Ensure the email is opened
    raise "No email found" unless current_email

    # Extract the confirmation link from the email
    confirmation_link = current_email.body.match(/href="([^"]+)"/)[1]

    # Visit the confirmation link
    visit confirmation_link
end

Then(/^I should see an email confirmation message$/) do
    expect(page).to have_content("A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.")
end

