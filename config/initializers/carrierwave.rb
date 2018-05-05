CarrierWave.configure do |config|
  config.ignore_integrity_errors = false
  config.ignore_processing_errors = false
  config.ignore_download_errors = false

  if ENV.has_key? 'S3_KEY' and ENV.has_key? 'S3_SECRET'
    puts "Image Host: AWS"
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['S3_KEY'],
      aws_secret_access_key: ENV['S3_SECRET'],
    }
    config.fog_directory = 'fashionnxt-test'
    config.storage = :fog
  else
    puts "Image Host: local filesystem"
    config.storage = :file
  end

  config.cache_dir = "#{Rails.root}/tmp/uploads"
end
