# Create Profile Step Definitions

Given(/^I am on the home page$/) do
    visit root_path
end



=begin
When(/^I want to add new profession$/) do
    @login_info = LoginInfo.create!({
      :email => "hellofriend@gmail.com",
      :password => "password",
      :password_confirmation => "password"
    })
end
=end

Then(/^I should be on the Template page$/) do
  visit '/template'
end

Then(/^I should see a message "(.*?)"$/) do |message|
  case message
    when "ADD A NEW PROFESSION"
      page.has_content?('ADD A NEW PROFESSION')
  end
end