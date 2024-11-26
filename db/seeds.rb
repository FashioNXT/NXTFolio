# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#####################################
### SEED COUNTRIES/STATE/CITIES #####
#####################################
require 'json'

puts "Clearing tables..."
City.delete_all
State.delete_all
Country.delete_all

filename = "countries+states+cities.json"
puts "Seeding countries/states/cities from #{filename}"

countries_data = File.read(Rails.root.join('db', 'seed_files', filename))
countries = JSON.parse(countries_data)

num_countries = countries.length
Country.transaction do
   countries.each_with_index do |country, idx|
     print "\rCountry #{idx} of #{num_countries}"
     STDOUT.flush
     phone_code = country['phone_code']
     phone_code = phone_code.start_with?("+") ? phone_code[1..-1] : phone_code

#     # create country
     country_obj = Country.create!(
       name: country['name'],
       iso3: country['iso3'],
        phone_code: phone_code,
       capital: country['capital'],
       currency: country['currency'],
       region: country['region'],
       subregion: country['subregion'],
       latitude: country['latitude'],
       longitude: country['longitude'],
     )

     # create each of the states
     country['states'].each do |state|
       state_obj = country_obj.states.create!(
         name: state['name'],
         state_code: state['state_code'],
         latitude: state['latitude'],
         longitude: state['longitude'],
       )

#       # create each city
       state['cities'].each do |city|
         state_obj.cities.create!(
           name: city['name'],
           latitude: city['latitude'],
           longitude: city['longitude'],
         )
       end
     end
   end
 end

# #####################################
# ### CREATE FAKE USERS ###############
# #####################################
require 'securerandom'

LoginInfo.destroy_all
GeneralInfo.destroy_all
Gallery.destroy_all
Follow.destroy_all

dir_path = "seed_files"
fake_password = "Test1234!"

filenames = ["Andrea-Piacquadio.jpg", "Anthony-Gray.jpg", "Jack-Winbow.jpg", "James-Lawrence.jpg", "Masha-Raymers.jpg", "Tasha-Washington.jpg"]
job_names = ["Brand Owner", "Designer", "Other Creator", "Model", "Photographer",  "Sales", "Marketing", "Retail", "Visual", "Content Creator", "Blogger",  "Influencer", "Forecasting", "Finances", "Other Services", "Manufacturing",  "Materials", "Other Makers"]

# # generate a few users
 puts "==> Creating fake users..."
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
   general_info.job_name = job_names.sample
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
        Follow.create!(:follower => follower, :followee => followee)
     end
   end
 end

puts "Creating fake galleries..."
(1..10).each do |i|
    Gallery.create!(
        gallery_title: "Test Gallery",
        gallery_description: "Just a test gallery",
        GeneralInfo_id: i % 6 + 1, # 6 users, so only allow ids from 1 to
        gallery_picture: [File.open(Rails.root.join("db", "seed_files" , "Jack-Winbow.jpg"))],
        test_picture: [File.open(Rails.root.join("db", "seed_files" , "Jack-Winbow.jpg"))]
    )
end

# require 'faker'
# # generate extra users and galleries
# puts "==> Generate extra fake users..."
# 200.times do
#   first_name = Faker::Name.first_name
#   last_name = Faker::Name.last_name
#   email = "#{first_name}.#{last_name}@example.com"
#   userkey = SecureRandom.hex(10)

#   login_info = LoginInfo.new(
#     email: "#{first_name}.#{last_name}@example.com",
#     password: fake_password,
#     password_confirmation: fake_password,
#     userKey: userkey
#   )
#   login_info.save!

#   general_info = GeneralInfo.new(
#     first_name: first_name,
#     last_name: last_name,
#     userKey: userkey,
#     company: "TestInc",
#     industry: "Fashion",
#     job_name: job_names.sample,
#     highlights: "Just a test User",
#     country: "United States",
#     state: "Texas",
#     city: "College Station",
#     emailaddr: email,
#     profile_picture: File.open(Rails.root.join("db", "seed_files" , filenames.sample))
#   )
#   general_info.save!

#   general_info = GeneralInfo.find_by(emailaddr: email)

#   num_galleries = rand(1..3)
#   num_galleries.times do
#     gallery = Gallery.new(
#       gallery_title: Faker::Lorem.sentence(word_count: 3),
#       gallery_description: Faker::Lorem.sentence(word_count: 10),
#       GeneralInfo_id: general_info.id,
#       gallery_picture: [File.open(Rails.root.join("db", "seed_files", "test_pic.jpg"))]
#     )
#     gallery.save!
#   end
# end


# # generate fake jobs
# puts "==> Generate fake jobs..."
# state_list = ["Texas", "Texas", "California", "New York", "Iowa", "Florida", "Washington"]
# city_list = ["College Station", "Houston", "San Diago", "New York City", "Iowa City", "Miami", "Seattle"]
# # category_list = ["Creators", "Services", "Makers"]
# creator_list = ["Brand Owner", "Designer"]
# service_list = ["Model", "Photographer", "Sales", "Marketing", "Blogger", "Finances"]
# maker_list = ["Manufacturing", "Materials"]

# (1..100).each do |ind|
#   location_index = ind % state_list.length()
#   state = state_list[location_index]
#   city = city_list[location_index]
#   if ind < 20
#     category = "Creators"
#     profession = creator_list[ind % creator_list.length()-1]
#   elsif ind < 70
#     category = "Services"
#     profession = service_list[ind % service_list.length()-1]
#   else
#     category = "Makers"
#     profession = maker_list[ind % maker_list.length()-1]
#   end

#   title = profession + rand(1..100).to_s
#   description = "This is a fake job of " + profession
#   userKey = SecureRandom.hex(10)

#   job_info = JobInfo.new(
#     title: title,
#     description: description,
#     category: category,
#     profession: profession,
#     country: "United States",
#     state: state,
#     city: city,
#     low_salary: 1000,
#     high_salary: 2000,
#     userKey: userKey
#   )
#   job_info.save!
# end

# galleries = [
#   {:gallery_title => 'My Neighbor Totoro', :gallery_description => 'G',
#     :GeneralInfo_id => 2,
#     :gallery_picture => [File.open(Rails.root.join("db", "seed_files" , "test_pic.jpg"))]},
#   {:gallery_title => 'CODA', :gallery_description => 'PG-13',
#     :GeneralInfo_id => 1,
#     :gallery_picture => [File.open(Rails.root.join("db", "seed_files" , "test_pic.jpg"))]}
# ]

# galleries.each do |gallery|
#   Gallery.create!(gallery)
# end
