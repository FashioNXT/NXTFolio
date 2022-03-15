CarrierWave.configure do |config|
  config.ignore_integrity_errors = false
  config.ignore_processing_errors = false
  config.ignore_download_errors = false

  if ENV.has_key? 'AWS_ACCESS_KEY' and ENV.has_key? 'AWS_SECRET_KEY'
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY'],
      aws_secret_access_key: ENV['AWS_SECRET_KEY'],
      region: ENV["AWS_REGION"]
    }
    config.fog_directory = ENV["AWS_BUCKET"]
    config.cache_dir = "#{Rails.root}/tmp/uploads"
    
  elsif Rails.env.test? || Rails.env.development?
      puts "Image Host: local filesystem"
      config.storage = :file
      config.enable_processing = false
      config.root = "#{Rails.root}/tmp"
  else
    puts "Image Host: AWS"
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  end
end
