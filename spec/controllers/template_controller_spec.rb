require 'rails_helper'

RSpec.describe TemplateController, type: :controller do

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to_not have_http_status(:success)
    end

    it "returns http success with field_name_arr" do
        post :create, params: {:field_name => ['test_field_name'], :field_type => ['test_field_type']}
        expect(response).to_not have_http_status(:success)
      end
  end

  describe "GET #index" do
    it "returns http error" do
      get :index 
      expect(response).to_not have_http_status(:error)
    end
  end

end
