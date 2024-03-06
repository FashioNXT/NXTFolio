# Notification Steps Definition

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

# commented this block because ambiguous match 2023-03-06
# And(/^I am logged in$/) do
#     visit 'login_info/login'
#     fill_in "email", :with => @login_info.email
#     fill_in "password", :with => @login_info.password
#     click_button "Login"
# end

When(/^I click the "notification" button$/) do
    visit root_path
    click_button "button.dropbtn"
end

And(/^I don't have notifications$/) do
    @general_info = GeneralInfo.create!({
        :first_name => "Ive",
        :last_name => "Yi",
        :month_ofbirth => "January",
        :day_ofbirth => "23",
        :year_ofbirth => "1990",
        :country => "United States",
        :state => "TX",
        :city => "College Station",
        :phone => 82711,
        :notification => false,
        :notification_from => []
    })
end

And(/^I have a notification$/) do
    @general_info = GeneralInfo.create!({
        :first_name => "Ive",
        :last_name => "Yi",
        :month_ofbirth => "January",
        :day_ofbirth => "23",
        :year_ofbirth => "1990",
        :country => "United States",
        :state => "TX",
        :city => "College Station",
        :phone => 82711,
        :notification => true,
        :notification_from => [1]
    })
end

And(/^I click on a notification$/) do
    click_on "sent you a message!"
end

Then(/^I should redirect to the DM$/) do
    page.has_content?("Select a user to message!")
end

Then(/^I should have no more notifications$/) do
    page.has_content?("You're all caught up!")
end

# Then(/^I should see "(.*?)"$/) do |field_name|
#     case field_name
#     when "You're all caught up!"
#       page.has_content?("You're all caught up!")
#     when "dropdown menu with notifications"
#       page.has_content?("sent you a message!")
#     end
#   end
