# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.destroy_all
LoginInfo.destroy_all

dir_path = "seed_files"
fake_password = "Test1234!"

filenames = ["Andrea-Piacquadio.jpg", "Anthony-Gray.jpg", "Jack-Window", "James-Lawrence.jpg", "Masha-Raymers.jpg", "Tasha-Washington.jpg"]
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
  
  puts "Creating User " + first_name + ", " + last_name

end