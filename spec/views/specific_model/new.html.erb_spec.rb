require "rails_helper"

RSpec.describe 'specific_model/new', :type => :view do
  it 'renders the new view' do
    assign(:specific_model, SpecificModel.create!({
      :height_feet => 4,
      :height_inches => 2,
      :bust => 44,
      :waist => 12,
      :hips => 60,
      :cups => "AA",
      :shoe_size => "12",
      :dress_size => 2,
      :hair_color => "Brown",
      :eye_color => "Blue",
      :ethnicity => "Puerto Rican",
      :skin_color => "White",
      :shoot_nudes => "No",
      :tattoos => "Yes",
      :piercings => "Yes",
      :experience => "Professional",
      :genre => "Acting"
    }))

    render

    # rendered.should match "4"
    # rendered.should match "2"
    # rendered.should match "44"
    # rendered.should match "12"
    # rendered.should match "60"
    # rendered.should match "AA"
    # rendered.should match "12"
    # rendered.should match "2"
    # rendered.should match "Brown"
    # rendered.should match "Blue"
    # rendered.should match "Puerto Rican"
    # rendered.should match "White"
    # rendered.should match "No"
    # rendered.should match "Yes"
    # rendered.should match "Yes"
    # rendered.should match "Professional"
    # rendered.should match "Acting"
  end
end