Given(/^the following project exist:$/) do |table|
    table.hashes.each do |gallery|
    # Remove " and set the path to the file
    gallery['gallery_picture'] = gallery['gallery_picture'].gsub('"', '') if gallery['gallery_picture']
    file_path = Rails.root.join("db", "seed_files", gallery['gallery_picture'])

    # Create a GeneralInfo record with values and a fake profile picture
    general_info = GeneralInfo.new
    general_info.first_name = "John"
    general_info.last_name = "Doe"
    general_info.userKey = "user123"
    general_info.company = "TestInc"
    general_info.industry = "Fashion"
    general_info.job_name = "Designer"
    general_info.highlights = "Just a test User"
    general_info.country = "United States"
    general_info.state = "Texas"
    general_info.city = "College Station"
    general_info.emailaddr = "john.doe@example.com"
    general_info.profile_picture = Rack::Test::UploadedFile.new(file_path, 'image/jpeg') # Update to 'image/jpeg' for test_pic.jpg
    general_info.save!

    # Simulate file uploads using Rack::Test::UploadedFile for the Gallery
    gallery_pictures = [Rack::Test::UploadedFile.new(file_path, 'image/jpeg')] # Update to 'image/jpeg'
    test_pictures = [Rack::Test::UploadedFile.new(file_path, 'image/jpeg')] # Update to 'image/jpeg'

    # Create the Gallery record with the necessary attributes
    Gallery.create!(
      gallery_title: gallery['gallery_title'],
      gallery_description: gallery['gallery_description'],
      GeneralInfo_id: general_info.id,
      gallery_picture: gallery_pictures,
      test_picture: test_pictures
    )
    end
  end
