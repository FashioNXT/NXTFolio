# lib/tasks/reset_countries.rake

require 'json'

namespace :db do
    desc "Drop the Country, State, and City table and reseed it"
    task reset_countries: :environment do
        puts "Clearing tables..."
        City.delete_all
        State.delete_all
        Country.delete_all
        
        filename = "countries+states+cities.json"
        puts "Seeding countries/states/cities from #{filename}"

        countries_data = File.read(Rails.root.join('db', 'seed_files', filename))
        countries = JSON.parse(countries_data)

        num_countries = countries.length
        Country.transaction do
            countries.each_with_index do |country, idx|
                print "\rCountry #{idx} of #{num_countries}"
                STDOUT.flush

                # phone_code = country['phone_code']
                # phone_code = phone_code.start_with?("+") ? phone_code[1..-1] : phone_code

                # create country
                country_obj = Country.create!(
                name: country['name'],
                iso3: country['iso3'],
                # phone_code: phone_code,
                capital: country['capital'],
                currency: country['currency'],
                region: country['region'],
                subregion: country['subregion'],
                latitude: country['latitude'],
                longitude: country['longitude'],
                )

                # create each of the states
                country['states'].each do |state|
                state_obj = country_obj.states.create!(
                    name: state['name'],
                    state_code: state['state_code'],
                    latitude: state['latitude'],
                    longitude: state['longitude'],
                )

                # create each city
                state['cities'].each do |city|
                    state_obj.cities.create!(
                    name: city['name'],
                    latitude: city['latitude'],
                    longitude: city['longitude'],
                    )
                end
                end
            end
        end
    end
end
