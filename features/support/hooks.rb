require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

Before do
    DatabaseCleaner.clean
end

After do
    DatabaseCleaner.clean
end


Before('@load-seed-data') do
    load File.join(Rails.root, 'db', 'seeds.rb')
end
