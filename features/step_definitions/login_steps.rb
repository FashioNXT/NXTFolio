# Login Step Definitions

Given(/^I am not logged in$/) do
  visit "/login_info/logout"
  # expect(page).to have_current_path(destroy_user_session_path)
end

Given(/^I am a valid user$/) do
   @login_info = LoginInfo.create!({
      :email => "hellofriend@gmail.com",
      :password => "Apple12345*",
      :password_confirmation => "Apple12345*"
    })
   @general_info = GeneralInfo.create!({
      :first_name => "Ive",
      :last_name => "Yi",
      :month_ofbirth => "January",
      :day_ofbirth => "23",
      :year_ofbirth => "1990",
      :country => "United States",
      :state => "TX",
      :city => "Houston",
      :phone => 82711,
      :industry => "Professional",
      :company => "Test company",
      :emailaddr => "ive.yi@gmail.com",
      :highlights => "dummy"
    })
end


Given(/^I am a valid gallery user$/) do
  @login_info = LoginInfo.create!({
     :email => "hellofriend@gmail.com",
     :password => "Apple12345*",
     :password_confirmation => "Apple12345*"
   })
  @general_info = GeneralInfo.create!({
     :first_name => "Ive",
     :last_name => "Yi",
     :month_ofbirth => "January",
     :day_ofbirth => "23",
     :year_ofbirth => "1990",
     :country => "United States",
     :state => "TX",
     :city => "Houston",
     :phone => 82711,
     :industry => "Professional",
     :company => "Test company",
     :emailaddr => "ive.yi@gmail.com",
     :highlights => "dummy"
   })
  image_path1 = File.join(Rails.root, 'app', 'assets', 'images', '1.jpg')
  image_file1 = Rack::Test::UploadedFile.new(image_path1, 'image/jpeg')

  image_path2 = File.join(Rails.root, 'app', 'assets', 'images', '2.jpg')
  image_file2 = Rack::Test::UploadedFile.new(image_path2, 'image/jpeg')

  image_path3 = File.join(Rails.root, 'app', 'assets', 'images', '3.jpg')
  image_file3 = Rack::Test::UploadedFile.new(image_path3, 'image/jpeg')

   @gallery = Gallery.create!(gallery_title: "testgallery",
    id: "100",
    gallery_description: "test description",
    gallery_totalRate: "4",
    GeneralInfo_id: @general_info.id,
    gallery_totalRator: "4",
    gallery_picture: [image_file1, image_file2, image_file3])
end














Given(/^I am an invalid user$/) do
   @login_info = nil
end


When(/^I try to log in$/) do
  visit 'login_info/login'
  fill_in "email", :with => nil
  fill_in "password", :with => nil
  click_button "Login"
end

# Then(/^I should see "(.*?)"$/) do |field_name|
#   case field_name
#   when "Logged In!"
#     page.has_content?("Logged In!")
#   when "Incorrect Email!"
#     page.has_content?("Incorrect Email")
#   when "Incorrect Password"
#     page.has_content?("Incorrect Password")
#   end
# end

And(/^I am now on home page$/) do
  visit root_path
end

And(/^I fill in "([^"]*)" field with "([^"]*)"$/) do |field, value|
  fill_in(field, with: value)
end
