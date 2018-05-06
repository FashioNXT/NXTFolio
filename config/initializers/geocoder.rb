if ENV.has_key? "GOOGLE_KEY"
	puts "Geocoding: Enabled"
	google_api_key = ENV["GOOGLE_KEY"]
else
	puts "Geocoding: Disabled"
	google_api_key = nil
end

Geocoder.configure(
	timeout: 15,
	use_https: true,
	api_key: google_api_key
)
