require "rails_helper"

RSpec.describe 'specific_photographer/new', :type => :view do
  it 'renders the new view' do
    assign(:specific_photographer, SpecificPhotographer.create!({
      :compensation => "Any",
      :experience => "0-2 years",
      :influencers => "Bob Billy",
      :specialties => "Handstands",
      :genre => "Acting"
    }))

    render

    rendered.should match "Any"
    rendered.should match "0-2 years"
    rendered.should match "Bob Billy"
    rendered.should match "Handstands"
    rendered.should match "Acting"
  end
end