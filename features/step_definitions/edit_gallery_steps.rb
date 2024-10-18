Given(/^the following project exist:$/) do |table|
    table.hashes.each do |gallery|
      gallery['gallery_picture'] = gallery['gallery_picture'].gsub('"', '') if gallery['gallery_picture']
      
      Gallery.create!(gallery_title: gallery['gallery_title'],
                      gallery_description: gallery['gallery_description'],
                      gallery_picture: gallery['gallery_picture'])
    end
  end
  