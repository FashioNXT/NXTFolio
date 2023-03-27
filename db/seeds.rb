# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'securerandom'

# User.destroy_all
LoginInfo.destroy_all
GeneralInfo.destroy_all
Gallery.destroy_all
Follow.destroy_all

dir_path = "seed_files"
fake_password = "Test1234!"

filenames = ["Andrea-Piacquadio.jpg", "Anthony-Gray.jpg", "Jack-Winbow.jpg", "James-Lawrence.jpg", "Masha-Raymers.jpg", "Tasha-Washington.jpg"]
filenames.each do |filename|

  name = filename.gsub(".jpg", "").split("-")
  first_name = name[0]
  last_name = name[1]
  userkey = SecureRandom.hex(10)
  login_info = LoginInfo.new
  login_info.email = "#{first_name}.#{last_name}@example.com"
  login_info.password = fake_password
  login_info.password_confirmation = fake_password
  login_info.userKey = userkey
  login_info.save!

  general_info = GeneralInfo.new
  general_info.first_name = first_name
  general_info.last_name = last_name
  general_info.userKey = userkey
  general_info.company = "TestInc"
  general_info.industry = "Fashion"
  general_info.job_name = "Model"
  general_info.highlights = "Just a test User"
  general_info.country = "United States"
  general_info.state = "Texas"
  general_info.city = "College Station"
  general_info.emailaddr = "#{first_name}.#{last_name}@example.com"
  general_info.profile_picture = File.open(Rails.root.join("db", "seed_files" ,filename))
  general_info.save!
 
  puts "Creating User " + first_name + ", " + last_name + "..."
end

puts "Creating fake follower/followee connections..."
(1..filenames.length()).each do |i|
  follower = GeneralInfo.find(i)
  (1..3).each do |j| 
    random_user = rand(1..filenames.length())
    followee = GeneralInfo.find(random_user)
    if not Follow.exists?(:follower => follower, :followee => followee) and i != random_user
      follower.follow(random_user)
      # Follow.create!(:follower => follower, :followee => followee)
    end
  end
end

# # Basic test of Follow model relations
# user = GeneralInfo.find(1)
# puts user[:first_name] + " has the below followers"
# user.get_followers.map do |u| 
#   puts u[:first_name]
# end

# puts user[:first_name] + " follows the below users"
# user.get_users_they_follow.map do |u| 
#   puts u[:first_name]
# end

# puts user[:first_name] + " will now unfollow all users"
# user.get_users_they_follow.map do |u| 
#   puts "Unfollowing " + u[:first_name]
#   user.unfollow(u.id)
# end

# puts "Now " + user[:first_name] + " follows the below users"
# user.get_users_they_follow.map do |u| 
#   puts u[:first_name]
# end


puts "Creating fake galleries..."
(1..10).each do |i| 
    Gallery.create!(
        gallery_title: "Test Gallery",
        gallery_description: "Just a test gallery",
        GeneralInfo_id: i % 6 + 1, # 6 users, so only allow ids from 1 to 
        gallery_picture: [File.open(Rails.root.join("db", "seed_files" , "test_pic.jpg"))]
    )
end
