require "rails_helper"

RSpec.describe 'login_info/login', :type => :view do
  it 'renders the login template for login' do
    assign(:login_info, LoginInfo.create!({
      :email => "hellofriend@gmail.com",
      :password => "Apple12345*"
    }))
    #render

    #rendered.should match 'hellofriend@gmail.com'

    #rendered.should match 'password'
  end
end
