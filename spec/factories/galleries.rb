FactoryBot.define do
  factory :gallery do
    gallery_title { "MyString" }
    gallery_description { "MyText" }
    gallery_picture { "MyString" }
    gallery_totalRate { 1.5 }
    gallery_totalRator { 1 }
    GeneralInfo_id { 1 }
  end
end
