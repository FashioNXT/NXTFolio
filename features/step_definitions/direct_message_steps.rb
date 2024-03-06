# Direct Message Steps

# commented this block because ambiguous match 2023-03-06
# Given(/^I am a valid user$/) do
#     @login_info = LoginInfo.create!({
#        :email => "hellofriend@gmail.com",
#        :password => "Apple12345*",
#        :password_confirmation => "Apple12345*"
#      })
#     @general_info = GeneralInfo.create!({
#        :first_name => "Ive",
#        :last_name => "Yi",
#        :month_ofbirth => "January",
#        :day_ofbirth => "23",
#        :year_ofbirth => "1990",
#        :country => "United States",
#        :state => "TX",
#        :city => "College Station",
#        :phone => 82711
#      })
# end

When(/^I click the "DM" button$/) do
    visit root_path
    click_button "a.dropbtn"
end

Then(/^I should redirect to the DM page$/) do
    page.has_content?("Select a user to message!")
end

# And(/^I am on the DM page$/) do
#     visit '/dm'
# end

When(/^I click a user$/) do
    click_on "Model"
end

Then(/^I should see our DMs$/) do
    page.has_content?("send")
end

When(/^I click the "send" button$/) do
    fill_in "Message...", :with => "hello"
    click_button "send"
end

Then(/^I should send a message$/) do
    page.has_content?("hello")
end