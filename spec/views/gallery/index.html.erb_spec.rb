require 'rails_helper'

RSpec.describe "gallery/index.html.erb", type: :view do
  #pending "add some examples to (or delete) #{__FILE__}"
  before do
    stub_template "gallery/index.html.erb" => <<-HTML
      <h1>Gallery#index</h1>
      <p>Find me in app/views/gallery/index.html.erb</p>
    HTML
    render
  end

  it "displays the correct heading" do
    expect(rendered).to have_selector('h1', text: 'Gallery#index')
  end

  it "includes the correct paragraph text" do
    expect(rendered).to have_selector('p', text: 'Find me in app/views/gallery/index.html.erb')
  end
end
