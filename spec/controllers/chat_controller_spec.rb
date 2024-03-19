require 'rails_helper'

RSpec.describe ChatController, type: :controller do
    describe "POST#chat" do
        it 'sends a new message to the AI chat bot' do
            post :chat, params: {user_input: "Hello"}
        end
    end
end