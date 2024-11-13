require 'rails_helper'

RSpec.describe AboutMeGenerator, type: :service do
  let(:general_info) do
    OpenStruct.new(
      first_name: "John",
      last_name: "Doe",
      company: "TechCorp",
      industry: "Software Engineering",
      specialization: "Backend Development",
      experience: 5,
      city: "New York",
      state: "NY",
      country: "USA",
      gender: "Male",
      highlights: "Developed scalable microservices",
      job_name: "Software Engineer",
      compensation: 120000
    )
  end

  subject { described_class.new(general_info) }

  describe '#generate_about_me' do
    context 'when all relevant attributes are present' do
      it 'generates about me content that includes relevant details' do
        # Mock the ChatService and set expectation on the `call` method
        chat_service_double = instance_double("ChatService")
        allow(ChatService).to receive(:new).and_return(chat_service_double)
        expect(chat_service_double).to receive(:call).with(a_string_including(
          "Write an about me message that tells us what makes you unique and different"
        )).and_return("This is a mocked response with details about me.")
  
        # Run the service method
        about_me_content = subject.generate_about_me
  
        # Ensure the output is a string
        expect(about_me_content).to be_a(String)
      end
    end

    context 'when some relevant attributes are missing' do
      before do
        general_info.city = nil
        general_info.state = nil
      end
    end
  end

  describe '#missing_fields' do
    context 'when some fields are missing' do
      before do
        general_info.company = nil
        general_info.experience = nil
      end

      it 'returns only the missing fields' do
        expect(subject.missing_fields).to include(:company, :experience)
        expect(subject.missing_fields.size).to eq(2)  # Verify the count of missing fields
      end
    end

    context 'when all fields are present' do
      it 'returns an empty array' do
        expect(subject.missing_fields).to be_empty
      end
    end

    context 'when all fields are missing' do
      let(:general_info) { OpenStruct.new }

      it 'returns all relevant attributes as missing fields' do
        expect(subject.missing_fields).to match_array(AboutMeGenerator::AI_RELEVANT_ATTRIBUTES)
      end
    end
  end
end
