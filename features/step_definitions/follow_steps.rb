
Given(/^I am logged in as (.*) (.*)$/) do |first_name, last_name|
    visit root_path
    click_on "Sign In"
    fill_in "Your Email", :with => first_name + "." + last_name + "@example.com"
    fill_in "Your Password", :with => "Test1234!"
    click_on "SIGN IN"
  end

And(/^I visit the profile page of (.*) (.*)$/) do |first_name, last_name| 
  visit show_profile_show_profile_path(:user_key => GeneralInfo.find_by(emailaddr: first_name + "." + last_name + "@example.com").userKey) 
end

And(/I am not currently following James Lawrence/) do
  user = GeneralInfo.find_by(emailaddr: "James.Lawrence@example.com")
  myself = GeneralInfo.find_by(emailaddr: "Anthony.Gray@example.com")
  if user.get_followers.include? myself
    # Follow.destroy(:follower => myself, :followee => user)
    myself.unfollow(user.id)
    visit show_profile_show_profile_path(:user_key => GeneralInfo.find_by(emailaddr: "James.Lawrence@example.com").userKey) 
  end
end

And(/I am currently following James Lawrence/) do
  user = GeneralInfo.find_by(emailaddr: "James.Lawrence@example.com")
  myself = GeneralInfo.find_by(emailaddr: "Anthony.Gray@example.com")
  if not user.get_followers.include? myself
    # Follow.create!(:follower => myself, :followee => user) 
    myself.follow(user.id)
    visit show_profile_show_profile_path(:user_key => GeneralInfo.find_by(emailaddr: "Anthony.Gray@example.com").userKey) 
    visit show_profile_show_profile_path(:user_key => GeneralInfo.find_by(emailaddr: "James.Lawrence@example.com").userKey) 
  end
end

When(/^I click on the Follow button$/) do
  click_on "Follow"
end

When(/^I click on the Unfollow button$/) do
  click_on "Unfollow"
end

When(/^I click on the Following button$/) do
  click_on "Following"
end

When(/^I click on the Followers button$/) do
  click_on "Followers"
end
 
Then(/^I should be added to the followers list of (.*) (.*)$/) do |first_name, last_name|
  user = GeneralInfo.find_by(emailaddr: first_name + "." + last_name + "@example.com")
  myself = GeneralInfo.find_by(emailaddr: "Anthony.Gray@example.com")
  expect(user.get_followers.include? myself)
end

Then(/^I should be removed from the followers list of (.*) (.*)$/) do |first_name, last_name|
  user = GeneralInfo.find_by(emailaddr: first_name + "." + last_name + "@example.com")
  myself = GeneralInfo.find_by(emailaddr: "Anthony.Gray@example.com")
  expect(user.get_followers.include? myself == false)
end

And(/^other users are following me/) do 
  myself = GeneralInfo.find_by(emailaddr: "Anthony.Gray@example.com")
  if myself.get_followers.length() == 0
      andrea = GeneralInfo.find_by(emailaddr: "Andrea.Picardo@example.com")
      jack = GeneralInfo.find_by(emailaddr: "Jack.Sparrow@example.com")
      james = GeneralInfo.find_by(emailaddr: "James.Lawrence@example.com")
      andrea.follow(myself.id)
      jack.follow(myself.id)
      james.follow(myself.id)
      visit show_profile_show_profile_path(:user_key => GeneralInfo.find_by(emailaddr: "Anthony.Gray@example.com").userKey) 
  end
end

And(/^I am following other users/) do 
  myself = GeneralInfo.find_by(emailaddr: "Anthony.Gray@example.com")
  if myself.get_users_they_follow.length() == 0 
      andrea = GeneralInfo.find_by(emailaddr: "Andrea.Picardo@example.com")
      jack = GeneralInfo.find_by(emailaddr: "Jack.Sparrow@example.com")
      james = GeneralInfo.find_by(emailaddr: "James.Lawrence@example.com")
      myself.follow(andrea.id)
      myself.follow(jack.id)
      myself.follow(james.id)
      visit show_profile_show_profile_path(:user_key => GeneralInfo.find_by(emailaddr: "Anthony.Gray@example.com").userKey) 
  end
end


Then(/^I should see a popup containing the users I follow/) do
  myself = GeneralInfo.find_by(emailaddr: "Anthony.Gray@example.com") 
  myself.get_users_they_follow.map do |u| 
    page.has_content?(u.first_name + " " + u.last_name)
  end
end 

Then(/^I should see a popup containing the users following me/) do
  myself = GeneralInfo.find_by(emailaddr: "Anthony.Gray@example.com") 
  myself.get_followers.map do |u| 
    page.has_content?(u.first_name + " " + u.last_name)
  end
end 