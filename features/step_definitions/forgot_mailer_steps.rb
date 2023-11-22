Given(/^I want to reset my password$/) do
  visit "/password/reset"
end

When(/^I fill in the email$/) do
  fill_in "example@nxtfolio.com", :with => "Anthony.Gray@example.com"
  click_on "Reset Password"
  visit "/password/reset/edit"
end
