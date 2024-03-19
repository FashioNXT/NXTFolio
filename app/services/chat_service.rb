class ChatService
  attr_reader :message

  def initialize
    new_chat
  end

  public
  def call(user_input)
    messages = training_prompts.map do |prompt|
      { role: "system", content: prompt }
    end


    # conversation_complete = false
    # while !conversation_complete
    # user_input = get_user_input
    messages << { role: "user", content: user_input }
    puts messages
    # send_request(messages)

    response = send_request(messages)
    puts response
    answer = response.dig("choices", 0, "message", "content")
    puts answer

    return answer
    # messages << { role: "assistant", content: answer }

      # conversation_complete = user_input.downcase.strip == "exit"
    # end
  end

  private
  def training_prompts
    [
      # "Do you know who captain jean luc picard is? Just tell me yes or no",
      # "Can you pretend to be captain jean luc picard from here on out? Answer yes or no",
      # "You are a tour guide",
      'You are an expert on fashion and social media marketing',
    ]
  end

  # private
  # def get_user_input
  #   print "You: "
  #   gets.chomp
  # end

  private
  def new_chat
    @openaiClient = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"],
    # @openaiClient = OpenAI::Client.new(access_token: Rails.application.credentials.open_ai_api_key,
      uri_base: "https://oai.hconeai.com/",
      request_timeout: 240)
  end

  private
  def send_request(messages)
    @openaiClient.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: messages,
        temperature: 0.7,
      #   stream: proc do |chunk, _bytesize|
      #     print chunk.dig("choices", 0, "delta", "content")
      # end
      }
    )
  end
end
