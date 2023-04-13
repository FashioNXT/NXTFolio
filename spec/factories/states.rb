FactoryBot.define do
  factory :state do
    name { "MyString" }
    state_code { "MyString" }
    latitude { 1.5 }
    longitude { 1.5 }
    country { nil }
  end
end
