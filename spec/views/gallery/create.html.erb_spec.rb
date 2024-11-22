require 'rails_helper'

RSpec.describe "gallery/create.html.erb", type: :view do
  #pending "add some examples to (or delete) #{__FILE__}"
  before do
    stub_template "gallery/create.html.erb" => <<-HTML
      <h1>Gallery#create</h1>
      <p>Find me in app/views/gallery/create.html.erb</p>
    HTML
  end

  it "displays the correct heading" do
    render
    expect(rendered).to have_selector('h1', text: 'Gallery#create')
  end

  it "includes the correct paragraph text" do
    render
    expect(rendered).to have_selector('p', text: 'Find me in app/views/gallery/create.html.erb')
  end
end
