require "rails_helper"

RSpec.describe LoginInfoController, type: :controller do
  describe "GET #login" do
    # subject { get :new }
    it "returns"
    it "renders the index template" do
      expect(subject).to render_template(:new)
      expect(subject).to render_template("new")
      expect(subject).to render_template("login_info/new")
    end

    it "does not render a different template" do
      expect(subject).to_not render_template("login_info/edit")
    end
  end
  
  # describe "GET #edit"
  #   subject { get :edit }

  #   it "renders the edit template" do
  #     expect(subject).to render_template(:edit)
  #     expect(subject).to render_template("edit")
  #     expect(subject).to render_template("login_info/edit")
  #   end

  #   it "does not render a different template" do
  #     expect(subject).to_not render_template("login_info/new")
  #   end
  # end
end