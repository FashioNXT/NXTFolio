require 'rails_helper'

RSpec.describe SpecificModel, type: :model do
    describe 'search' do
        it 'search with valid parameters and height and dress size in range' do
            general_info = GeneralInfo.create(first_name: 'John', last_name: 'Johns', city: 'Houston', state: 'Texas', country: 'United States', company: 'test company', industry: 'Creator', highlights: 'test', emailaddr: 'abcd@email.com', userKey: SecureRandom.hex(10), specific_profile_id: 2)
            described_class.create({:user_key => general_info.userKey, :height_feet => 5, :height_inches => 5, :bust => 36, :waist => 24, :hips => 36, :cups => "C", :dress_size => 8, :hair_color => "black", :eye_color => "brown", :ethnicity => "English", :skin_color => "white", :shoot_nudes => "no", :experience => "5 years", :genre => "Acting"})
            params = {"checkboxes" => ["Acting"], "min_height" => "5.0", "max_height" => "6.0", "min_dress_size" => "2", "max_dress_size" => "10"}
            final_return = SpecificModel.search params
            expect(final_return[0]).to eq(general_info.userKey)
        end 

        it 'search with valid parameters and height and dress size not in range' do
            general_info = GeneralInfo.create(first_name: 'John', last_name: 'Johns', city: 'Houston', state: 'Texas', country: 'United States', company: 'test company', industry: 'Creator', highlights: 'test', emailaddr: 'abcd@email.com', userKey: SecureRandom.hex(10), specific_profile_id: 2)
            described_class.create({:user_key => general_info.userKey, :height_feet => 0, :height_inches => 0, :bust => 36, :waist => 24, :hips => 36, :cups => "C", :dress_size => 0, :hair_color => "black", :eye_color => "brown", :ethnicity => "English", :skin_color => "white", :shoot_nudes => "no", :experience => "5 years", :genre => "Acting"})
            params = {"checkboxes" => ["Acting"], "min_height" => "5.0", "max_height" => "6.0", "min_dress_size" => "2", "max_dress_size" => "10"}
            final_return = SpecificModel.search params
            expect(final_return).to be_empty
        end

        it 'search without valid parameters' do
            general_info = GeneralInfo.create(first_name: 'John', last_name: 'Johns', city: 'Houston', state: 'Texas', country: 'United States', company: 'test company', industry: 'Creator', highlights: 'test', emailaddr: 'abcd@email.com', userKey: SecureRandom.hex(10), specific_profile_id: 2)
            described_class.create({:user_key => general_info.userKey, :height_feet => 5, :height_inches => 5, :bust => 36, :waist => 24, :hips => 36, :cups => "C", :dress_size => 8, :hair_color => "black", :eye_color => "brown", :ethnicity => "English", :skin_color => "white", :shoot_nudes => "no", :experience => "5 years", :genre => "Acting"})
            params = {"test" => "test"}
            final_return = SpecificModel.search params
            expect(final_return).to be_empty
        end

        it 'search without parameters' do
            general_info = GeneralInfo.create(first_name: 'John', last_name: 'Johns', city: 'Houston', state: 'Texas', country: 'United States', company: 'test company', industry: 'Creator', highlights: 'test', emailaddr: 'abcd@email.com', userKey: SecureRandom.hex(10), specific_profile_id: 2)
            params = {}
            final_return = SpecificModel.search params
            expect(final_return[0]).to eq(general_info.userKey)
        end
    end 

    describe 'attribute_values' do
        it 'attribute_values' do
            specific_model = described_class.create({:height_feet => 5, :height_inches => 5, :bust => 36, :waist => 24, :hips => 36, :cups => "C", :dress_size => 8, :hair_color => "black", :eye_color => "brown", :ethnicity => "English", :skin_color => "white", :shoot_nudes => "no", :experience => "5 years", :genre => "Acting"})
            specific_model.attribute_values
        end
    end
end