FactoryBot.define do
  factory :user_activity_detail do
    user_id { 1 }
    logged_in_at { "2023-04-25 08:37:09" }
    last_active_at { "2023-04-25 08:37:09" }
    time_spent_on_website { 1 }
  end
end
