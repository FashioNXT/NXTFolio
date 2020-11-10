require "rails_helper"

RSpec.describe 'login_info/new', :type => :view do
  it 'renders the new template for sign up' do
    assign(:login_info, LoginInfo.create!({
      :email => "hellofriend@gmail.com",
      :password => "Apple12345*",
      :password_confirmation => "Apple12345*"
    }))

    render

    # rendered.should match 'hellofriend@gmail.com'
    # rendered.should match 'password'
  end
end
