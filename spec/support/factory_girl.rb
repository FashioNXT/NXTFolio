RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

# RSpec without Rails
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.find_definitions
  end
end

FactoryGirl.define do
  factory :login_info do
    email   "me@me.com"
    password "pass123"
  end
end

# Factory.define :login_info, :class => LoginInfo do |f|
#   f.first_name "Mickey"
#   f.last_name  "Mouse"
#   f.email   "me@me.com"
#   f.content "pass123"
# end