require 'rails_helper'

RSpec.describe ChatController, type: :controller do
  describe "POST#chat" do
    let(:valid_response) { "\n\nHello there, how may I assist you today?" }
    let(:invalid_response) { nil }

    context "with a valid API key" do
      before do
        # Mocking the ChatService to return a valid response
        chat_service = instance_double("ChatService")
        allow(ChatService).to receive(:new).and_return(chat_service)
        allow(chat_service).to receive(:call).and_return(valid_response)
      end

      it 'sends a new message to the AI chat bot and validates the response body' do
        # Trigger the controller action with a valid user_input
        post :chat, params: { user_input: "Hello" }

        # Parse the response body
        parsed_response = JSON.parse(response.body)

        # Validate that the response has the expected structure
        expect(parsed_response).to have_key("response")
        expect(parsed_response["response"]).to eq(valid_response)

        # Additionally, check that the HTTP status is successful (200)
        expect(response).to have_http_status(:success)
      end
    end

    context "with an invalid API key or failed response" do
      before do
        # Mocking the ChatService to return an invalid response (nil)
        chat_service = instance_double("ChatService")
        allow(ChatService).to receive(:new).and_return(chat_service)
        allow(chat_service).to receive(:call).and_return(invalid_response)
      end

      it 'handles the failed response gracefully' do
        # Trigger the controller action with a valid user_input
        post :chat, params: { user_input: "Hello" }

        # Parse the response body
        parsed_response = JSON.parse(response.body)

        # Validate that the response contains an error message
        expect(parsed_response).to have_key("error")
        expect(parsed_response["error"]).to eq("No response from OpenAI")

        # Additionally, check that the HTTP status reflects unprocessable entity (422)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
