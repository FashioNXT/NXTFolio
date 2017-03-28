require "rails_helper"

RSpec.describe 'general_info/search', :type => :view do
  it 'renders the search view' do
    assign(:general_info, GeneralInfo.create!({
      :first_name => "Bob",
      :last_name => "Billy",
      :month_ofbirth => "Jan",
      :day_ofbirth => "01",
      :year_ofbirth => "2000",
      :country => "United States",
      :state => "TX",
      :city => "Paris"
    }))

    render

    # rendered.should match "Bob"
    # rendered.should match "Billy"
    # rendered.should match "Jan"
    # rendered.should match "01"
    # rendered.should match "2000"
    # rendered.should match "United States"
    # rendered.should match "TX"
    # rendered.should match "Paris"
  end
end