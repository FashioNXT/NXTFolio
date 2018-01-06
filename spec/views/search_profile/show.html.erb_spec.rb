require "rails_helper"

RSpec.describe 'search_profile/show', :type => :view do
  it 'renders the search view' do

    # render
    #
    # expect(view).to render_template(:show)
    # expect(view).to render_template("show")
    # expect(view).to render_template("search_profile/show")
  end

  it "does not render a different template" do
    expect(view).to_not render_template("search_profile/search")
  end
end