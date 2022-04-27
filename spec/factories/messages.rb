FactoryBot.define do
  factory :message do
    general_info { nil }
    room { nil }
    body { "MyText" }
  end
end
