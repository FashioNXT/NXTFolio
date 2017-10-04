require "rails_helper"

RSpec.describe 'specific_designer/new', :type => :view do
  it 'renders the new view' do
    assign(:specific_designer, SpecificDesigner.create!({
      :influencers => "Bob Billy",
      :specialties => "Handstands",
      :compensation => "Any",
      :experience => "0-2 years",
      :genre => "Acting"
    }))

    render

    rendered.should match "Bob Billy"
    rendered.should match "Handstands"
    rendered.should match "Any"
    rendered.should match "0-2 years"
    rendered.should match "Acting"
  end
end