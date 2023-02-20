# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.destroy_all
LoginInfo.destroy_all
GeneralInfo.destroy_all
Gallery.destroy_all

dir_path = "seed_files"
fake_password = "Test1234!"

filenames = ["Andrea-Piacquadio.jpg", "Anthony-Gray.jpg", "Jack-Winbow.jpg", "James-Lawrence.jpg", "Masha-Raymers.jpg", "Tasha-Washington.jpg"]
filenames.each do |filename|
#   puts filename
  name = filename.gsub(".jpg", "").split("-")
  first_name = name[0]
  last_name = name[1]
  LoginInfo.create!(
    email: "#{first_name}.#{last_name}@example.com",
    password: fake_password,
    password_confirmation: fake_password
  )
  GeneralInfo.create!(
    first_name: first_name,
    last_name: last_name,
    company: "TestInc",
    industry: "Model",
    highlights: "Just a test User",
    country: "United States",
    state: "Texas",
    city: "College Station",
    emailaddr: "#{first_name}.#{last_name}@example.com",
    profile_picture: File.open(Rails.root.join("db", "seed_files" ,filename))
  )
 
  puts "Creating User " + first_name + ", " + last_name + "..."
end

puts "Creating fake galleries..."
(1..10).each do |i| 
    Gallery.create!(
        gallery_title: "Test Gallery",
        gallery_description: "Just a test gallery",
        GeneralInfo_id: i % 6 + 1, # 6 users, so only allow ids from 1 to 
        gallery_picture: [File.open(Rails.root.join("db", "seed_files" , "test_pic.jpg"))]
    )
end
