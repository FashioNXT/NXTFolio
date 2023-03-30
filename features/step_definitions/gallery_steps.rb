Given(/that (\d+) projects exist/) do |number_of_galleries|
    (1..number_of_galleries.to_i).each do |i| 
        Gallery.create!(
            gallery_title: "Test Gallery #{i}",
            gallery_description: "Just a test gallery",
            GeneralInfo_id: i % 3 + 1, 
            gallery_picture: [File.open(Rails.root.join("db", "seed_files" , "test_pic.jpg"))]
        )
    end
  end