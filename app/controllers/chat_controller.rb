class ChatController < ApplicationController
  def chat
    user_input = params[:user_input]

    chat_service = ChatService.new
    response = chat_service.call(user_input)

    if response.nil? || response.empty?
      render json: { error: 'No response from OpenAI' }, status: :unprocessable_entity
    else
      render json: { response: response }, status: :ok
    end
  end
end
