Given(/^I want to reset my password$/) do
  visit "/password/reset"
end

When(/^I fill in the email$/) do
  fill_in "example@nxtfolio.com", :with => "test123@gmail.com"
  ForgotMailer.reset("test123@gmail.com").deliver_now
end
