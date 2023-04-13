FactoryBot.define do
  factory :country do
    name { "MyString" }
    iso3 { "MyString" }
    phone_code { "MyString" }
    capital { "MyString" }
    currency { "MyString" }
    region { "MyString" }
    subregion { "MyString" }
    latitude { 1.5 }
    longitude { 1.5 }
  end
end
