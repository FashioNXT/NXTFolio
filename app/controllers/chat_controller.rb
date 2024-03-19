class ChatController < ApplicationController
  #def index
  #end

  def chat
    user_input = params[:user_input]
    chat_service = ChatService.new
    response = chat_service.call(user_input)

    render json: { response: response }
  end
end
