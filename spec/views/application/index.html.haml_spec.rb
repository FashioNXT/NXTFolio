require "rails_helper"

RSpec.describe 'application/index', :type => :view do
  it 'renders the index view' do

    render

    expect(view).to render_template(:index)
    expect(view).to render_template("index")
    expect(view).to render_template("application/index")
  end

  it "does not render a different template" do
    expect(view).to_not render_template("general_info/new")
  end
end