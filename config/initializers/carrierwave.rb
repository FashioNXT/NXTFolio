#require_relative 'config/initializers/carrierwave'
#require_relative 'config/initializers/database'

CarrierWave.configure do |config|
  
  # Use local storage if in development or test
  if Rails.env.development? || Rails.env.test?
    CarrierWave.configure do |config|
      config.storage = :file
    end
  end
  
  # Use AWS storage if in production
  if Rails.env.production?
    CarrierWave.configure do |config|
      config.storage = :fog
    end
  end
  
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    :provider               => 'AWS',                             # required
    :aws_access_key_id      => ENV["AWS_ACCESS_KEY"],            # required
    :aws_secret_access_key  => ENV["AWS_SECRET_KEY"],     # required
    :region                 => ENV["AWS_REGION"]                        # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = ENV["AWS_BUCKET"]                       # required
  #config.fog_host       = 'https://assets.example.com'           # optional, defaults to nil
  #config.fog_public     = false                                  # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end

# CarrierWave.configure do |config|
#   config.ignore_integrity_errors = false
#   config.ignore_processing_errors = false
#   config.ignore_download_errors = false

#   if ENV.has_key? 'AWS_ACCESS_KEY' and ENV.has_key? 'AWS_SECRET_KEY'
#     config.fog_provider = 'fog/aws'
#     config.fog_credentials = {
#       provider: 'AWS',
#       aws_access_key_id: ENV['AWS_ACCESS_KEY'],
#       aws_secret_access_key: ENV['AWS_SECRET_KEY'],
#       region: ENV["AWS_REGION"]
#     }
#     config.storage = :fog
#     config.fog_directory = ENV["AWS_BUCKET"]
#     config.cache_dir = "#{Rails.root}/tmp/uploads"
    
#   elsif Rails.env.test? || Rails.env.development?
#       puts "Image Host: local filesystem"
#       config.storage = :file
#       config.enable_processing = false
#       config.root = "#{Rails.root}/tmp"
#   else
#     #puts "Image Host: AWS"
#     #config.fog_provider = 'fog/aws'
#     puts "Image Host: local filesystem"
#     config.storage = :file
#     config.enable_processing = false
#     config.root = "#{Rails.root}/tmp"
#   end
# end
