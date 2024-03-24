require 'rails_helper' 

RSpec.describe SpecificPhotographer, type: :model do
    describe 'search' do
        it 'search with valid parameters' do
            general_info = GeneralInfo.create(first_name: 'John', last_name: 'Johns', city: 'Houston', state: 'Texas', country: 'United States', company: 'test company', industry: 'Creator', highlights: 'test', emailaddr: 'abcd@email.com', userKey: SecureRandom.hex(10), specific_profile_id: 3)
            described_class.create({:user_key => general_info.userKey, :influencers => "Me", :specialties => "Being cool", :compensation => "Any", :experience => "11+ years", :genre => "Acting"})
            params = {"checkboxes" => ["Acting"]}
            final_return = SpecificPhotographer.search params
            expect(final_return[0]).to eq(general_info.userKey)
        end 

        it 'search with invalid parameters' do
            general_info = GeneralInfo.create(first_name: 'John', last_name: 'Johns', city: 'Houston', state: 'Texas', country: 'United States', company: 'test company', industry: 'Creator', highlights: 'test', emailaddr: 'abcd@email.com', userKey: SecureRandom.hex(10), specific_profile_id: 3)
            described_class.create({:user_key => general_info.userKey, :influencers => "Me", :specialties => "Being cool", :compensation => "Any", :experience => "11+ years", :genre => "Acting"})
            params = {"test" => "test"}
            final_return = SpecificPhotographer.search params
            expect(final_return).to be_empty
        end 

        it 'search without parameters' do
            general_info = GeneralInfo.create(first_name: 'John', last_name: 'Johns', city: 'Houston', state: 'Texas', country: 'United States', company: 'test company', industry: 'Creator', highlights: 'test', emailaddr: 'abcd@email.com', userKey: SecureRandom.hex(10), specific_profile_id: 3)
            params = {}
            final_return = SpecificPhotographer.search params
            expect(final_return[0]).to eq(general_info.userKey)
        end

        it 'search without existing photographer' do
            general_info = GeneralInfo.create(first_name: 'John', last_name: 'Johns', city: 'Houston', state: 'Texas', country: 'United States', company: 'test company', industry: 'Creator', highlights: 'test', emailaddr: 'abcd@email.com', userKey: SecureRandom.hex(10), specific_profile_id: 3)
            params = {"checkboxes" => ["Acting"]}
            final_return = SpecificPhotographer.search params
            expect(final_return).to be_empty
        end
    end

    describe 'attribute_values' do
        it 'attribute_values' do
            specific_photographer = described_class.create({:influencers => "Me", :specialties => "Being cool", :compensation => "Any", :experience => "11+ years", :genre => "Acting"})
            specific_photographer.attribute_values
        end
    end
end