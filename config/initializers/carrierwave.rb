CarrierWave.configure do |config|
  config.ignore_integrity_errors = false
  config.ignore_processing_errors = false
  config.ignore_download_errors = false


  if ENV['S3_KEY'] and ENV['S3_SECRET']
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['S3_KEY'],
      aws_secret_access_key: ENV['S3_SECRET'],
    }
    config.fog_directory = 'fashionnxt-test'
  else
    config.storage = :file
  end

  config.cache_dir = "#{Rails.root}/tmp/uploads"
end
