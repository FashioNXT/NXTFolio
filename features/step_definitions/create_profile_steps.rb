# Create Profile Step Definitions

Given(/^I am on the Match My Fashion home page$/) do
    visit root_path
end

When(/^I click on Sign Up button$/) do
   visit 'login_info/new'
end

When(/^I fill in "(.*?)" text field with "(.*?)"$/) do |field_name, value|
    case field_name
    when "email"
        fill_in "Email", :with => value
    when "password"
        fill_in "Password", :with => value
    when "password confirmation"
        fill_in "Password confirmation", :with => value
    # when "first_name"
    #     fill_in "First name", :with => value
    # when "last_name"
    #     fill_in "Last name", :with => value
    # when "country"
    #     fill_in "Country", :with => value
    # when "state"
    #     fill_in "State", :with => value
    # when "city"
    #     fill_in "City", :with => value
    # when "facebook"
    #     fill_in "Facebook", :with => value
    # when "instagram"
    #     fill_in "Instagram", :with => value
    # when "website"
    #     fill_in "Website", :with => value
    # when "bio"
    #     fill_in "Bio", :with => value
    else
      puts "invalid field name"
    end
end

When(/^I hit the Submit button$/) do
    click_button("Submit")
end


Then(/^I should see a message that says "(.*?)"$/) do |message|
  case message
  when "Invalid Email or Password. Please try again."
      page.has_content?('Invalid Email or Password. Please try again.')
  when "Account Created!"
      page.has_content?('Account Created!')
  else
      puts "Did not see message."
  end
end
