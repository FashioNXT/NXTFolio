class AboutMeGenerator
    AI_RELEVANT_ATTRIBUTES = [
      :first_name,
      :last_name,
      :company,
      :industry,
      :specialization,
      :experience,
      :city,
      :state,
      :country,
      :highlights,
      :job_name,
      :compensation
    ]
  
    def initialize(general_info)
      @general_info = general_info
    end
  
    def generate_about_me
      chat_service = ChatService.new
      content = []
      

      # Generate message to send to api to recieve about me response
      content << "Write an about me message that tells us what makes you unique and different, what are your hobbies and skills, etc using the following information. The response must be less than or equal to 200 characters including spaces."
      content << "I am a #{@general_info.industry.downcase} specializing in #{@general_info.specialization.downcase}" if @general_info.industry && @general_info.specialization
      content << "based in #{@general_info.city}, #{@general_info.state}, #{@general_info.country}" if @general_info.city && @general_info.state && @general_info.country
      content << "currently working at #{@general_info.company}" if @general_info.company
      content << "with #{@general_info.experience} years of experience." if @general_info.experience
      content << "My highlights include: #{@general_info.highlights}." if @general_info.highlights
  
      # Fallback message if no bio content is generated
      about_me_content = content.join(' ')
      about_me_content = "A brief bio about John Doe." if about_me_content.blank?
  
      # Check for missing fields
      missing = missing_fields
      #if missing.any?
        #about_me_content += "\nThe following details are missing: #{missing.join(', ')}"
      #end
      puts "About me content sent to API: #{about_me_content}"
      response = chat_service.call(about_me_content)
      response
    end
  
    def missing_fields
      AI_RELEVANT_ATTRIBUTES.select do |attribute|
        value = @general_info[attribute]
        value.nil? || (value.blank? && ![false, [], {}].include?(value))
      end
    end
  end
  