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
Country.destroy_all
State.destroy_all
City.destroy_all

filename = "countries+states+cities.json"
puts "Seeding countries/states/cities from #{filename}"

countries_data = File.read(Rails.root.join('db', 'seed_files', filename))
countries = JSON.parse(countries_data)

num_countries = countries.length
Country.transaction do
  countries.each_with_index do |country, idx|
    print "\rCountry #{idx} of #{num_countries}"
    STDOUT.flush

    # phone_code = country['phone_code']
    # phone_code = phone_code.start_with?("+") ? phone_code[1..-1] : phone_code

    # create country
    country_obj = Country.create!(
      name: country['name'],
      iso3: country['iso3'],
      # phone_code: phone_code,
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

      # create each city
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

# User.destroy_all
LoginInfo.destroy_all
GeneralInfo.destroy_all
Gallery.destroy_all

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

puts "Creating fake galleries..."
(1..10).each do |i| 
    Gallery.create!(
        gallery_title: "Test Gallery",
        gallery_description: "Just a test gallery",
        GeneralInfo_id: i % 6 + 1, # 6 users, so only allow ids from 1 to 
        gallery_picture: [File.open(Rails.root.join("db", "seed_files" , "test_pic.jpg"))]
    )
end
