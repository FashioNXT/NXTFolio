require 'rails_helper'

RSpec.describe "galleries/new.html.erb", type: :view do
  #pending "add some examples to (or delete) #{__FILE__}"
  before do
    assign(:gallery, Gallery.new)
    render
  end

  it "displays the correct title" do
    expect(rendered).to have_title("FashioNXT")
  end

  it "displays the 'Upload Project' heading" do
    expect(rendered).to have_selector("h2", text: "Upload Project")
  end

  it "includes form fields for gallery creation" do
    expect(rendered).to have_field("Gallery Title* (Required)")
    expect(rendered).to have_field("Gallery Description* (Required)")
    expect(rendered).to have_field("Gallery Pictures* (Required, only 5 pictures!)")
  end

  it "includes submit and cancel buttons" do
    expect(rendered).to have_button("Submit")
    expect(rendered).to have_link("Cancel", href: "/show_profile")
  end
end


