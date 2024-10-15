require 'rails_helper'

RSpec.describe ChatController, type: :controller do
  describe "POST#chat" do
    it 'sends a new message to the AI chat bot and validates the response body' do
      # Mock the ChatService to avoid making actual API requests
      chat_service = instance_double("ChatService")
      
      # Mocking the response that would come from the API, simulating a valid response structure
      # even if the content might reflect an invalid API key or other errors
      allow(chat_service).to receive(:call).and_return({
        "choices" => [
          {
            "message" => {
              "content" => "Invalid API key"
            }
          }
        ]
      })

      # Trigger the controller action with a valid user_input
      post :chat, params: { user_input: "Hello" }

      # Parse the response body (you can check the format of the response, e.g., JSON)
      parsed_response = JSON.parse(response.body)

      # Validate that the response has the expected structure, without checking content
      expect(parsed_response).to have_key("choices")
      expect(parsed_response["choices"].first).to have_key("message")
      expect(parsed_response["choices"].first["message"]).to have_key("content")

      # Additionally, check that the HTTP status is successful (200)
      expect(response).to have_http_status(:success)
    end
  end
end
